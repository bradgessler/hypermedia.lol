---
title: Most modals shouldn't be modals
date: September 8, 2026
description: modalzmodalzmodalz.com made the case years ago. Now the platform has popover and dialog, so the excuse for a div-and-JavaScript modal is gone.
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
