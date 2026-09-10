---
title: Every Single-Page App Is a Worse Browser Running Inside a Browser
date: September 9, 2026
subtitle: Where good intentions snowball into a shitty browser inside a browser
byline: Brad Gessler
byline_url: https://bradgessler.com
description: Good intentions snowball into a shitty browser inside a browser. A team decides the server will speak JSON and the client will do the rest, and four runs later they've rebuilt the back button, the cache, scroll restoration and the URL by hand, worse. With a yeti.
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

<div class="cast" aria-label="Trail map and dramatis personae">
  <p class="cast__head">Trail map · Split Brain Mountain</p>
<svg class="tmap" viewBox="0 0 900 480" role="img" aria-labelledby="tmap-title"><title id="tmap-title">Trail map: four runs from the summit, a chairlift, the lodge at the base and a yeti past the trees</title>
<defs><symbol id="tr" viewBox="0 0 10 14"><polygon points="5,0 0,9 10,9" fill="#2e7d32"/><polygon points="5,3 1,12 9,12" fill="#2e7d32"/><rect x="4.2" y="11" width="1.6" height="3" fill="#5a3416"/></symbol><symbol id="trs" viewBox="0 0 10 14"><polygon points="5,0 0,9 10,9" fill="#3f8f45"/><polygon points="5,3 1,12 9,12" fill="#3f8f45"/><rect x="4.2" y="11" width="1.6" height="3" fill="#5a3416"/></symbol><symbol id="chair" viewBox="0 0 8 10"><rect x="3.5" y="0" width="1" height="4" fill="#2b180a"/><rect x="0" y="4" width="8" height="5" rx="1" fill="#c0392b"/></symbol></defs>
<path d="M0,432 L60,330 L130,262 L200,205 L270,158 L340,112 L400,86 L450,62 L505,88 L560,126 L620,172 L690,222 L760,282 L830,352 L900,420 L900,432 Z" fill="#f6f9fc" stroke="#8fa3ba" stroke-width="2" stroke-linejoin="round"/>
<path d="M450,62 L505,88 L560,126 L620,172 L690,222 L760,282 L830,352 L900,420 L900,432 L640,432 L560,330 L500,230 L455,140 Z" fill="#dde6f0"/>
<path d="M450,62 L455,140 L500,230 L560,330 L640,432" fill="none" stroke="#c3d0de" stroke-width="2"/>
<path d="M340,112 L360,160 L330,220 M200,205 L230,250 L210,300" fill="none" stroke="#d3dde8" stroke-width="2"/>
<polygon points="425,78 450,62 478,78 466,84 450,74 436,86" fill="#fff"/>
<polygon points="255,166 270,158 288,168 278,174 270,166 262,176" fill="#fff"/>
<polygon points="605,178 620,172 636,184 626,188 620,180 612,190" fill="#fff"/>
<linearGradient id="tmap-base" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#eef3f9"/><stop offset="1" stop-color="#eef3f9" stop-opacity="0"/></linearGradient><path d="M0,432 L900,432 L900,480 L0,480 Z" fill="url(#tmap-base)"/>
<path d="M0,432 Q450,410 900,432" fill="none" stroke="#c3d0de" stroke-width="2"/>
<use href="#tr" x="30" y="251" width="11" height="15"/>
<use href="#trs" x="52" y="254" width="12" height="17"/>
<use href="#trs" x="104" y="262" width="10" height="14"/>
<use href="#tr" x="27" y="265" width="15" height="21"/>
<use href="#tr" x="46" y="270" width="14" height="19"/>
<use href="#tr" x="141" y="287" width="11" height="15"/>
<use href="#tr" x="21" y="310" width="12" height="16"/>
<use href="#tr" x="839" y="319" width="12" height="17"/>
<use href="#trs" x="27" y="322" width="12" height="17"/>
<use href="#tr" x="858" y="324" width="11" height="15"/>
<use href="#tr" x="81" y="330" width="15" height="21"/>
<use href="#tr" x="62" y="330" width="16" height="22"/>
<use href="#tr" x="101" y="335" width="13" height="18"/>
<use href="#trs" x="757" y="339" width="13" height="18"/>
<use href="#trs" x="794" y="350" width="11" height="15"/>
<use href="#tr" x="848" y="350" width="11" height="15"/>
<use href="#trs" x="750" y="349" width="12" height="17"/>
<use href="#trs" x="820" y="356" width="12" height="16"/>
<use href="#tr" x="893" y="351" width="15" height="21"/>
<use href="#tr" x="740" y="357" width="11" height="15"/>
<use href="#tr" x="773" y="359" width="10" height="14"/>
<use href="#tr" x="796" y="353" width="16" height="22"/>
<use href="#trs" x="768" y="360" width="13" height="18"/>
<use href="#trs" x="834" y="366" width="11" height="15"/>
<use href="#tr" x="721" y="365" width="13" height="18"/>
<use href="#trs" x="803" y="378" width="10" height="14"/>
<use href="#tr" x="99" y="375" width="13" height="18"/>
<use href="#tr" x="785" y="371" width="16" height="22"/>
<use href="#tr" x="741" y="373" width="15" height="21"/>
<use href="#trs" x="702" y="375" width="14" height="20"/>
<use href="#trs" x="133" y="379" width="12" height="16"/>
<use href="#trs" x="753" y="379" width="12" height="17"/>
<use href="#tr" x="777" y="383" width="11" height="15"/>
<use href="#tr" x="162" y="383" width="15" height="20"/>
<use href="#trs" x="799" y="387" width="13" height="18"/>
<use href="#trs" x="822" y="389" width="15" height="20"/>
<use href="#tr" x="757" y="394" width="12" height="17"/>
<use href="#tr" x="892" y="399" width="11" height="16"/>
<use href="#tr" x="192" y="395" width="15" height="20"/>
<use href="#tr" x="846" y="396" width="16" height="22"/>
<use href="#trs" x="884" y="402" width="15" height="21"/>
<use href="#tr" x="880" y="403" width="15" height="20"/>
<use href="#tr" x="780" y="404" width="15" height="21"/>
<use href="#trs" x="871" y="409" width="14" height="20"/>
<use href="#tr" x="828" y="415" width="11" height="16"/>
<use href="#trs" x="797" y="413" width="13" height="18"/>
<path id="run-g" d="M450,72 C405,140 335,205 305,280 C280,340 240,385 205,418" fill="none" stroke="#fff" stroke-width="15" stroke-linecap="round"/>
<path d="M450,72 C405,140 335,205 305,280 C280,340 240,385 205,418" fill="none" stroke="#2e9e4f" stroke-width="8" stroke-linecap="round"/>
<path id="lbl-g" d="M205,418 C240,385 280,340 305,280 C335,205 405,140 450,72" fill="none" stroke="none"/><text class="tmap__run" dy="-11"><textPath href="#lbl-g" startOffset="22%">One JSON Endpoint</textPath></text>
<g transform="translate(392,150)"><circle cx="0" cy="0" r="9" fill="#2e9e4f" stroke="#fff" stroke-width="2"/></g>
<path id="run-b" d="M450,72 C445,150 425,225 405,300 C388,360 370,395 352,420" fill="none" stroke="#fff" stroke-width="15" stroke-linecap="round"/>
<path d="M450,72 C445,150 425,225 405,300 C388,360 370,395 352,420" fill="none" stroke="#2266d1" stroke-width="8" stroke-linecap="round"/>
<path id="lbl-b" d="M352,420 C370,395 388,360 405,300 C425,225 445,150 450,72" fill="none" stroke="none"/><text class="tmap__run" dy="-11"><textPath href="#lbl-b" startOffset="24%">Router Run</textPath></text>
<g transform="translate(438,180)"><rect x="-8" y="-8" width="16" height="16" fill="#2266d1" stroke="#fff" stroke-width="2"/></g>
<path id="run-k" d="M450,72 C470,150 520,205 540,280 C556,345 545,390 532,420" fill="none" stroke="#fff" stroke-width="15" stroke-linecap="round"/>
<path d="M450,72 C470,150 520,205 540,280 C556,345 545,390 532,420" fill="none" stroke="#111" stroke-width="8" stroke-linecap="round"/>
<text class="tmap__run" dy="-11"><textPath href="#run-k" startOffset="34%">Split Brain</textPath></text>
<g transform="translate(505,175)"><polygon points="0,-10 10,0 0,10 -10,0" fill="#111" stroke="#fff" stroke-width="2"/></g>
<path id="run-kk" d="M450,72 C520,118 600,175 655,250 C700,312 730,372 762,422" fill="none" stroke="#fff" stroke-width="15" stroke-linecap="round"/>
<path d="M450,72 C520,118 600,175 655,250 C700,312 730,372 762,422" fill="none" stroke="#111" stroke-width="8" stroke-linecap="round" stroke-dasharray="14 10"/>
<text class="tmap__run" dy="-11"><textPath href="#run-kk" startOffset="34%">Bundle Bowl</textPath></text>
<g transform="translate(578,160)"><g><polygon points="-8,-9 1,0 -8,9 -17,0" fill="#111" stroke="#fff" stroke-width="2"/><polygon points="8,-9 17,0 8,9 -1,0" fill="#111" stroke="#fff" stroke-width="2"/></g></g>
<line x1="150" y1="408" x2="444" y2="72" stroke="#5a3416" stroke-width="3"/>
<rect x="201" y="348" width="4" height="26" fill="#5a3416"/><rect x="194" y="345" width="18" height="5" fill="#c0392b"/>
<rect x="271" y="267" width="4" height="26" fill="#5a3416"/><rect x="264" y="264" width="18" height="5" fill="#c0392b"/>
<rect x="342" y="186" width="4" height="26" fill="#5a3416"/><rect x="335" y="183" width="18" height="5" fill="#c0392b"/>
<rect x="407" y="112" width="4" height="26" fill="#5a3416"/><rect x="400" y="109" width="18" height="5" fill="#c0392b"/>
<use href="#chair" x="168" y="381" width="12" height="15"/>
<use href="#chair" x="220" y="321" width="12" height="15"/>
<use href="#chair" x="291" y="240" width="12" height="15"/>
<use href="#chair" x="362" y="159" width="12" height="15"/>
<use href="#chair" x="423" y="89" width="12" height="15"/>
<g transform="translate(110,372)"><polygon points="0,46 40,0 80,46" fill="#8a5a2b"/><polygon points="6,46 40,8 74,46" fill="#a86b35"/><rect x="0" y="46" width="80" height="6" fill="#5a3416"/><rect x="33" y="28" width="14" height="18" fill="#ffd166"/><rect x="14" y="30" width="10" height="9" fill="#ffd166"/><rect x="56" y="30" width="10" height="9" fill="#ffd166"/><rect x="58" y="6" width="8" height="16" fill="#3b2314"/></g>
<text class="tmap__lbl" x="150" y="440" text-anchor="middle">THE LODGE</text>
<g transform="translate(160,356)"><path d="M0,0 C-11,-14 -11,-30 0,-32 C11,-30 11,-14 0,0 Z" fill="#d61f1f" stroke="#fff" stroke-width="2"/><circle cx="0" cy="-22" r="4" fill="#fff"/></g>
<text class="tmap__lbl tmap__lbl--red" x="160" y="318" text-anchor="middle">YOU ARE HERE</text>
<rect x="449" y="40" width="2" height="30" fill="#2b180a"/><polygon points="451,40 469,46 451,52" fill="#d61f1f"/>
<text class="tmap__lbl" x="450" y="34" text-anchor="middle">SUMMIT · 2,000 m</text>
<g transform="translate(810,355)"><rect x="6" y="0" width="24" height="8" fill="#b8c4cf"/><rect x="2" y="8" width="32" height="26" fill="#b8c4cf"/><rect x="0" y="12" width="6" height="14" fill="#b8c4cf"/><rect x="30" y="12" width="6" height="14" fill="#b8c4cf"/><rect x="8" y="34" width="8" height="8" fill="#b8c4cf"/><rect x="20" y="34" width="8" height="8" fill="#b8c4cf"/><rect x="10" y="12" width="4" height="4" fill="#111"/><rect x="22" y="12" width="4" height="4" fill="#111"/><rect x="12" y="22" width="12" height="3" fill="#111"/></g>
<line x1="758" y1="387" x2="798" y2="397" stroke="#d61f1f" stroke-width="2" stroke-dasharray="4 4"/>
<text class="tmap__lbl tmap__lbl--red" x="816" y="421" text-anchor="middle">TRAIL CLOSED · YETI</text>
</svg>
  <ul class="tmap__key" aria-label="Key">
    <li><span class="tmap__sym tmap__sym--g"></span> Green circle · One JSON Endpoint</li>
    <li><span class="tmap__sym tmap__sym--b"></span> Blue square · Router Run</li>
    <li><span class="tmap__sym tmap__sym--k"></span> Black diamond · Split Brain</li>
    <li><span class="tmap__sym tmap__sym--k"></span><span class="tmap__sym tmap__sym--k"></span> Double black · Bundle Bowl</li>
    <li><span class="tmap__sym tmap__sym--lift"></span> Chairlift · the browser, which does the climbing</li>
  </ul>
  <p class="cast__head">Who's on the hill</p>
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
    <span class="snow__tree snow__tree--c"></span>
    <span class="snow__tree snow__tree--d"></span>
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
    <span class="snow__tree snow__tree--c"></span>
    <span class="snow__tree snow__tree--d"></span>
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

