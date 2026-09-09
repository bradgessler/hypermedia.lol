---
title: Modals Are Broken by Design. The Spec Says So.
date: September 8, 2026
byline: Brad Gessler
byline_url: https://bradgessler.com
description: The answer to a modal usually isn't a better modal. It's a page on the server, with a real URL, the actual data, and room for a challenge.
accent: magenta
sprite: dialog
treatment: modalz
span: wide
og_image: /images/og/most-modals-should-not-be-modals.png
---

There's a website called [modalzmodalzmodalz.com](https://modalzmodalzmodalz.com/)
whose entire thesis is in the domain. We use too many damn modals. Let's just
not.

It's worth reading in full, but the argument is roughly: a modal is what you
reach for when you haven't decided where something goes. It becomes an
interaction junk drawer. And it isn't free: it blocks the page underneath, it's
hard to escape, it's rough on small screens, it piles on cognitive load, and the
hand-rolled ones are usually a mess for anyone not using a mouse.[^modalz]

The research side says the same thing more politely. Nielsen Norman Group's
guidance is that a modal is justified for a critical error, an irreversible
action, or information the task can't continue without, and that everything
else pays an interruption cost the user didn't ask for.[^nng] The common case,
the settings panel or the newsletter prompt, is on their do-not list.

That last part is the one I keep running into. A modal has real requirements: it
has to trap focus, send focus somewhere sensible on open, put it back where it
came from on close, close on <kbd>Esc</kbd>, close on a click outside, and mark
the rest of the page as inert so a screen reader doesn't wander into it. Almost
nobody implements all seven. So you get a `<div>` with a dark background and an
`overflow: hidden` on `<body>`, and a keyboard user gets a trap with no exit.

## The answer is usually a route, not a better overlay
<p class="dek">Give the confirmation a URL and render it on the server.</p>

The usual next move is to reach for a better overlay. The platform grew good
ones, and I'll get to them, but they're the second answer, and leading with them
skips the first.

Most of the time the thing you want is **a page on the server.**

A confirmation is a resource. Give it a route, render it, post back to it:

```
GET  /websites/:id/delete_confirmation   → the page
POST /websites/:id/delete_confirmation   → do it
```

That's the whole architecture. Nothing clever, and it buys you four things an
overlay structurally cannot.

**It knows what it's deleting.** A modal written in markup can say "Are you sure?"
because that's all it knows at authoring time. A server-rendered page ran a query
on the way in, so it can say what goes:

```html
<p>The following will be deleted:</p>
<ul>
  <li>example.com website</li>
  <li>412 pages</li>
  <li>1,209 caches</li>
</ul>
```

Those numbers are the difference between someone clicking through on reflex and
someone stopping. You can't hardcode them.

**It can ask for something.** The strongest confirmation isn't a button, it's a
challenge. Make them type the name of the thing. This is how GitHub deletes a
repository: a dedicated settings page, a Danger Zone, and a text box you have to
type the repository's name into before the button does anything.[^github] Nobody
has ever accidentally deleted a repository through that flow, and it has never
once been a modal.

```html
<label for="confirm">Type <strong>example.com</strong> to confirm</label>
<input id="confirm" name="domain_confirmation" autocomplete="off" required>
<button>Delete this website</button>
```

And then validate it *on the server*, where the real value lives. Get it wrong
and the page re-renders with the error attached to the field. That's a form doing
a form's job. No client state machine, no disabled-button logic, nothing to keep
in sync.

Here's the shape of that page, live. The only thing standing in for the server
is a `pattern` on the input, which is enough to feel it:

<figure class="step">
<form class="confirm" method="get" action="#confirm-demo" id="confirm-demo">
  <p class="confirm__head">Delete <strong>example.com</strong>?</p>
  <p>The following will be deleted:</p>
  <ul>
    <li>example.com website</li>
    <li>412 pages</li>
    <li>1,209 caches</li>
  </ul>
  <label for="confirm-name">Type <strong>example.com</strong> to confirm</label>
  <input id="confirm-name" name="domain_confirmation" autocomplete="off" required pattern="example\.com" title="Type example.com exactly">
  <div class="confirm__actions">
    <a href="#confirm-demo">Cancel</a>
    <button type="submit">Delete this website</button>
  </div>
