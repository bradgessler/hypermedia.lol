---
title: Every Single-Page App Is a Worse Browser Running Inside a Browser
date: September 9, 2026
byline: Brad Gessler
byline_url: https://bradgessler.com
description: A team decides the server will speak JSON and the browser will do the rest. Four acts later they have rebuilt the back button, the cache, scroll restoration and the URL by hand, worse, and they can't see it. With a snowball.
accent: hot
sprite: brick
treatment: slope
span: big
og_image: /images/og/a-worse-browser-inside-a-browser.png
---

<p class="lede">This is the story of a team that builds a single-page app, told
as a ski hill: four runs, green circle to double black diamond, and something
waiting at the bottom. Nobody in it is stupid. Every decision is reasonable on the day
it's made. By the bottom of the hill they have written, by hand, a slower and buggier copy
of the thing their code was running inside the whole time.</p>

<div class="cast" aria-label="Dramatis personae">
  <p class="cast__head">Trail map</p>
  <dl>
    <dt>The Team</dt><dd>Four developers and a designer. Sharp, busy, well-meaning.</dd>
    <dt>The Browser</dt><dd>Thirty years old. Handles navigation, history, caching, scroll, focus, forms and errors. Never speaks. Nobody asks it anything.</dd>
    <dt>The API</dt><dd>Speaks only JSON. Has no opinion about what a page is.</dd>
    <dt>The Bundle</dt><dd>Small at first.</dd>
  </dl>
</div>

## Green circle: It starts with one JSON endpoint
<p class="dek">A list of things, fetched and drawn. Nothing could be more innocent.</p>

The Team has a page that lists orders. It's server-rendered HTML and it's fine,
but the designer wants the list to filter without a reload, and somebody says
the sentence that starts every one of these stories: "Let's just have the
server return JSON and render it on the client."

It takes an afternoon. `fetch("/api/orders")`, parse, map to rows. The page
feels snappy. There's a spinner now, because for the first time there's a
moment where the page exists but the orders don't. A small price.

<figure class="step snow snow--1" style="--n: 4">
  <div class="snow__scene" aria-hidden="true">
    <div class="snow__hill"></div>
    <span class="snow__tree snow__tree--a"></span>
    <span class="snow__tree snow__tree--b"></span>
    <span class="snow__skier"></span>
    <div class="snow__roll">
      <div class="snow__ball"></div>
      <ul class="snow__ring">
      <li style="--i: 0"><span>fetch()</span></li>
      <li style="--i: 1"><span>JSON.parse</span></li>
      <li style="--i: 2"><span>a spinner</span></li>
      <li style="--i: 3"><span>an empty state</span></li>
      </ul>
    </div>
  </div>
  <ul class="snow__junk">
    <li>fetch()</li>
    <li>JSON.parse</li>
    <li>a spinner</li>
    <li>an empty state</li>
  </ul>
  <figcaption>The snowball, bottom of the green run. Four things the HTML version didn't need. Each one is tiny.</figcaption>
</figure>

## Blue square: The URL stops meaning anything
<p class="dek">The back button breaks first. It always breaks first.</p>

Filtering works. Then someone filters to "unpaid", clicks an order, presses
Back, and lands on the unfiltered list at the top of the page. Two bugs: the
filter is gone and the scroll position is gone. The Browser used to handle
both. It kept the old page in memory and put it back exactly as it was, because
one in five navigations on a phone is a Back or a Forward and it was built for
that.[^bfcache] It restored scroll on its own, too; that's the default.[^scroll]
But there's no navigation any more. There's one page and some state, and the
state is wherever The Team last put it.

So The Team writes a router. The filter goes in the query string, then it goes
in a store, then the store syncs to the query string, then the query string
syncs to the store on load. Scroll position gets saved to `sessionStorage` on
every click. Deep links have to be handled, because a URL somebody pasted into
chat now has to reconstruct a screen from nothing. The `<title>` has to be set
by hand. Focus has to be moved by hand, because a screen reader was told a page
loaded and nothing happened.

None of this is a feature. Every line of it is a repair.

