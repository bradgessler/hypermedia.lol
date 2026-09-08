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

Within HTML and CSS, go nuts. A `<style>` block in your article is welcome and
encouraged — if your piece is about `:has()`, build something absurd with
`:has()`. Live demos are the best part of any article here, and it turns out you
can build a startling number of them out of `<details>`, `popover`, `<dialog>`,
`:target`, form validation, container queries, and scroll-driven animations. If
you find yourself wanting a script, that's usually a sign the platform grew a
feature while you weren't looking. Go find it. That's the article.

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
