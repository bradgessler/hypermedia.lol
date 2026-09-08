# Submit an article

Anyone can submit. Open a pull request that adds one file to `pages/articles/`.
If it makes sense, it gets merged and it's live.

## The file

Drop it in `pages/articles/`. Name it after the argument, in kebab-case.

Markdown or HTML, your call — the extension decides how it's rendered:

| Extension | You write |
|---|---|
| `.html.md` | Markdown |
| `.html.erb` | HTML, with ERB if you want it |
| `.html.haml` | Haml |

All of them need YAML front matter at the top:

```
---
title: One textbox for one-time codes
date: September 8, 2026
description: One sentence. This is the search result and the social card copy.
---
```

### Pick a treatment

A treatment is the visual world your article lives in. Add `treatment:` to your
front matter:

| Treatment | Looks like | Good for |
|---|---|---|
| `plain` | The house style — poster type on paper | Anything (the default) |
| `spec` | A W3C document: numbered sections, status box, institutional blue | Arguing from the platform |
| `terminal` | Amber phosphor on black, scanlines, blinking cursor | Deploys, tooling, the machine |
| `zine` | Photocopied punk: halftone paper, headline knocked askew | Manifestos and rants |
| `form` | Ruled grid paper, numbered fields | Inputs and forms |
| `launch` | A nuclear launch console: hazard stripes, indicator lamps, a big red ARM button | Anything people over-engineer like it's a launch code |

Treatments can change colour, chrome, headline handling, texture and
decoration. They **cannot** change the prose face, prose size, or the measure —
those are locked across every treatment on purpose. Variety is the point;
making an article harder to read is not. New treatments are welcome as PRs, and
they get held to the same line: body copy at 7:1 contrast or better, in both
colour schemes, with no text set on a rotated or textured background.

Also pick a `sprite:` — `cursor`, `floppy`, `dialog`, `key`, `clock`, or
`brick` — which is drawn as 16x16 pixel art in `helpers/sprite_helper.rb`. New
sprites are just as welcome; they're drawn as text you can edit by hand.

Don't repeat the title as a heading in the body — the layout renders it. Start
with your first sentence. Use `##` for section headings.

Images go in `pages/images/` and get referenced as `/images/your-file.png`.
Anything under `assets/` gets fingerprinted by Sprockets, which will break a
plain markdown image link.

## The one rule: HTML and CSS

**No JavaScript.** Not in an article, not in a demo, not "just a little for the
interactive bit."

This is a site about how much the browser already does for you. Shipping a
script to prove that point would be embarrassing for both of us.

There is exactly one exception on the site: a Copy button on the one-time-code
page, because the platform has no declarative clipboard. It's the bar for any
future exception, and it's a high one — the browser genuinely has no answer,
the script inserts its own UI so the page is complete without it, and it's
annotated in the source and on the page.

Within HTML and CSS, go nuts. A `<style>` block in your article is welcome and
encouraged — if your piece is about `:has()`, build something absurd with
`:has()`. Live demos are the best part of any article here, and it turns out you
can build a startling number of them out of `<details>`, `popover`, `<dialog>`,
`:target`, form validation, container queries, and scroll-driven animations. If
you find yourself wanting a script, that's usually a sign the platform grew a
feature while you weren't looking. Go find it. That's the article.

## The skim rule

**Someone should be able to understand your whole argument without reading a
paragraph.** Headings, deks, examples, diagrams and code have to carry it on
their own. Blocks of prose are welcome underneath — but they're the second
layer, not the first.

In practice:

- **Headings are statements, not labels.** "Six inputs break six things the browser already did" — not "What it costs." If a heading only makes sense once you've read the section under it, rewrite it.
- **Put a dek under each one.** `<p class="dek">One line.</p>` right after the heading, carrying the specific claim.
- **Show before you tell.** A live demo of the broken thing next to the working thing beats three paragraphs describing the difference. You can build a startling number of these with no JavaScript.
- **Label your code.** A reader should know what a block proves before they parse it.

## What gets merged

The good ones are specific. A pattern you keep seeing in the wild, what it
actually costs — accessibility, performance, keyboard, paste, back button — and
the smaller thing that does the job. Show the markup.

Punching down at a specific company isn't the vibe. Naming a site as an example
is fine, but write it like a bug report from someone who wants them to win, not
a dunk.

Length is whatever the argument needs. Some of these should be four paragraphs.

## Running it locally

```sh
bundle install
bundle exec sitepress server   # http://127.0.0.1:8080
```

Live reload is on. `bundle exec rake` does a production build into `./build`.