<figure class="step ledger-board">
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
    <span class="snow__tree snow__tree--c"></span>
    <span class="snow__tree snow__tree--d"></span>
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
    <span class="snow__tree snow__tree--c"></span>
    <span class="snow__tree snow__tree--d"></span>
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

<div class="lodge" aria-hidden="true"></div>
<p class="lodge__caption">The lodge. Warm, well-argued, and where every SPA decision gets made over a beer.</p>

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

<div class="crash" aria-hidden="true">
  <span class="crash__tree crash__tree--a"></span>
  <span class="crash__tree crash__tree--b"></span>
  <span class="crash__tree crash__tree--c"></span>
  <span class="crash__post"></span>
  <span class="crash__ball"></span>
  <ul class="crash__junk">
    <li style="--x: 44%; --y: 64%; --r: 10deg">fetch()</li>
    <li style="--x: 9%; --y: 59%; --r: 28deg">JSON.parse</li>
    <li style="--x: 15%; --y: 78%; --r: 34deg">a spinner</li>
    <li style="--x: 10%; --y: 87%; --r: -13deg">a router</li>
    <li style="--x: 7%; --y: 60%; --r: 15deg">a store</li>
    <li style="--x: 56%; --y: 59%; --r: -10deg">scroll save/restore</li>
    <li style="--x: 14%; --y: 82%; --r: -33deg">deep link handling</li>
    <li style="--x: 75%; --y: 62%; --r: -12deg">focus management</li>
    <li style="--x: 77%; --y: 58%; --r: 33deg">a cache</li>
    <li style="--x: 77%; --y: 80%; --r: -34deg">TTLs</li>
    <li style="--x: 31%; --y: 57%; --r: 31deg">invalidation</li>
    <li style="--x: 20%; --y: 73%; --r: 13deg">optimistic updates</li>
    <li style="--x: 21%; --y: 62%; --r: 33deg">rollback</li>
    <li style="--x: 42%; --y: 66%; --r: -27deg">a retry queue</li>
    <li style="--x: 77%; --y: 67%; --r: 7deg">token refresh</li>
    <li style="--x: 15%; --y: 59%; --r: 32deg">a websocket</li>
    <li style="--x: 10%; --y: 68%; --r: 23deg">reconciliation</li>
    <li style="--x: 71%; --y: 82%; --r: 0deg">a bundler</li>
    <li style="--x: 62%; --y: 84%; --r: 6deg">code splitting</li>
    <li style="--x: 41%; --y: 70%; --r: -17deg">vendor chunks</li>
    <li style="--x: 34%; --y: 60%; --r: 33deg">hydration</li>
    <li style="--x: 41%; --y: 88%; --r: 23deg">a service worker</li>
    <li style="--x: 46%; --y: 83%; --r: -4deg">"perceived performance"</li>
  </ul>
  <span class="crash__yeti"></span>
