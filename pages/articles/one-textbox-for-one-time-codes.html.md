---
title: One textbox for one-time codes
date: September 8, 2026
description: Websites build a six-digit login code like it's a nuclear launch console. Here's what that breaks, live, and the one HTML input that replaces all of it.
accent: hot
sprite: key
treatment: launch
span: big
og_image: /images/og/one-textbox-for-one-time-codes.png
---

<p class="lede">By the end of this you'll be able to delete a few hundred lines of
JavaScript, replace them with one HTML attribute, and know what those lines
were breaking for everyone who wasn't you. It starts with coffee.</p>

I go to buy green coffee from Sweet Maria's. They don't do passwords. They
email me a magic code and I type it in. It arrives looking something like this:

<figure class="step">
<div class="message message--email" aria-label="Email from Sweet Maria's with your login code">
  <span class="message__from">From: Sweet Maria's <span class="message__time">just now</span></span>
  <span class="message__subject">Your Sweet Maria's sign-in code</span>
  <span class="message__body">Here's the code to finish signing in. It expires in 10 minutes.</span>
  <span class="message__code"><code class="copyable">561579</code></span>
  <span class="message__hint">If you didn't request this, you can ignore this email.</span>
</div>
<figcaption>The email, dramatized. The real one has more logo. Copy the code. You need it next.</figcaption>
</figure>

I copy the code and go back to the tab, where I'm supposed to paste it into
this. Somebody did a lot of work to an input field to get six little slots:

<figure class="step">
<div class="console console--six">
  <div class="console__head">
    <span class="console__title">Authorization required</span>
    <span class="console__lights"><i></i><i></i><i></i></span>
  </div>
  <div class="console__sys">System: Sweet Maria's Green Coffee &nbsp;·&nbsp; Clearance: Buy beans</div>
  <form class="console__body" method="get" action="#six">
    <span class="console__label">Enter 6-digit launch code</span>
    <span class="console__keys">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 1 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 2 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 3 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 4 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 5 of 6">
      <input type="text" inputmode="numeric" maxlength="1" size="1" pattern="[0-9]" required autocomplete="off" aria-label="Digit 6 of 6">
    </span>
    <input type="hidden" name="code" value="">
    <span class="console__wire">
      <span class="console__wire-label">Shadow field &middot; what the server gets</span>
      <code>code=""</code>
      <span class="console__wire-note">The boxes have no <code>name</code>. A script joins them into this hidden field on every keystroke. That script is running right now.</span>
    </span>
    <span class="console__status">
      <span class="console__lamp"></span>
      <span class="console__state console__state--wait">Standby</span>
      <span class="console__state console__state--bad">Incomplete</span>
      <span class="console__state console__state--ok">Armed</span>
    </span>
    <button class="console__arm" type="submit">Arm</button>
  </form>
  <div class="console__foot">Built the way these usually are: six boxes, auto-advance, a hidden field, and the JavaScript to hold it together. It's live so you can feel it.</div>
</div>
<figcaption>The sign-in screen. Paste the code and watch what happens. Then type two digits and press Backspace twice.</figcaption>
</figure>

One digit landed and five vanished. Backspace walked me back a box and left the
digit behind. The lamp never went green. And on my phone, the keyboard never
offered me the code, because every box has <code>autocomplete="off"</code>.
That's how the popular libraries ship it.

That's a six-digit code to buy coffee, and it fails a paste. So what did they
build?

<div class="verdict">
  <div class="verdict__col verdict__col--pro">
    <span class="verdict__head">What it gets right</span>
    <ul>
      <li>It looks like a code. Six slots, six digits. Nobody wonders what to type.</li>
      <li>Auto-advance feels fast when you type by hand.</li>
      <li>It reads as serious, which is why every auth screen has copied it.</li>
    </ul>
  </div>
  <div class="verdict__col verdict__col--con">
    <span class="verdict__head">What it breaks</span>
    <ul>
      <li>Paste. Backspace. Autofill. The screen reader. The password manager.</li>
      <li>The server, which now reads a hidden field a script has to keep honest.</li>
      <li>Every one of those was working before the boxes showed up.</li>
    </ul>
  </div>
</div>