</form>
<figcaption>A confirmation page, not a modal. It knows what it's deleting, it demands the name, and it has a URL. Type the wrong thing and press Delete: the refusal you get is the browser's.</figcaption>
</figure>

**It has a URL.** You can link to it, bookmark it, hit back, refresh it, screenshot
it in a bug report. Someone can open it, go read something else, and come back. An
overlay has none of that, because it isn't anywhere.

**It's the whole screen.** Which sounds like the downside and is the
point: a full-width page has no responsive problem to solve. No positioning
against a viewport that keeps changing, no scroll locking, no what-happens-on-a-
short-landscape-phone. It's a page. Pages already work at every size.

## Modals stop composing the moment your app is embedded
<p class="dek">Two backdrops, two focus traps, one tab order. Pages don't have this problem.</p>

Here's the failure nobody designs for: **your app ends up inside someone else's app.**

Embedded in a webview. Rendered in an iframe on a partner's dashboard. Opened in
an in-app browser from a chat client. It happens to almost every product
eventually, and it's rarely your decision.

Now your modal opens *inside* their modal. Two backdrops. Two focus traps
fighting over the same tab order. Two escape-key handlers, one of which closes
the wrong thing. Your overlay positioned against a viewport that is itself a box
inside another box. There's no amount of care in your modal implementation that
fixes this, because the problem isn't your modal. It's that modals don't
compose, and that's by specification, not by accident. The HTML standard says a
document is blocked by a modal dialog only when that dialog is the topmost one in
*that document's* top layer, and the inertness it applies covers nodes connected
to that document.[^spec] An iframe is its own document. So the best-implemented
`<dialog>` in the world, opened inside an embed, blocks the embed and nothing
else, and paints inside the embed's box and nowhere else. The page around it
stays live. There is no attribute that fixes this.

Don't take the spec's word for it. Below is a partner dashboard. Inside it, in
an iframe, is your app. Click **Delete account** in your app.

<figure class="step">
<iframe class="embed" src="/demos/partner/" title="A partner dashboard embedding your app, which opens a modal dialog" loading="lazy"></iframe>
<figcaption>A real <code>&lt;dialog&gt;</code> opened with <code>showModal()</code>, inside an iframe, inside a page, inside this modal. It blocks your app. The dashboard's checkbox still works. This page still scrolls. That's the spec doing exactly what it says, and it's why your modal can't protect anything once you're embedded.</figcaption>
</figure>

Pages compose. A full-page confirmation inside a webview is a full-page
confirmation. It doesn't know or care that it's nested, because navigation is the
one thing every container already knows how to do.

## Use <code>popover</code> for what's transient and local
<p class="dek">Shipping details, a menu, a date picker. Not deleting an account.</p>

Some things are transient and local: shipping details next to a line
item, a date picker, a menu. For those the platform now has good answers, and
they're declarative.

**`popover` is an attribute.** That's the whole API:

```html
<button popovertarget="details">Shipping details</button>

<div id="details" popover>
  <p>Ships in 2–3 days from Oakland.</p>
  <button popovertarget="details" popovertargetaction="hide">Close</button>
</div>
```

Here it is running. No script on this page:

<div class="demo">
  <button popovertarget="shipping" class="demo__btn">Shipping details</button>
  <div id="shipping" popover class="demo__pop">
    <p>Ships in 2–3 days from Oakland.</p>
    <button popovertarget="shipping" popovertargetaction="hide" class="demo__btn">Close</button>
  </div>
</div>

Press <kbd>Esc</kbd>, or click anywhere outside it. Nobody wrote that. The browser
handles the top layer, light dismiss, focus, and `::backdrop`.

**`<dialog>` for the rare one that must block.** It gets focus trapping and
inerting free, needs one line to open, and closes declaratively. `method="dialog"`
submits, closes, and hands you the button's value with no listeners:[^dialog]

```html
<dialog id="confirm">
  <form method="dialog">
    <p>Discard this draft?</p>
    <button value="cancel">Cancel</button>
    <button value="discard">Discard</button>
  </form>
</dialog>
```

Here it is, open, with no script on this page at all. Click either button:

