---
title: One textbox for one-time codes
date: September 8, 2026
description: Websites build a six-digit login code like it's a nuclear launch console. Here's what that breaks, live, and the one HTML input that replaces all of it.
accent: hot
sprite: key
treatment: launch
span: big
---

<p class="brief">Your authorization code is <code class="copyable">561579</code>.
Tap it once to select it, then Copy. You will need it to launch. Do not write it
down. Do not share it with anyone. Especially not Sweet Maria's.<br><br>
<small>A one-tap copy button would be one line of JavaScript. This page has
zero, so it's two taps. Worth it.</small></p>

<div class="console console--six" data-mode="six">
  <div class="console__head">
    <span class="console__title">Authorization required</span>
    <span class="console__lights"><i></i><i></i><i></i></span>
  </div>
  <div class="console__sys">System: Sweet Maria's Green Coffee &nbsp;·&nbsp; Clearance: Buy beans</div>
  <form class="console__body" method="get" action="#six">
    <span class="console__label">Enter 6-digit launch code</span>
    <span class="console__keys">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 1 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 2 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 3 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 4 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 5 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required aria-label="Digit 6 of 6">
    </span>
    <span class="console__status">
      <span class="console__lamp"></span>
      <span class="console__state console__state--wait">Standby</span>
      <span class="console__state console__state--bad">Incomplete</span>
      <span class="console__state console__state--ok">Armed</span>
    </span>
    <button class="console__arm" type="submit">Arm</button>
  </form>
  <div class="console__foot">This is how most websites ask for a login code. Everything on this page is live. Nothing on this page is JavaScript.</div>
</div>

Paste your code into the console. One digit lands. The lamp stays red. Now
type two digits and press backspace twice — you're stuck in the second box,
because nothing walks you back.

That's a six-digit code to buy coffee, and it fails a paste.

## How it's usually built: six puppets and a shadow field
<p class="dek">The boxes you see aren't the input. They're a costume on top of one.</p>

<div class="shadow" aria-label="Diagram: six visible boxes wired by JavaScript to one hidden field">
  <div class="shadow__row">
    <span class="shadow__tag">What you see</span>
    <span class="shadow__boxes"><i>5</i><i></i><i></i><i></i><i></i><i></i></span>
  </div>
  <div class="shadow__row">
    <span class="shadow__tag">Held together by</span>
    <span class="shadow__glue"><span>input →</span><span>keydown →</span><span>paste →</span><span>focus →</span><span>blur →</span></span>
  </div>
  <div class="shadow__row">
    <span class="shadow__tag">What the server gets</span>
    <span class="shadow__hidden">&lt;input type="hidden" name="code" value="<b>5</b>"&gt;</span>
  </div>
</div>

Almost every one of these works the same way: a hidden "shadow" field holds the
real value, and the six visible boxes are puppets. JavaScript watches every
keystroke, joins the boxes into the shadow, and shuttles focus around to fake a
single field. It's the shape of the code you're signing up for:

```js
// The usual shape. Do not ship this. Every line is a place backspace can break.
boxes.forEach((box, i) => {
  box.addEventListener("input", () => {
    shadow.value = boxes.map(b => b.value).join("");
    if (box.value && boxes[i + 1]) boxes[i + 1].focus();
  });
  box.addEventListener("keydown", (e) => {
    if (e.key === "Backspace" && !box.value && boxes[i - 1]) boxes[i - 1].focus();
  });
  box.addEventListener("paste", (e) => { /* split the clipboard, distribute, pray */ });
});
```

Backspace is where it always goes wrong, because the browser's backspace only
knows about the box it's in. Everything else — moving back, deleting the previous
digit, doing both — has to be re-invented in that `keydown` handler. Get it
slightly wrong and you land in the box before but don't delete, or delete but
don't move, or jump two. Every implementation is slightly wrong in a different
way, and nobody tests it on a phone with autocorrect on.

