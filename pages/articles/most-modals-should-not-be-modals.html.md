---
title: Most modals shouldn't be modals
date: September 8, 2026
description: modalzmodalzmodalz.com made the case years ago. Now the platform has popover and dialog, so the excuse for a div-and-JavaScript modal is gone.
accent: magenta
sprite: dialog
treatment: spec
---

There's a website called [modalzmodalzmodalz.com](https://modalzmodalzmodalz.com/)
whose entire thesis is in the domain. We use too many damn modals. Let's just
not.

It's worth reading in full, but the argument is roughly: a modal is what you
reach for when you haven't decided where something goes. It becomes an
interaction junk drawer. And it isn't free — it blocks the page underneath, it's
hard to escape, it's rough on small screens, it piles on cognitive load, and the
hand-rolled ones are usually a mess for anyone not using a mouse.

That last part is the one I keep running into. A modal has real requirements: it
has to trap focus, send focus somewhere sensible on open, put it back where it
came from on close, close on <kbd>Esc</kbd>, close on a click outside, and mark
the rest of the page as inert so a screen reader doesn't wander into it. Almost
nobody implements all seven. So you get a `<div>` with a dark background and an
`overflow: hidden` on `<body>`, and a keyboard user gets a trap with no exit.

## The part that's changed

modalzmodalzmodalz has been up for years, and back then "just don't" was most of
the available advice, because the alternative was writing all seven of those
behaviors yourself.

That's not true anymore. The platform grew the missing pieces, and they're
declarative.

**If it doesn't need to block the page, use `popover`.** It's an attribute. That's
the whole API:

```html
<button popovertarget="details">Shipping details</button>

<div id="details" popover>
  <p>Ships in 2–3 days from Oakland.</p>
  <button popovertarget="details" popovertargetaction="hide">Close</button>
</div>
```

No JavaScript. The browser promotes it to the top layer so it isn't trapped by a
parent's `overflow` or `z-index`, closes it on <kbd>Esc</kbd>, closes it when you
click outside ("light dismiss"), moves focus into it and back out again, and
gives you `::backdrop` to style. Every behavior in that list is one somebody used
to hand-write, badly.

Here it is running. No script on this page:

<div class="demo">
  <button popovertarget="shipping" class="demo__btn">Shipping details</button>
  <div id="shipping" popover class="demo__pop">
    <p>Ships in 2–3 days from Oakland.</p>
    <button popovertarget="shipping" popovertargetaction="hide" class="demo__btn">Close</button>
  </div>
</div>

Press <kbd>Esc</kbd>, or click anywhere outside it. Nobody wrote that.

**If it genuinely must block, use `<dialog>`.** A real modal — the kind where
continuing without answering makes no sense — is `<dialog>`, which gets focus
trapping and inerting of the background for free. It needs one line of script to
open (`showModal()`), but it closes declaratively:

```html
<dialog id="confirm">
  <form method="dialog">
    <p>Delete this order?</p>
    <button value="cancel">Cancel</button>
    <button value="delete">Delete</button>
  </form>
</dialog>
```

`method="dialog"` is the nice bit — submitting the form closes the dialog and
hands you the value of the button that did it, no event listeners involved.

## So the question got easier

It used to be "is this worth the accessibility debt I'm about to take on?" Now
it's just: does this need to block the page?

If no, it's a `popover` and you wrote zero JavaScript. If yes, it's a `<dialog>`
and you wrote one line. And if the honest answer is "it doesn't need to be either
of those, I just didn't know where to put it" — that's the junk drawer, and
modalzmodalzmodalz already told you what to do about it.

## A confession

The first version of this site put its own manifesto in a `popover` — the "why
this exists" page you get from the tile in the corner. Technically defensible:
it's not a `<dialog>`, it doesn't block, it light-dismisses.

It was still wrong, and for the exact reason this whole genre of complaint
exists. That manifesto is the most important writing here. In an overlay it had
no URL, so you couldn't link to it or send it to anyone. The back button didn't
close it. A crawler never saw it. I hadn't decided where it went, so I made it
pop up — which is the junk drawer, precisely as described.

It's a page now, at [/why](/why). That's what it always should have been.

The rule survives the embarrassment intact: a `popover` is a great answer for
shipping details, and a bad answer for a document.
