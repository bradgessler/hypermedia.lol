---
title: Every Motherfucking Website, Measured. One Is Perfect. One Won't Load.
date: September 8, 2026
byline: Brad Gessler
byline_url: https://bradgessler.com
description: Four profane single-page manifestos have argued for plain HTML for over a decade. I ran all of them through Lighthouse, plus craigslist, Legible News, and this site. The numbers are funnier than the pages.
accent: sky
sprite: brick
treatment: default
span: tall
---

<p class="lede">Four one-page websites with a swear word in the domain have been
making the case for plain HTML since 2013. Everyone links them. Nobody measures
them. So I did, and then I measured the sites people point to as proof the
argument works in the real world.</p>

Before there was a name for any of this, there was
[motherfuckingwebsite.com](https://motherfuckingwebsite.com/).

One page. Black text on white. No framework, no build step, no cookie banner, no
newsletter interstitial. The argument, delivered at a volume the domain prepares
you for, is that a plain HTML document is already responsive, already
accessible, already fast, and already works on every device anyone owns, and
that most of what gets layered on top is the designer creating problems and then
charging to solve them.

It's a joke that turned out to be right about almost everything. The
interesting part is that people kept answering it, and the replies form an
argument in order.

## Four manifestos, each moving the line a few declarations
<p class="dek">Read in order, they argue with each other, and the argument goes somewhere.</p>

**[motherfuckingwebsite.com](https://motherfuckingwebsite.com/)** is the thesis.
Use HTML. Your document is already fine.

**[bettermotherfuckingwebsite.com](https://bettermotherfuckingwebsite.com/)** is
the first rebuttal, and the most useful one. It concedes that the original is
unpleasant to read, and fixes it with a handful of CSS declarations: line
height, a measure you can track across, some margin, a grey that isn't `#000`.
"No framework" and "no typography" are different claims, and only one of them
was ever defensible.

**[perfectmotherfuckingwebsite.com](https://perfectmotherfuckingwebsite.com/)**
raises the bid to ten declarations, a media query, and one attribute. The
attribute is `lang` on `<html>`, and hold that thought. It also picks up
`prefers-color-scheme`, so it won't bleach your eyes at 1am, and it gets fussy
about proper quotes.

**[thebestmotherfucking.website](https://thebestmotherfucking.website/)** is the
maximalist entry. It keeps a running weight budget in the copy and exists to
make the point that you can have a real design, a webfont, an image, and still
be an order of magnitude lighter than the median site.

There's also **[justfuckingusehtml.com](https://justfuckingusehtml.com/)**, the
same argument aimed at people reaching for a single-page app to render a
brochure.

## I ran every one of them through Lighthouse
<p class="dek">Mobile emulation, simulated throttling, same engine as PageSpeed Insights. Here's the table.</p>

| Site | Performance | Accessibility | Total weight | Requests | JavaScript | Largest paint |
|---|---:|---:|---:|---:|---:|---:|
| perfectmotherfuckingwebsite.com | **100** | **100** | 3 KB | 2 | 0 KB | 0.9 s |
| **hypermedia.lol** (this site) | **100** | **100** | 14 KB | 3 | 0 KB | 0.9 s |
| justfuckingusehtml.com | **100** | 94 | 31 KB | 9 | 18 KB | 1.0 s |
| motherfuckingwebsite.com | **100** | 88 | 181 KB | 6 | 179 KB | 1.0 s |
| thebestmotherfucking.website | **100** | 87 | 114 KB | 17 | 1 KB | 1.4 s |
| legiblenews.com | **100** | 88 | 83 KB | 10 | 58 KB | 1.3 s |
| sfbay.craigslist.org | 45 | 82 | 737 KB | 10 | 628 KB | 6.1 s |
| bettermotherfuckingwebsite.com | [fails to load](#the-better-one-does-not-load) | | 1.9 KB over plain HTTP | | | |
| *Median mobile page, Oct 2024* | | | *2,311 KB* | *66* | *558 KB* | |

Caption: Lighthouse 12, mobile, simulated throttling, run from one laptop on the day of writing; scores move a few points between runs.[^method] The median row is the HTTP Archive's Web Almanac.[^almanac]

Some of this is what you'd expect. The perfect one is perfect: three kilobytes,
two requests, no script, two clean 100s. This site, which took the canon as its
editorial policy, lands in the same row with eleven more kilobytes of CSS. And
every page in the canon paints in about a second on a throttled phone, against
a median page that is six hundred times heavier than the best of them.

Then there are the parts that are funnier than the pages.

## The original is 98% Google Analytics by weight
<p class="dek">Two kilobytes of HTML, 179 kilobytes of tracking. The manifesto against bloat ships more script than most of its readers.</p>

motherfuckingwebsite.com is 181 KB on the wire. The document is 2.2 KB of it.
The other 179 KB is `analytics.js` and Google Tag Manager's `gtag/js`, which
between them are 81 times the size of the page they're measuring.[^mfw] It still
scores 100, because a throttled phone can chew through that much JavaScript in
under a second, and because Lighthouse grades the experience, not the irony.

It also loses twelve accessibility points for one reason: `<html>` has no
`lang` attribute. Which is the exact attribute the *perfect* motherfucking
website added, four years later, with a paragraph explaining why. The canon
corrected itself and the original never took the note.

## The better one does not load
<p class="dek">bettermotherfuckingwebsite.com times out over HTTPS. It's still there on plain HTTP, all 1.9 KB of it.</p>

Chrome refuses it with an interstitial, curl times out, and Lighthouse can't
score it. Over unencrypted HTTP it answers in 1,943 bytes. So the page that
taught everyone `line-height: 1.4` is currently unreachable from a modern
browser's address bar, which is its own lesson about what "just HTML" leaves
out: someone still has to renew the certificate.

## craigslist is not fast any more
<p class="dek">The site everyone cites as proof that plain HTML wins scores 45 on mobile and ships 628 KB of JavaScript.</p>

I expected craigslist to top this table. It's the canonical example of a
business that never redesigned and never needed to. It scored **45**. A city
page is 737 KB, 628 of them JavaScript, and the largest paint lands at six
seconds on a throttled phone. The `<html>` element has no `lang`, and there are
links a screen reader announces as nothing.[^cl]

None of that is visible from a desk. The famous blue links are still there. What
changed is everything underneath them, one dependency at a time, until the
plain-HTML site was a 628 KB app wearing the plain-HTML site's clothes. That's
the drift this whole canon is about, happening to its favourite example.

## Legible News shows the argument works for a real product
<p class="dek">A daily news site, 83 KB, one-second paint, and a page that ranks the competition.</p>

[Legible News](https://legiblenews.com/) is a real product with real readers,
and it scores 100 at 83 KB, which is to say it's lighter than the original
motherfucking website. Its 58 KB of script is for a reader, not a tracker.

It also publishes the comparison I'd have had to make myself.
[legiblenews.com/speed](https://legiblenews.com/speed) runs the major news
outlets through PageSpeed Insights and ranks them: Legible News at 100, USA
Today at 95, the Financial Times at 91, and then a long slide down through NPR
at 39, the New York Times at 30, and CNN at 17.[^ln] Same engine as my table,
different neighbourhood. The median news site is a fine demonstration of what
a decade of adding things to a document gets you.

## The best case against the canon
<p class="dek">Steelman first. The obvious objection is that these are toys.</p>

**"They're single pages with no product behind them. Of course they're 3 KB."**
True of the canon. Not true of Legible News, which publishes every day and
sits in the same row. And the median page isn't 2.3 MB because it has a
product; it's 2.3 MB because nobody looked.[^almanac]

**"Users don't notice a second."** Google's own guidance draws the good line
for largest paint at 2.5 seconds.[^lcp] The canon is at one. craigslist is at
six. The gap isn't a second.

**"Accessibility isn't free either. Half of these lose points."** They do, and
the losses are instructive: a missing `lang`, a low-contrast grey, a
`tabindex` above zero. Each is one line. The 82 at the bottom of the table is
missing `lang` and has unnamed links, on a page carrying 628 KB of script that
could have added either.

**"craigslist is fine. People use it every day."** They do, and they'd use it
on a worse connection with a six-second first paint too, because there's no
alternative. That's not evidence the weight is free. It's evidence the users
have nowhere else to go.

## Nobody in the sequence is against CSS
<p class="dek">What they're against is the default.</p>

Read in order, they're not four people saying the same thing louder. They're a
negotiation about where the line is, and each one moves it by a few
declarations.

Nobody in that sequence is against CSS. Nobody's against design. What they're
against is the *default*: the reflex where a page that could be a document
becomes a build pipeline, a hydration step, and half a megabyte of JavaScript
before anyone has written a sentence. The table above is that reflex, measured.

The through-line is just: start from the document. Add what the page needs, and
be able to say what each addition bought you. Then, every so often, measure it,
because the original stopped doing that and picked up 179 KB of analytics
without noticing.

That's the whole editorial policy of this site, and those four pages got there
first.

[^method]: Lighthouse 12 via the CLI with mobile emulation and simulated throttling, which is the same configuration PageSpeed Insights reports. One run per site from a laptop in California on the day of writing. Treat single digits as noise and tens as signal. "Total weight" is Lighthouse's total byte weight; "JavaScript" is the transfer size of script requests; "largest paint" is Largest Contentful Paint.

[^almanac]: HTTP Archive, [Web Almanac 2024, Page Weight](https://almanac.httparchive.org/en/2024/page-weight). Median mobile page in October 2024: 2,311 KB over 66 requests, of which 558 KB is JavaScript. Mobile weight is up 357% over the decade.

[^mfw]: The request log for motherfuckingwebsite.com: the document at 2.2 KB, `www.google-analytics.com/analytics.js` at 20.9 KB, and `www.googletagmanager.com/gtag/js` at 157.6 KB, plus two collection beacons and a favicon. The accessibility deduction is the `html-has-lang` audit.

[^cl]: sfbay.craigslist.org, the page a person in the Bay Area actually lands on. The bare www.craigslist.org region chooser scores 65 with the same weight. Accessibility deductions are `html-has-lang` and `link-name`.

[^ln]: [legiblenews.com/speed](https://legiblenews.com/speed), which ranks 24 news sites by PageSpeed Insights score. Figures as published when I looked; they re-run over time.

[^lcp]: web.dev, [Largest Contentful Paint](https://web.dev/articles/lcp): 2.5 seconds or less is "good", over 4 seconds is "poor".