<figure class="step snow snow--2" style="--n: 12">
  <div class="snow__scene" aria-hidden="true">
    <div class="snow__hill"></div>
    <span class="snow__tree snow__tree--a"></span>
    <span class="snow__tree snow__tree--b"></span>
    <span class="snow__skier"></span>
    <div class="snow__roll">
      <div class="snow__ball"></div>
      <ul class="snow__ring">
      <li style="--i: 0"><span>fetch()</span></li>
      <li style="--i: 1"><span>JSON.parse</span></li>
      <li style="--i: 2"><span>a spinner</span></li>
      <li style="--i: 3"><span>an empty state</span></li>
      <li style="--i: 4"><span>a router</span></li>
      <li style="--i: 5"><span>query string sync</span></li>
      <li style="--i: 6"><span>a store</span></li>
      <li style="--i: 7"><span>scroll save/restore</span></li>
      <li style="--i: 8"><span>deep link handling</span></li>
      <li style="--i: 9"><span>document.title</span></li>
      <li style="--i: 10"><span>focus management</span></li>
      <li style="--i: 11"><span>a 404 screen</span></li>
      </ul>
    </div>
  </div>
  <ul class="snow__junk">
    <li>fetch()</li>
    <li>JSON.parse</li>
    <li>a spinner</li>
    <li>an empty state</li>
    <li>a router</li>
    <li>query string sync</li>
    <li>a store</li>
    <li>scroll save/restore</li>
    <li>deep link handling</li>
    <li>document.title</li>
    <li>focus management</li>
    <li>a 404 screen</li>
  </ul>
  <figcaption>Bottom of the blue. The Team has reimplemented the address bar, the back button and scroll restoration. All three are worse than the originals, and the originals are still there, unused, one layer down.</figcaption>
</figure>

## Black diamond: Two copies of the truth
<p class="dek">The server knows what's real. The client knows what it was told, once, a while ago.</p>

The list is now a store, and the store is a copy. That is the whole problem,
and it's worth being exact about it: the moment a page keeps its own copy of
data the server owns, there are two brains, and they will disagree.

<figure class="step">
<table class="ledger">
  <thead><tr><th>What happens</th><th>Client believes</th><th>Server knows</th></tr></thead>
  <tbody>
    <tr><td>Page loads, orders fetched</td><td>12 orders, 3 unpaid</td><td>12 orders, 3 unpaid</td></tr>
    <tr><td>A colleague marks one paid in another tab</td><td>3 unpaid</td><td class="ledger__diff">2 unpaid</td></tr>
    <tr><td>User marks another paid; the app updates optimistically</td><td class="ledger__diff">1 unpaid</td><td class="ledger__diff">2 unpaid, request in flight</td></tr>
    <tr><td>The request fails on a bad connection</td><td class="ledger__diff">1 unpaid, no error shown</td><td class="ledger__diff">2 unpaid</td></tr>
    <tr><td>Session expires</td><td class="ledger__diff">1 unpaid</td><td class="ledger__diff">401 for everything</td></tr>
    <tr><td>User presses Back</td><td class="ledger__diff">Whatever was in the store</td><td>2 unpaid</td></tr>
  </tbody>
</table>
<figcaption>The split brain. Each row is a real bug The Team will file, and each fix is more code: revalidation, rollback, retry, token refresh, a "your session has expired" modal. None of these rows exist when the server renders the page, because there is one brain and the page is a photograph of it.</figcaption>
</figure>

The Team fixes each row in turn. A cache with a time-to-live. Then invalidation
when a mutation succeeds. Then optimistic updates with rollback when one fails.
Then a retry queue. Then a refresh-token dance so a 401 doesn't strand the
store. Then a websocket, so the other tab's change shows up, which means a
reconciliation step when the socket and the store disagree.

The Browser has done all of this since before anyone on The Team was hired. It
asks the server "has this changed?" and gets back a `304 Not Modified` with no
body when it hasn't.[^cond] It has no store to reconcile, because it doesn't keep
one. It has the page.

