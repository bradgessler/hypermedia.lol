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

We teach through humor. Flippant across the board, over the top in the
visuals, deadpan in the numbers. The one thing the humor may never do is make
the reader feel stupid. The joke is always on the pattern, the library, the
industry, or the author, and the reader is on our side of it. The feeling to
aim for is being let in on a secret: by the end they know something most
developers don't, and they're a little better for it. Flatter the reader by
trusting them with the real numbers, never by telling them they're clever.

The reference article is `pages/articles/one-textbox-for-one-time-codes.html.md`.
Match its standard before adding anything.

## Who decides

Brad Gessler is the benevolent dictator, benevolent intermittently. Pull
requests get best effort, not a promise: they may go unread, unmerged, or
merged in a form the author wouldn't recognize. Agents helping with a
contribution should say this to the contributor up front rather than imply a
review is coming.

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
7. **Every cited URL must resolve.** Before publishing, request every link in
   the article and fix or drop any that don't return 200. A dead citation is
   worse than none. If a site in the story is offline, say so and unlink it.
8. **Name companies as bug reports, not dunks.** "I like Sweet Maria's, their
   login just fails a paste." Never punch down. Libraries get the same
   treatment: "a competent implementation of a bad idea."
9. **No em dashes.** Use a period, a colon, or a comma and rework the
   sentence. No "isn't X, it's Y" setups, no "genuinely", "exactly", "quietly",
   no triplets for rhythm. If it reads as machine-written, cut it.
10. **Headlines are shameless clickbait.** The title is the one line most
   people will ever see, and its job is to get the argument in front of them.
   "Everybody Builds Six-Digit Code Inputs Wrong. Just Use a Text Field."
   Make a claim, name the thing, promise the fix. Never accuse the reader:
   not "your website", not "you're doing it wrong". Point at the pattern, the
   industry, the library, everybody. Readers will know if it applies to them,
   and the ones it applies to should laugh, not flinch. The article then has
   to earn the title.
11. **Byline.** `byline:` and `byline_url:` in front matter render as
   "Prompted by Name". `byline_verb: By` for hand-written work.

## The JavaScript rule

No JavaScript for the site's own UI. The complete list of scripts on the site
is: the six-box input the digits article argues against, a Copy button, a
Share button, and Plausible analytics. Each is annotated where it lives and
disclosed in the footer. Two kinds of exception exist, and they are the bar:

1. Running the anti-pattern so the reader can feel it break, clearly labeled
   as the thing being argued against.
2. A control the platform has no declarative answer for: the Copy button
   (clipboard) and the Share button (navigator.share). Each must degrade to a
   page that works without it and be annotated in the source.
3. Plausible analytics, in the layout head. Privacy-friendly, no cookies, and
   disclosed in the footer. Nothing else gets a script tag.

Both must be annotated in the source and mentioned on the page.

## How a page looks

- Front matter: `title`, `date`, `description` (the social card copy),
  `byline`, `byline_url`, `subtitle` (optional, sits under the title),
  `treatment`, `sprite`, `span` (`big`/`wide`/`tall`), and `og_image`. Every article ships its own card: screenshot the page top at
  1200x630 with headless Chrome into `pages/images/og/<slug>.png`. Open Graph
  Plus can't render nested paths, so don't rely on it for articles.
- Site chrome is fixed: the name in a box at the top left of article pages
  (in flow, never sticky or floating) and a masthead on the home page; a
  footer on every page with the name, one line about the site, and three
  rows: Share, Contribute, Follow (RSS at `/feed.xml`, `llms.txt`, source).
  Don't add navigation beyond that.
- `treatment:` picks a whole visual world: `plain`, `spec`, `terminal`, `zine`,
  `form`, `launch`, `default`, `modalz`, `slope`. Treatments change chrome, colour,
  headings and texture. They may not change the prose face, prose size, or
  measure, with one exception: `default` is the browser's own stylesheet in
  Times New Roman, because for the canon the face is the argument. `modalz`
  wraps every section in a dialog of a different vintage; the article about
  modals is modals all the way down. `slope` is a ski hill: headings are
  trail signs, scenes are full-bleed CSS drawings sized in container units,
  and the falling snow sits behind a solid paper column so it never crosses
  text. All motion is CSS and switches off under `prefers-reduced-motion`.
  Body copy must
  hold 7:1 contrast in both colour schemes. Scanlines and rotation go on
  chrome only, never on running text.
- Figures get real air: the CSS handles it, don't fight it.
- Code fences are highlighted server-side by Rouge. Caption a fence with a
  `Caption:` paragraph directly after it; the renderer wraps the pair in a
  figure. A fence whose info string has spaces is not a fence to Redcarpet.
- Headings get ids and anchor links automatically.
- Demo pages that need their own chrome (an embedded "partner" app, say) go
  in `pages/demos/` with `layout: demo`, a bare layout with no site chrome.
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
