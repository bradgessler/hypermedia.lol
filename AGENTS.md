# hypermedia.lol

Short, funny, well-sourced arguments for using what the browser already does
instead of reimplementing it in JavaScript. Edutainment for people (and agents)
who don't know how much the platform gives them for free. This file is the
brief for any agent working on the site. `CLAUDE.md` is a symlink to it.

## What we're making

Each article takes one thing the industry habitually over-builds, shows it
breaking, and shows the smaller thing that already worked. The reader should
come away able to delete code. The tone is confident, specific, and a little
unhinged in presentation, never in facts.

The reference article is `pages/articles/one-textbox-for-one-time-codes.html.md`.
Match its standard before adding anything.

## Editorial rules

1. **Show before you tell.** Every article leads with the thing itself: the
   email, the broken input, the console. A live demo of the failure next to the
   working version beats three paragraphs describing it. Wrap every shown thing
   in `<figure class="step">` with a `<figcaption>` that says what it is.
2. **The skim rule.** Headings are statements that carry their claim alone
   ("Six inputs break six things the browser already did", never "What it
   costs"). Put a `<p class="dek">` one-liner under every heading. A reader who
   only reads headings, deks, captions and code must still get the argument.
3. **Tell it as a story.** First person, present tense, the thing that actually
   happened. "I go to buy coffee. They email me a code. It looks like this:"
4. **Steelman, then win.** Every article has a section stating the strongest
   case for the thing it argues against, in its own best words, and answers
   each point. If you can't beat the steelman, the article isn't ready.
5. **Cite from primary sources, verified this session.** Specs, vendor docs,
   the actual source file with a line count, a standard with its criterion
   number. Never a claim from memory, never a secondary summary when the
   primary is reachable. Inline links where they're the natural next click;
   everything else is a footnote: `[^name]` in text, `[^name]: ...` at the end.
   Footnote refs don't render inside raw HTML blocks; cite from markdown.
6. **Measure, don't assert.** If the claim is "fast", run Lighthouse. If it's
   "767 lines", count them. If it's "our deploys take a minute", read the run
   log. Put the number and the method in a footnote.
7. **Name companies as bug reports, not dunks.** "I like Sweet Maria's, their
   login just fails a paste." Never punch down. Libraries get the same
   treatment: "a competent implementation of a bad idea."
8. **No em dashes.** Use a period, a colon, or a comma and rework the
   sentence. No "isn't X, it's Y" setups, no "genuinely", "exactly", "quietly",
   no triplets for rhythm. If it reads as machine-written, cut it.
9. **Byline.** `byline:` and `byline_url:` in front matter render as
   "Prompted by Name". `byline_verb: By` for hand-written work.

## The JavaScript rule

No JavaScript for the site's own UI. Two exceptions, and they are the bar:

1. Running the anti-pattern so the reader can feel it break, clearly labeled
   as the thing being argued against.
2. A control the platform has no declarative answer for (the Copy button).
   It must insert its own UI so the page is complete without it.

Both must be annotated in the source and mentioned on the page.

## How a page looks

- Front matter: `title`, `date`, `description` (the social card copy),
  `byline`, `byline_url`, `treatment`, `sprite`, `span` (`big`/`wide`/`tall`),
  optional `og_image`.
- `treatment:` picks a whole visual world: `plain`, `spec`, `terminal`, `zine`,
  `form`, `launch`. Treatments change chrome, colour, headings and texture.
  They may not change the prose face, prose size, or measure. Body copy must
  hold 7:1 contrast in both colour schemes. Scanlines and rotation go on
  chrome only, never on running text.
- Figures get real air: the CSS handles it, don't fight it.
- Code fences are highlighted server-side by Rouge. Caption a fence with a
  `Caption:` paragraph directly after it; the renderer wraps the pair in a
  figure. A fence whose info string has spaces is not a fence to Redcarpet.
- Headings get ids and anchor links automatically.
- Images go in `pages/images/`; anything under `assets/` is fingerprinted.
- Cards on the wall preview the article's treatment. If you add a treatment,
  add a preview in `helpers/preview_helper.rb`.

## Working on the site

```sh
bundle install
bundle exec sitepress server   # http://127.0.0.1:8080, live reload
bundle exec rake               # production build into ./build
```

Pushing to `main` deploys to GitHub Pages in about thirty seconds. The
`markdown/application_markdown.rb` renderer owns fences, captions, footnotes
and heading anchors. `helpers/site_helper.rb` owns treatments, bylines,
Open Graph and the wall.

Before you say something is done: build it, grep the built HTML for what you
changed, check for `<script>` tags you didn't intend, and screenshot it with
headless Chrome if the change is visual. Say what you verified and what you
couldn't.