<figure class="step snow snow--3" style="--n: 22">
  <div class="snow__scene" aria-hidden="true">
    <div class="snow__hill"></div>
    <span class="snow__tree snow__tree--a"></span>
    <span class="snow__tree snow__tree--b"></span>
    <span class="snow__skier"></span>
    <div class="snow__roll">
      <div class="snow__ball"></div>
      <ul class="snow__ring">
      <li style="--i: 0"><span>fetch()</span></li>
      <li style="--i: 1"><span>JSON.parse</span></li>
      <li style="--i: 2"><span>a spinner</span></li>
      <li style="--i: 3"><span>an empty state</span></li>
      <li style="--i: 4"><span>a router</span></li>
      <li style="--i: 5"><span>query string sync</span></li>
      <li style="--i: 6"><span>a store</span></li>
      <li style="--i: 7"><span>scroll save/restore</span></li>
      <li style="--i: 8"><span>deep link handling</span></li>
      <li style="--i: 9"><span>document.title</span></li>
      <li style="--i: 10"><span>focus management</span></li>
      <li style="--i: 11"><span>a 404 screen</span></li>
      <li style="--i: 12"><span>a cache</span></li>
      <li style="--i: 13"><span>TTLs</span></li>
      <li style="--i: 14"><span>invalidation</span></li>
      <li style="--i: 15"><span>optimistic updates</span></li>
      <li style="--i: 16"><span>rollback</span></li>
      <li style="--i: 17"><span>a retry queue</span></li>
      <li style="--i: 18"><span>token refresh</span></li>
      <li style="--i: 19"><span>a websocket</span></li>
      <li style="--i: 20"><span>reconciliation</span></li>
      <li style="--i: 21"><span>"session expired"</span></li>
      </ul>
    </div>
  </div>
  <ul class="snow__junk">
    <li>fetch()</li>
    <li>JSON.parse</li>
    <li>a spinner</li>
    <li>an empty state</li>
    <li>a router</li>
    <li>query string sync</li>
    <li>a store</li>
    <li>scroll save/restore</li>
    <li>deep link handling</li>
    <li>document.title</li>
    <li>focus management</li>
    <li>a 404 screen</li>
    <li>a cache</li>
    <li>TTLs</li>
    <li>invalidation</li>
    <li>optimistic updates</li>
    <li>rollback</li>
    <li>a retry queue</li>
    <li>token refresh</li>
    <li>a websocket</li>
    <li>reconciliation</li>
    <li>"session expired"</li>
  </ul>
  <figcaption>Bottom of the black diamond. The Team is now maintaining an HTTP cache. It is not as good as the one in the browser, and it has to be, because the browser's can't see inside the store.</figcaption>
</figure>

## Double black diamond: The JSON is tiny. The bundle is not.
<p class="dek">The number everyone quotes is the one that doesn't matter.</p>

Someone on The Team makes the argument that closes every one of these
discussions: "The JSON is 2 KB. The HTML page was 20 KB. We're sending less."

The JSON is 2 KB. The code that turns it into a page is the median JavaScript
payload on the mobile web: 558 KB, across 22 requests, of which 206 KB is never
executed at all.[^almanac] That code is the part of the browser The Team rebuilt,
and it ships to every visitor before a single order can be drawn.

The Team knows this, and has an answer: the bundle is cached. Which it is,
until the next deploy. Bundles are named by a hash of their contents so that
browsers fetch the new one when the code changes, and the change doesn't have
to be big. Webpack's own caching guide walks through adding one module and
watching the hash change on every bundle, including the vendor bundle that
didn't change, and then explains the three configuration steps you need to stop
that happening.[^webpack] Most teams haven't done those steps. So a typo fix in a
component ships the whole thing again, to everyone.

<figure class="step">
<div class="bars" aria-label="What every visitor downloads after a typo fix">
  <div class="bars__row"><span class="bars__label">Server-rendered page, unchanged elsewhere</span><span class="bars__bar" style="--w: 3.6%"><b>20 KB</b></span></div>
  <div class="bars__row"><span class="bars__label">Same page, browser already has it</span><span class="bars__bar bars__bar--zero" style="--w: 0.5%"><b>304, 0 KB</b></span></div>
  <div class="bars__row"><span class="bars__label">The JSON everyone quotes</span><span class="bars__bar" style="--w: 0.4%"><b>2 KB</b></span></div>
  <div class="bars__row"><span class="bars__label">Median JavaScript, re-fetched because the hash changed</span><span class="bars__bar bars__bar--hot" style="--w: 100%"><b>558 KB</b></span></div>