## How it's built
<p class="dek">Six puppets over one hidden field, held together by event handlers. Here it is, and here's the shape of the code.</p>

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

Caption: <b>How it's built.</b> The usual shape, hand-rolled everywhere. Do not ship this. Every line is a place Backspace can break.

Backspace is where it always goes wrong, because the browser's backspace only
knows about the box it's in. Moving back, deleting the previous digit, or doing both all has to be
re-invented in that `keydown` handler. Get it
slightly wrong and you land in the box before but don't delete, or delete but
don't move, or jump two. Every implementation is slightly wrong in a different
way, and nobody tests it on a phone with autocorrect on.

None of that code exists in the fix.

That sketch is the shape of the most-downloaded implementation on the
internet.

## The most popular library builds it exactly this way
<p class="dek">react-otp-input: one input per digit, 274 lines, and <code>autoComplete: 'off'</code> hardcoded on every box.</p>

[react-otp-input](https://github.com/devfolioco/react-otp-input) is the
canonical React version, at hundreds of thousands of downloads a week. Go break
it yourself on the [live demo](https://devfolioco.github.io/react-otp-input/):

1. Paste your code. Watch how it has to be split up and distributed.
2. Type two digits, press Backspace twice. Note which box you land in.
3. Open it on your phone and get a real code texted to you. Wait for the keyboard to offer it. It won't.

Step 3 isn't a bug they'll fix. Read the [source](https://github.com/devfolioco/react-otp-input/blob/main/src/index.tsx):
one `<input>` per digit, Backspace and arrow keys re-implemented in a `keydown`
handler, paste re-implemented in a `paste` handler, and every box rendered with
`autoComplete: 'off'`. The library that people reach for to build this
*deliberately disables* the one browser feature that makes a login code fast on
a phone, because with six fields there was nothing else it could do.

It's a competent implementation of a bad idea.[^rotp] 274 lines to reproduce one
input, minus the attribute that mattered most.



## Even the best library needs 767 lines to hide one input
<p class="dek">input-otp, the one shadcn/ui ships, keeps one real <code>&lt;input&gt;</code> and paints it invisible. Then it has to fake everything the browser stopped drawing.</p>

You've felt the bad version. Now the good one.
[input-otp](https://github.com/guilhermerodz/input-otp) is the best OTP
component in the React ecosystem, and it gets the big thing right: it renders
exactly one real text input, makes it transparent, and draws the boxes on top.
Its own README says six separate inputs lose "SMS autofill, screen reader
support, partial paste, undo, and half the keyboard."

Now look at what it costs to hide an input and keep it working. From the
[source](https://github.com/guilhermerodz/input-otp/tree/master/packages/input-otp/src):

- **598 lines** in the core component. The browser's caret is invisible now, so there's a fake one. Selection is invisible, so `selectionStart` is tracked by hand and `setSelectionRange` is called to keep it honest. Three `ResizeObserver`s keep the painted boxes lined up with the real field underneath. Six special cases for iOS and Safari.
- **169 more lines** in a hook whose only job is password managers. 1Password, LastPass, Dashlane and Bitwarden each inject a badge into the input. The input is invisible, so the badge lands in a clipped region. The hook sniffs each manager by the DOM it injects, and grows the field forty pixels to make room.

That's the *best* implementation. 767 lines, four password managers detected by
selector, a caret drawn by hand, all so one input can look like six boxes.
Every line of it is repair work for one decision: hiding the input.

You don't have to hide the input. Keep going.


## The best case for the boxes
<p class="dek">Steelman first. If one input is going to win, it should win against the strongest version of six.</p>

**"The boxes tell you it's six digits."** They do, and that's a real
advantage. A blank field is a question; six slots are an answer. But the shape
is paint. `placeholder="______"` shows the length, `maxlength="6"` enforces it,
and a label can say "6-digit code" in words. input-otp is the existence proof:
one real input, six painted slots, and nobody can tell.[^iotp]

**"Auto-advance is faster."** It *feels* faster. Count keystrokes. One field,
six digits: six keystrokes, done. Six boxes, six digits: six keystrokes, and
auto-advance exists so it isn't twelve. It's a fix for a cost the boxes
introduced. The fast path is one tap, with the code offered from your
messages, and that's the path the boxes close.[^webdev]

**"Segmented inputs test better."** Some guides say so, for codes up to eight
digits.[^ux] Read the same guide's checklist for doing it properly: distribute a
paste across the boxes, walk Backspace backwards, put
`autocomplete="one-time-code"` on the first box and split whatever lands there,
wrap it all in `<fieldset>` and `<legend>`, label every box, announce errors with
`aria-live`. Six requirements, each re-implementing something one input does by
default. Do all six and you've rebuilt input-otp. Skip the first and you've
failed WCAG.[^wcag]

**"We handle autofill on the first box."** Some do. The browser drops all six
digits into box one, `maxlength` truncates to a single digit, and a handler races
to catch the value before that happens and spread it out. It's the shadow field
again: intercept the browser so you can redo what it did. It works until it
doesn't, and when it doesn't, the person on the other end is trying to buy
coffee.

**"Accessibility can be handled."** It can, at the cost above. But the floor
is written down now. WCAG 2.2 treats an authentication step that
makes you transcribe something as a cognitive function test, allowed only if
paste works and password managers can fill the field.[^wcag] Six boxes that eat
a paste fail Level AA. One input passes by doing nothing.

So the strongest case for the boxes reduces to the look. You can keep the look.

## What should have been waiting for you
<p class="dek">One input. Every attribute is doing a job the script used to.</p>

<figure class="step">
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
    <span class="console__wire">
      <span class="console__wire-label">What the server gets</span>
      <code>code=561579</code>
      <span class="console__wire-note">Whatever you typed. The input has a <code>name</code>. There is nothing to join, and nothing here is JavaScript.</span>
    </span>
    <span class="console__status">
      <span class="console__lamp"></span>
      <span class="console__state console__state--wait">Standby</span>
      <span class="console__state console__state--bad">Incomplete</span>
      <span class="console__state console__state--ok">Armed</span>
    </span>
    <button class="console__arm" type="submit">Arm</button>
  </form>
  <div class="console__foot">Same console. Same drama. One <code>&lt;input&gt;</code>. No script.</div>
</div>
<figcaption>What should have been waiting for you. Paste the same code.</figcaption>
</figure>

All six digits land. Backspace deletes the last one. On a phone, the browser
offers the code straight from your email. Submit it with four digits and the
error you get is the browser's.

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

Caption: <b>The fix.</b> The entire control. No script. Every attribute is doing a job the script used to.

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
    <span class="break__fix">Safari and Chrome look for a single field marked <code>autocomplete="one-time-code"</code>. Six fields can't receive that suggestion, so the fancy version is slower on the one device where typing hurts most.</span>
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
accessibility regressions, all to make one textbox worse. Nobody decided to do
that. Nobody asked, either.

## Each attribute buys back one thing from that list
<p class="dek">No JavaScript. This is what the attributes are for.</p>

| Attribute | What it buys |
|---|---|
| `pattern="[0-9]{6}"` + `required` | Validation. The browser refuses to submit and shows its own message. `title` is the text in that bubble. |
| `maxlength="6"` | Stops at six. The job all that per-box focus juggling was doing. |
| `autocomplete="one-time-code"` | The one everybody leaves off. It's the signal that makes SMS and email autofill work.[^apple] |
| `inputmode="numeric"` | Number pad on mobile without lying about the type. Not `type="number"`: a code isn't a quantity, and you'd inherit spinners and `5e6`.[^webdev] |
| `size="6"` | Width, in characters. Don't compute it. |
| `placeholder="______"` | Six underscores. Shows the shape. Only visible while empty, so it's a hint, not a progress bar. |

## The width is one attribute. Don't compute it.
<p class="dek">I tried the clever version first. It shipped three bugs.</p>

```css
input {
  letter-spacing: 0.5em;
  text-indent: 0.5em;
  width: calc(6ch + 3em);
  text-align: center;
}
```

Caption: <b>Don't.</b> The clever version: four declarations, three bugs. It clips the last digit and puts the placeholder on a different origin than the value.

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

Caption: <b>Do.</b> Monospace, left-aligned, padding. <code>size</code> handles the width.

Monospace means `______` and `561579` are exactly the same width, with no
arithmetic. Left-aligned means they start at the same point. `size` handles the
rest.

## It was never a launch code
<p class="dek">Boxes are a paint job. Paint them on a control that works.</p>

The six boxes look serious. That's the whole appeal. But you can have the look
on top of one input. A monospace font and some padding get you most of it, and
you keep paste, backspace, autofill, the password manager, and the screen
reader.

Sweet Maria's, if you ever read this: that's the whole fix. Delete a few hundred
lines of JavaScript, ship one `<input>`, and I'll get back to buying coffee a
little faster.


[^wcag]: WCAG 2.2, Success Criterion 3.3.8 *Accessible Authentication (Minimum)*, Level AA. The [Understanding document](https://www.w3.org/WAI/WCAG22/Understanding/accessible-authentication-minimum.html) lists preventing copy and paste as a failure, and requires that browsers and third-party password managers be able to fill the field.

[^webdev]: Google's own guidance, [SMS OTP form best practices](https://web.dev/articles/sms-otp-form): a single `<input>` with `type="text"`, `inputmode="numeric"`, `autocomplete="one-time-code"` and a `pattern`. It also warns off `type="number"`, whose spinner buttons can strip leading zeros from a code.

[^apple]: Safari has offered the code from an incoming SMS to a field marked `autocomplete="one-time-code"` since Safari 12 on iOS, iPadOS and macOS. Chrome, Opera and Vivaldi on Android do it programmatically with the [WebOTP API](https://developer.chrome.com/docs/identity/web-apis/web-otp), which needs HTTPS, a script, and an SMS ending in `@yourdomain #code`. Both are built for one field.

[^ux]: [Code Confirmation Pattern](https://uxpatterns.dev/patterns/forms/code-confirmation) at uxpatterns.dev argues for segmented inputs, then lists everything you must rebuild for them to work. The checklist is the argument against.

[^rotp]: [react-otp-input, `src/index.tsx`](https://github.com/devfolioco/react-otp-input/blob/main/src/index.tsx): 274 lines, one input per digit, Backspace and paste re-implemented in handlers, `autoComplete: 'off'` on every box.

[^iotp]: [input-otp, `packages/input-otp/src`](https://github.com/guilhermerodz/input-otp/tree/master/packages/input-otp/src): `input.tsx` is 598 lines; `use-pwm-badge.tsx` is 169 lines spent detecting 1Password, LastPass, Dashlane and Bitwarden by the DOM they inject, to make room for a badge on an invisible input.

<script>
  // The JavaScript on this page, all of it, annotated.
  //
  // 1. The six-box pattern, written the way it usually is. It runs so you can
  //    feel it break. This is the code the article is arguing against.
  (() => {
    const six = document.querySelector(".console--six");
    if (!six) return;
    const boxes = [...six.querySelectorAll(".console__keys input")];
    const shadow = six.querySelector('input[name="code"]');
    const wire = six.querySelector(".console__wire > code");
    const sync = () => {
      shadow.value = boxes.map((b) => b.value).join("");
      wire.textContent = `code="${shadow.value}"`;
    };
    boxes.forEach((box, i) => {
      box.addEventListener("input", () => {
        box.value = box.value.replace(/\D/g, "").slice(-1);
        sync();
        if (box.value && boxes[i + 1]) boxes[i + 1].focus();
      });
      box.addEventListener("keydown", (e) => {
        // The classic version: move back, but don't delete. You'll press it twice.
        if (e.key === "Backspace" && !box.value && boxes[i - 1]) boxes[i - 1].focus();
      });
      // No paste handler. Most hand-rolled versions don't have one either.
    });
  })();

  // 2. A Copy button. The platform has no declarative clipboard, so this is
  //    JavaScript or nothing. It inserts itself; without scripts, tap-to-select
  //    still works and there's no dead button.
  if (navigator.clipboard) {
    document.querySelectorAll(".copyable").forEach((code) => {
      const button = document.createElement("button");
      button.type = "button";
      button.className = "copy";
      button.textContent = "Copy";
      button.addEventListener("click", async () => {
        await navigator.clipboard.writeText(code.textContent.trim());
        button.textContent = "Copied";
        setTimeout(() => (button.textContent = "Copy"), 1500);
      });
      code.after(button);
    });
  }
</script>