None of that code exists in the version below.

That sketch isn't a strawman. It's the shape of the most-downloaded
implementation on the internet.

## The most popular library does exactly this — and turns autofill off
<p class="dek">react-otp-input: one input per digit, 274 lines, and <code>autoComplete: 'off'</code> hardcoded on every box.</p>

[react-otp-input](https://github.com/devfolioco/react-otp-input) is the
canonical React version — hundreds of thousands of downloads a week. Go break
it yourself on the [live demo](https://devfolioco.github.io/react-otp-input/):

1. Paste your code. Watch how it has to be split up and distributed.
2. Type two digits, press Backspace twice. Note which box you land in.
3. Open it on your phone and get a real code texted to you. Wait for the keyboard to offer it. It won't.

Step 3 isn't a bug they'll fix. Read the [source](https://github.com/devfolioco/react-otp-input/blob/main/src/index.tsx):
one `<input>` per digit, Backspace and arrow keys re-implemented in a `keydown`
handler, paste re-implemented in a `paste` handler — and every box rendered with
`autoComplete: 'off'`. The library that people reach for to build this
*deliberately disables* the one browser feature that makes a login code fast on
a phone, because with six fields there was nothing else it could do.

It's a competent implementation of a bad idea. 274 lines to reproduce one input,
minus the attribute that mattered most.

## The best library agrees: one real input, boxes painted on top
<p class="dek">input-otp — the one shadcn/ui ships — keeps a single <code>&lt;input&gt;</code> and draws the slots over it.</p>

[input-otp](https://github.com/guilhermerodz/input-otp) is the other way to do
it, and it's the way this article has been arguing for the whole time: it
renders exactly one real text input, makes it transparent, and lets you draw
whatever boxes you like on top. Its own README says six separate inputs lose
"SMS autofill, screen reader support, partial paste, undo, and half the
keyboard."

That's the entire thesis, stated by the people who built the good version.

So: if you're in React and you want the boxes, use that. And if you're not in
React, notice what it's actually doing — one input and some paint. You don't
need a dependency for that. The rest of this page is the paint.


## The same code. One input.
<p class="dek">Paste the same six digits here.</p>

<div class="console console--one">
  <div class="console__head">
    <span class="console__title">Authorization required</span>
    <span class="console__lights"><i></i><i></i><i></i></span>
  </div>
  <div class="console__sys">System: Sweet Maria's Green Coffee &nbsp;·&nbsp; Clearance: Buy beans</div>
  <form class="console__body" method="get" action="#one">
    <label class="console__label" for="one-code">Enter 6-digit launch code</label>
    <input
      id="one-code"
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
    <span class="console__status">
      <span class="console__lamp"></span>
      <span class="console__state console__state--wait">Standby</span>
      <span class="console__state console__state--bad">Incomplete</span>
      <span class="console__state console__state--ok">Armed</span>
    </span>
    <button class="console__arm" type="submit">Arm</button>
  </form>
  <div class="console__foot">Same console. Same drama. One <code>&lt;input&gt;</code>.</div>
</div>

All six digits land. Backspace works. On a phone, the browser offers the code
straight from your email. Submit it with four digits and the error you get is the
browser's.

Here is the entire control:

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

## What the six boxes actually break
<p class="dek">Every item is a thing the browser already did, on the left, until it was replaced.</p>

<div class="breaks">
  <div class="break">
    <span class="break__what">Paste</span>
    <span class="break__six">One digit lands. Five vanish.</span>
    <span class="break__one">All six land.</span>
    <span class="break__fix">You'd need a <code>paste</code> handler that splits the string and distributes it. Code that exists purely to undo the damage.</span>
  </div>
  <div class="break">
    <span class="break__what">Backspace</span>
    <span class="break__six">Stops dead in an empty box.</span>
    <span class="break__one">Deletes the last digit.</span>
    <span class="break__fix">You'd need a <code>keydown</code> handler. Then another for arrow keys. Then another for typing over a filled box. Most implementations get one right.</span>
  </div>
  <div class="break">
    <span class="break__what">Autofill</span>
    <span class="break__six">Gets one digit and a shrug.</span>
    <span class="break__one">One tap fills it from SMS or email.</span>
    <span class="break__fix">Safari and Chrome look for a single field marked <code>autocomplete="one-time-code"</code>. Six fields can't receive that suggestion — so the fancy version is slower on exactly the device where typing hurts most.</span>
  </div>
  <div class="break">
    <span class="break__what">Screen reader</span>
    <span class="break__six console__sr">"edit text, blank. edit text, blank. edit text, blank. edit text, blank. edit text, blank. edit text, blank."</span>
    <span class="break__one console__sr">"Enter code, edit text, required."</span>
    <span class="break__fix">That's a real transcript of what most six-box implementations announce, because they don't label the boxes. Someone using a screen reader now has a strictly harder time buying coffee than before the redesign.</span>
  </div>
  <div class="break">
    <span class="break__what">Password manager</span>
    <span class="break__six">Finds six anonymous fields.</span>
    <span class="break__one">Finds the field.</span>
    <span class="break__fix">It's looking for something to fill. You gave it a puzzle.</span>
  </div>
  <div class="break">
    <span class="break__what">The server</span>
    <span class="break__six"><code>code1</code> through <code>code6</code>, reassembled.</span>
    <span class="break__one"><code>params[:code]</code></span>
    <span class="break__fix">You're now parsing your own UI on the backend.</span>
  </div>
</div>

Add it up: a few hundred lines of JavaScript, a support burden, and a pile of
accessibility regressions — to make one textbox worse. Nobody decided to do
that. Nobody asked, either.

## Each attribute buys back one thing from that list
<p class="dek">No JavaScript. This is what the attributes are for.</p>

| Attribute | What it buys |
|---|---|
| `pattern="[0-9]{6}"` + `required` | Validation. The browser refuses to submit and shows its own message. `title` is the text in that bubble. |
| `maxlength="6"` | Stops at six. The job all that per-box focus juggling was doing. |
| `autocomplete="one-time-code"` | The one everybody leaves off. It's the signal that makes SMS and email autofill work. |
| `inputmode="numeric"` | Number pad on mobile without lying about the type. Not `type="number"` — a code isn't a quantity, and you'd inherit spinners and `5e6`. |
| `size="6"` | Width, in characters. Don't compute it. |
| `placeholder="______"` | Six underscores. Shows the shape. Only visible while empty, so it's a hint, not a progress bar. |

## The width is one attribute — don't compute it
<p class="dek">I tried the clever version first. It shipped three bugs.</p>

```css
/* Don't do this. */
input {
  letter-spacing: 0.5em;
  text-indent: 0.5em;
  width: calc(6ch + 3em);
  text-align: center;
}
```

`box-sizing: border-box` means that `width` is the *border* box, so padding eats
into it and the last digit clips. Centering text with a trailing letter-space
puts the placeholder and the value on different origins. And `ch` stops
predicting anything once you add spacing between characters.

Four declarations, three bugs, to do a job one attribute already does:

```css
input[name="code"] {
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  font-size: 1.9rem;
  text-align: left;
  padding: 0.45rem 0.65rem;
}
```

Monospace means `______` and `561579` are exactly the same width, with no
arithmetic. Left-aligned means they start at the same point. `size` handles the
rest.

## It was never a launch code
<p class="dek">Boxes are a paint job. Paint them on a control that works.</p>

The six boxes look serious. That's the whole appeal. But you can have the look
on top of one input — a monospace font and some padding get you most of it — and
keep paste, backspace, autofill, the password manager, and the screen reader.

Sweet Maria's, if you ever read this: that's the whole fix. Delete a few hundred
lines of JavaScript, ship one `<input>`, and I'll get back to buying coffee a
little faster.
