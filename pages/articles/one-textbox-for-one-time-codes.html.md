---
title: One textbox for one-time codes
date: September 8, 2026
---

I buy my green coffee from Sweet Maria's. I like Sweet Maria's — good beans,
good people, been ordering from them for years. So take this as a bug report
from a happy customer, not a dunk.

Signing in goes like this. They email me a six digit code, then ask me to type
it into six separate boxes:

![Six single-character boxes for a six digit login code, above the error "Couldn't sign you in."](/images/six-box-one-time-code.png)

Six inputs for one value. And then it didn't work anyway.

I get the appeal. Six boxes *look* like a code. But you don't need six inputs and
a pile of JavaScript to get that look. It's one HTML5 field with constraints on
it, and some CSS.

## The field

```html
<label for="code">Enter code</label>
<input
  id="code"
  name="code"
  type="text"
  inputmode="numeric"
  pattern="[0-9]{6}"
  maxlength="6"
  size="6"
  placeholder="______"
  autocomplete="one-time-code"
  title="Six digits from your email"
  required>
```

That's the whole control. No JavaScript. Each attribute is buying something the
six box version has to hand-roll:

- `pattern="[0-9]{6}"` and `required` are the validation. The browser refuses to submit and shows its own message — and `title` is the text it puts in that bubble. This is constraint validation; it's been in every browser for over a decade.
- `maxlength="6"` stops at six characters, the same job all that per-box focus juggling was doing.
- `autocomplete="one-time-code"` is the one people leave off. It tells Safari and Chrome this field is a login code, so they offer the code from the incoming email or SMS as a one-tap fill. Six boxes can't receive that suggestion — which means the fancy version is *slower* on a phone, the exact place typing hurts most.
- `inputmode="numeric"` brings up the number pad without lying about the type. Skip `type="number"` — a code isn't a quantity, and you'd inherit spinners, scroll-wheel edits, and a browser that happily accepts `5e6`.
- `placeholder="______"` is six underscores, which shows the shape of what you want. Cheap trick, works. Fair warning: a placeholder only shows while the field is empty, so it's a hint about length, not a running progress bar.

And you keep everything you got for free and were about to throw away: paste
lands all six digits instead of one, backspace works, the value arrives as
`params[:code]` instead of six fields you reassemble on the server, and a screen
reader announces one labeled field instead of six unlabeled ones.

## Can you control the width?

Yes, two ways.

In HTML, `size="6"` sets the width in characters. It's the oldest attribute in
the box and it still works.

In CSS you get the real control, because `ch` is a unit — the width of a `0` in
the current font. Set a monospace font, space the characters out, and make the
field exactly as wide as its contents:

```css
input[name="code"] {
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  font-size: 2rem;
  letter-spacing: 0.5em;
  text-indent: 0.5em;
  width: calc(6ch + 3em);
  text-align: center;
}
```

`width: calc(6ch + 3em)` is just the arithmetic: six characters, plus the
`0.5em` of letter-spacing that each one drags along. The `text-indent` is
covering for a quirk — letter-spacing adds space *after* the last character too,
which drags the text half a slot left of center, so you nudge it back.

Here it is, live. Paste six digits into it:

<form class="demo" method="get" action="#">
  <label for="demo-code">Enter code</label>
  <input
    id="demo-code"
    name="code"
    type="text"
    inputmode="numeric"
    pattern="[0-9]{6}"
    maxlength="6"
    placeholder="______"
    autocomplete="one-time-code"
    title="Six digits from your email"
    required>
  <button type="submit">Sign in</button>
</form>

Try submitting it with four digits. That error is the browser's, not mine.

If you want the literal boxes, keep going — a `repeating-linear-gradient`
background under the same field draws six underlines, and
`:user-invalid` colors it red only *after* someone's actually had a go at it,
rather than screaming at an empty form:

```css
input[name="code"]:user-invalid {
  color: crimson;
  outline-color: crimson;
}
```

The point isn't that boxes are bad. It's that they're a paint job, and you can
paint them onto a control that already works.

So: Sweet Maria's, if you ever read this, that's the whole fix. Delete a few
hundred lines of JavaScript, ship one `<input>`, and I'll get back to buying
coffee a little faster.