</div>
<figcaption>What a one-line fix costs each visitor, to scale. The server-rendered page costs one small document, or nothing if the browser can validate its copy. The app costs the bundle, because the fix is in the bundle. The 2 KB was never the payload.</figcaption>
</figure>

And the page got slower on the way in, not just on repeat. A server-rendered
page paints when the HTML arrives. The app paints a spinner when the HTML
arrives, then waits for the bundle, then parses and runs it, then fetches the
JSON, then draws. The Team measures this eventually and calls the result
"perceived performance," which is the phrase for a spinner that appears
quickly.

<figure class="step snow snow--4" style="--n: 31">
  <div class="snow__scene" aria-hidden="true">
    <div class="snow__hill"></div>
    <span class="snow__tree snow__tree--a"></span>
    <span class="snow__tree snow__tree--b"></span>
    <span class="snow__skier"></span>
    <span class="snow__yeti"></span>
    <div class="snow__roll">
      <div class="snow__ball"></div>
      <ul class="snow__ring">
      <li style="--i: 0"><span>fetch()</span></li>
      <li style="--i: 1"><span>JSON.parse</span></li>
      <li style="--i: 2"><span>a spinner</span></li>
      <li style="--i: 3"><span>an empty state</span></li>
      <li style="--i: 4"><span>a router</span></li>
      <li style="--i: 5"><span>query string sync</span></li>
      <li style="--i: 6"><span>a store</span></li>
      <li style="--i: 7"><span>scroll save/restore</span></li>
      <li style="--i: 8"><span>deep link handling</span></li>
      <li style="--i: 9"><span>document.title</span></li>
      <li style="--i: 10"><span>focus management</span></li>
      <li style="--i: 11"><span>a 404 screen</span></li>
      <li style="--i: 12"><span>a cache</span></li>
      <li style="--i: 13"><span>TTLs</span></li>
      <li style="--i: 14"><span>invalidation</span></li>
      <li style="--i: 15"><span>optimistic updates</span></li>
      <li style="--i: 16"><span>rollback</span></li>
      <li style="--i: 17"><span>a retry queue</span></li>
      <li style="--i: 18"><span>token refresh</span></li>
      <li style="--i: 19"><span>a websocket</span></li>
      <li style="--i: 20"><span>reconciliation</span></li>
      <li style="--i: 21"><span>"session expired"</span></li>
      <li style="--i: 22"><span>a bundler</span></li>
      <li style="--i: 23"><span>code splitting</span></li>
      <li style="--i: 24"><span>hash config</span></li>
      <li style="--i: 25"><span>vendor chunks</span></li>
      <li style="--i: 26"><span>a loading skeleton</span></li>
      <li style="--i: 27"><span>error boundaries</span></li>
      <li style="--i: 28"><span>hydration</span></li>
      <li style="--i: 29"><span>a service worker</span></li>
      <li style="--i: 30"><span>"perceived performance"</span></li>
      </ul>
    </div>
  </div>
  <ul class="snow__junk">
    <li>fetch()</li>
    <li>JSON.parse</li>
    <li>a spinner</li>
    <li>an empty state</li>
    <li>a router</li>
    <li>query string sync</li>
    <li>a store</li>
    <li>scroll save/restore</li>
    <li>deep link handling</li>
    <li>document.title</li>
    <li>focus management</li>
    <li>a 404 screen</li>
    <li>a cache</li>
    <li>TTLs</li>
    <li>invalidation</li>
    <li>optimistic updates</li>
    <li>rollback</li>
    <li>a retry queue</li>
    <li>token refresh</li>
    <li>a websocket</li>
    <li>reconciliation</li>
    <li>"session expired"</li>
    <li>a bundler</li>
    <li>code splitting</li>
    <li>hash config</li>
    <li>vendor chunks</li>
    <li>a loading skeleton</li>
    <li>error boundaries</li>
    <li>hydration</li>
    <li>a service worker</li>
    <li>"perceived performance"</li>
  </ul>
  <figcaption>Double black. Everything on the ball is a thing the browser underneath it already did. The Team is proud of the ball. It took two years.</figcaption>