</div>
<p class="crash__caption">The bottom of the hill. The snow is grey down here. The ball didn't survive the run, the junk is everywhere, and the yeti has been waiting since the green circle.</p>

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

## Spring: the thaw
<p class="dek">The snow melts, the meadow comes back, and it turns out the browser was under there the whole time.</p>

<div class="thaw" aria-hidden="true"></div>
<p class="thaw__caption">Spring at the base. The same hill, with the snow gone and the ground it was covering.</p>

There's a way to get what The Team wanted in the green circle, the list that
updates without a full reload, without the three runs that followed. It's not
a framework that hides the browser. It's a small script that hands the browser
more to do.

The two people are most likely to meet are [htmx](https://htmx.org/) and
[Hotwire's Turbo](https://turbo.hotwired.dev/), and they share one decision:
**the server keeps sending HTML.** htmx's own description is that it lets you
"access modern browser features directly from HTML." You put an attribute on an
element, the element makes a request, the server answers with a fragment of
HTML, and the fragment is swapped into the page. Links stay links. Forms stay
forms. The URL and the history keep working, because the library uses them
rather than replacing them.[^htmx]

Turbo's version of the same idea: "you let the server deliver HTML directly."
Turbo Drive follows links and submits forms without a full reload while keeping
the browser's history intact. Turbo Frames scope an update to one region of the
page, so the orders list can refresh on its own while the rest of the document
stands still.[^turbo]

Neither one reinvents the browser. Neither has a store, because the page is the
state. Neither has a router, because the URL is the router. Neither has a cache
to reconcile, because the server rendered the truth and the browser cached it
the way it caches everything. The filter The Team wanted in the green circle is
a form and one attribute:

```html
<form action="/orders" method="get" hx-boost="true" hx-target="#orders">
  <select name="status">
    <option>all</option>
    <option>unpaid</option>
  </select>
  <button>Filter</button>
</form>

<div id="orders">
  <!-- server-rendered rows; swapped in place on submit -->
</div>
```

Caption: <b>The green circle, done in spring.</b> A form that works with no script at all, boosted so the response replaces one region instead of the page. Same server, same HTML, no second brain.

That's the whole argument of this site in one hill. The browser is not a
rendering target. It's a thirty-year-old application platform that already
does navigation, history, caching, scroll, focus, forms and errors. Augment it a
little and it does the rest. Rebuild it and you'll spend two years on a ball.

[^htmx]: [htmx documentation](https://htmx.org/docs/). Attributes such as `hx-get`, `hx-post`, `hx-target` and `hx-swap` let any element make a request; the server responds with HTML, not JSON; `hx-boost` and `hx-push-url` keep links, forms and browser history working. It's a dependency-free script added with a single tag.

[^turbo]: [Turbo Handbook: Introduction](https://turbo.hotwired.dev/handbook/introduction). Turbo Drive intercepts links and form submissions and loads pages with fetch while maintaining browser history; Turbo Frames scope navigation to segments of a page; Turbo Streams deliver partial updates over WebSocket or SSE.

[^bfcache]: web.dev, [Back/forward cache](https://web.dev/articles/bfcache). The browser keeps the whole page in memory and restores it instantly on back or forward, state and scroll included. Chrome's figure: one in ten navigations on desktop and one in five on mobile are a back or forward.

[^scroll]: MDN, [`history.scrollRestoration`](https://developer.mozilla.org/en-US/docs/Web/API/History/scrollRestoration). The default is `auto`: the browser puts the scroll position back on history navigation. Apps set it to `manual` and then do it themselves.

[^cond]: MDN, [HTTP conditional requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Conditional_requests). `ETag` and `Last-Modified` validators, `If-None-Match`, and the `304 Not Modified` response with no body. Handled by the browser with no developer code.

[^almanac]: HTTP Archive, [Web Almanac 2024, JavaScript](https://almanac.httparchive.org/en/2024/javascript). Median mobile page: 558 KB of JavaScript over 22 requests, of which 206 KB, 44% of what was delivered, is unused.

[^webpack]: webpack, [Caching](https://webpack.js.org/guides/caching/). Output filenames carry a `[contenthash]`; the guide adds one module and shows every bundle's hash changing, then prescribes `runtimeChunk`, `splitChunks` and deterministic module ids to contain it.

[^vt]: MDN, [Using the View Transition API](https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API/Using). Cross-document transitions between same-origin pages need one rule in both documents, `@view-transition { navigation: auto; }`, and no JavaScript.

[^specrules]: MDN, [Speculation Rules API](https://developer.mozilla.org/en-US/docs/Web/API/Speculation_Rules_API). Declarative prefetch and prerender of likely next pages. Limited availability: not yet in every major browser.