<figure class="step">
<dialog open class="demo__dialog" id="draft">
  <p>Discard this draft?</p>
  <form method="dialog">
    <button value="cancel" class="demo__btn">Cancel</button>
    <button value="discard" class="demo__btn">Discard</button>
  </form>
</dialog>
<figcaption>A <code>&lt;dialog open&gt;</code> and a <code>&lt;form method="dialog"&gt;</code>. Submitting closes it and records which button did it. Nobody wrote a listener. (Without <code>showModal()</code> it isn't modal, which is the honest limit of what markup alone can do; see the embed above for the modal version.)</figcaption>
</figure>

Use it for discarding a draft. Don't use it for deleting an account.

## The best case for the modal
<p class="dek">Steelman first. If a page is going to win, it should win against the strongest version of the overlay.</p>

**"A modal keeps the user in context."** For a small decision, yes, and that's
the case Nielsen Norman Group makes for it: an irreversible action deserves an
interruption.[^nng] But look at what context means for a consequential action.
It means knowing what you're about to destroy. A page ran a query on the way in
and can tell you; a modal knows what it knew when the markup was written.

**"A page is a navigation. That's slower."** A server-rendered confirmation is
one request that returns finished HTML. A modal that wants the same real numbers
makes the same request, waits for it, then renders on the client. Same round
trip, more moving parts, and the modal version has no URL to show for it.

**"Users understand modals."** They understand pages too. GitHub's delete flow is
a page with a typed challenge, and it is probably the most recognized
confirmation on the internet.[^github]

**"`<dialog>` solved the accessibility problem."** Inside one document, it
largely did, and that's why it's the right answer for a transient thing. The spec
scopes its blocking to the document it lives in,[^spec] which is the
guarantee that stops holding the moment your app is embedded. A page needs no
such guarantee, because a page doesn't try to block anything.

## Ask "can this be a page?" before anything else
<p class="dek">It almost always can.</p>

It used to be "is this worth the accessibility debt?" Then it was "which overlay
element?" It's neither:

**Can this be a page?** It almost always can. If it's consequential, needs real
data, wants a challenge, or might ever run inside someone else's app, it should
be.

Overlays are for things that are transient and local.
Everything else is a route you didn't write.

## I got this wrong on this very site
<p class="dek">The manifesto you're reading used to be an overlay.</p>

The first version of this site put its own manifesto in a `popover`, the "why
this exists" page you get from the box in the corner. Technically defensible:
it's not a `<dialog>`, it doesn't block, it light-dismisses.

It was still wrong, and for the exact reason this whole genre of complaint
exists. That manifesto is the most important writing here. In an overlay it had
no URL, so you couldn't link to it or send it to anyone. The back button didn't
close it. A crawler never saw it. I hadn't decided where it went, so I made it
pop up, which is the junk drawer, precisely as described.

It's a page now, at [/why](/why). That's what it always should have been, which
is the same conclusion as the rest of this article, arrived at the stupid way.

A `popover` is a great answer for shipping details, and a bad answer for a
document.

[^modalz]: [modalzmodalzmodalz.com](https://modalzmodalzmodalz.com/), which lists what most modals cost and the patterns that replace them.

[^nng]: Therese Fessenden, [Modal & Nonmodal Dialogs: When (& When Not) to Use Them](https://www.nngroup.com/articles/modal-nonmodal-dialog/), Nielsen Norman Group. Modals are justified for critical errors, irreversible actions and information the task can't continue without; the listed costs are interruption, lost context, and background content becoming inaccessible.

[^github]: GitHub Docs, [Deleting a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/deleting-a-repository): Settings, then the Danger Zone, then a series of acknowledgements, then typing the repository name to confirm.

[^spec]: WHATWG HTML Standard, [blocked by a modal dialog](https://html.spec.whatwg.org/multipage/interaction.html#blocked-by-a-modal-dialog). A document is blocked when a dialog is the topmost element in that document's top layer, and the blocking applies to nodes connected to that document. An iframe is a separate document with its own top layer.

[^dialog]: MDN, [`<dialog>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog) and the [Popover API](https://developer.mozilla.org/en-US/docs/Web/API/Popover_API). Both are supported in every current browser.