</figure>

## The lodge: the best case for the app
<p class="dek">Steelman first, by the fire. There are real ones.</p>

**"Some things are applications."** Yes. A design tool, a spreadsheet, a map, a
video editor. If the user is manipulating a document continuously and the
server is a save button, the client should own that state, and a page-per-view
would be absurd. This story is not about those. It's about a list of orders,
which is most of the web, wearing the architecture of a spreadsheet.

**"We need the API for the mobile app anyway."** Fine. Have the API. Nothing
about an API requires the browser to consume it through a store; the server can
read the same code path and send HTML. The API and the split brain are separate
decisions that got sold as one.

**"Full page loads feel slow."** They did, in 2012. Today the browser keeps the
previous page in memory and restores it instantly on Back.[^bfcache] It animates
between two documents with one CSS rule and no JavaScript.[^vt] Chrome will
prefetch or fully prerender the next page from a declarative rules block, though
that one is still Chrome-only.[^specrules] The feel that justified the rewrite is
now a property of documents.

**"It works offline."** Some of it does, for the price of a service worker,
which is on the ball. If offline is a real requirement it's worth it. It usually
isn't the requirement; it's the justification found afterwards.

## 2,000 metres: the yeti
<p class="dek">In SkiFree, ski far enough and the abominable snowman comes for you. Here it's the bill for the browser The Team rebuilt.</p>

Line the ball up against the thing it's sitting inside. A router: the address
bar. Scroll save and restore: the browser's default. The store and its cache:
HTTP caching, with validators the server already sends. Optimistic updates and
rollback: a form post, which either works or shows you it didn't. Deep link
handling: a URL. Focus management: a page load. The 404 screen: a 404.

Every one of those was available in Act I, for free, tested against every
site on the internet. The Team didn't reject them. The Team never saw them,
because the first decision, "the server returns JSON," took the page away, and
with it went everything the browser does to a page.

The alternative isn't a rewrite. It's the page. Render the orders on the server.
Make the filter a form. If the designer wants it to feel instant, add the one
CSS rule for a cross-document transition and let the browser prefetch. If a
region of the page needs to update in place, swap that region's HTML, not its
JSON. That's what hypermedia is: the server sends the thing the browser already
knows how to be.

The Browser, who has had no lines in this play, was doing all of it the whole
time.

[^bfcache]: web.dev, [Back/forward cache](https://web.dev/articles/bfcache). The browser keeps the whole page in memory and restores it instantly on back or forward, state and scroll included. Chrome's figure: one in ten navigations on desktop and one in five on mobile are a back or forward.

[^scroll]: MDN, [`history.scrollRestoration`](https://developer.mozilla.org/en-US/docs/Web/API/History/scrollRestoration). The default is `auto`: the browser puts the scroll position back on history navigation. Apps set it to `manual` and then do it themselves.

[^cond]: MDN, [HTTP conditional requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Conditional_requests). `ETag` and `Last-Modified` validators, `If-None-Match`, and the `304 Not Modified` response with no body. Handled by the browser with no developer code.

[^almanac]: HTTP Archive, [Web Almanac 2024, JavaScript](https://almanac.httparchive.org/en/2024/javascript). Median mobile page: 558 KB of JavaScript over 22 requests, of which 206 KB, 44% of what was delivered, is unused.

[^webpack]: webpack, [Caching](https://webpack.js.org/guides/caching/). Output filenames carry a `[contenthash]`; the guide adds one module and shows every bundle's hash changing, then prescribes `runtimeChunk`, `splitChunks` and deterministic module ids to contain it.

[^vt]: MDN, [Using the View Transition API](https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API/Using). Cross-document transitions between same-origin pages need one rule in both documents, `@view-transition { navigation: auto; }`, and no JavaScript.

[^specrules]: MDN, [Speculation Rules API](https://developer.mozilla.org/en-US/docs/Web/API/Speculation_Rules_API). Declarative prefetch and prerender of likely next pages. Limited availability: not yet in every major browser.
