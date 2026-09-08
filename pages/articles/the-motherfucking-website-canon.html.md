---
title: The motherfucking website canon
date: September 8, 2026
description: A reading list. Four profane single-page manifestos that have been making the case for plain HTML and a little CSS for over a decade.
accent: sky
sprite: brick
---

Before there was a name for any of this, there was
[motherfuckingwebsite.com](https://motherfuckingwebsite.com/).

One page. Black text on white. No framework, no build step, no cookie banner, no
newsletter interstitial. The argument, delivered at a volume the domain prepares
you for, is that a plain HTML document is already responsive, already
accessible, already fast, and already works on every device anyone owns — and
that most of what gets layered on top is the designer creating problems and then
charging to solve them.

It's a joke that turned out to be right about almost everything.

The interesting part isn't that one page. It's that people kept answering it,
and the replies form an actual argument, in order.

## The canon, in sequence

**[motherfuckingwebsite.com](https://motherfuckingwebsite.com/)** — the thesis.
Use HTML. Your document is already fine.

**[bettermotherfuckingwebsite.com](https://bettermotherfuckingwebsite.com/)** —
the first rebuttal, and the most useful one. It concedes that the original is
genuinely unpleasant to read, and fixes it with a handful of CSS declarations:
line height, a measure you can track across, some margin, a grey that isn't
`#000`. The point being that "no framework" and "no typography" are different
claims, and only one of them was ever defensible.

**[perfectmotherfuckingwebsite.com](https://perfectmotherfuckingwebsite.com/)** —
raises the bid to ten declarations, a media query, and one attribute. The
attribute is `lang` on `<html>`, which is a genuinely good catch: without it a
screen reader may read your English page in the wrong language's voice. It also
picks up `prefers-color-scheme`, so it won't bleach your eyes at 1am, and it
gets fussy about proper quotes and dashes.

**[thebestmotherfucking.website](https://thebestmotherfucking.website/)** — the
maximalist entry, which is still 63 KB. It keeps a running weight budget in the
copy and notes it's ~94% smaller than the Google homepage. Mostly it exists to
make the point that you can have a real design — a webfont, an image, actual
styling — and still be an order of magnitude lighter than the median site.

There's also **[justfuckingusehtml.com](https://justfuckingusehtml.com/)**, which
is the same argument aimed squarely at people reaching for a SPA to render a
brochure.

## Why it's a sequence and not a pile-on

Read in order, they're not four people saying the same thing louder. They're a
negotiation about where the line is, and each one moves it by a few
declarations.

Nobody in that sequence is against CSS. Nobody's against design. What they're
against is the *default* — the reflex where a page that could be a document
becomes a build pipeline, a hydration step, and 2 MB of JavaScript before anyone
has written a sentence.

The through-line is just: start from the document. Add what the page actually
needs, and be able to say what each addition bought you.

That's the whole editorial policy of this site, and those four pages got there
first.
