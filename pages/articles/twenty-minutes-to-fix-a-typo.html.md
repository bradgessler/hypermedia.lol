---
title: It Takes 20 Minutes to Fix a Typo. In 2006 It Took 10 Seconds.
date: September 8, 2026
byline: Brad Gessler
byline_url: https://bradgessler.com
description: In 2006 you opened the file over SFTP, fixed the character, hit save, and it was live. We traded that latency for safety, a good trade we then never revisited.
accent: amber
sprite: floppy
treatment: terminal
span: wide
---

Here's a workflow from 2006.

You spot a typo on a page. You open Dreamweaver, which has had SFTP built in
since MX 2004 and already holds the credentials for the server.[^dw] You double-click the file in the remote pane. You fix
the character. You hit <kbd>⌘S</kbd>. Dreamweaver uploads it. The next person who
requests that page gets the corrected one.

Elapsed time: about ten seconds. No build. No pipeline. No pull request. The
thing you edited *was* the thing being served. There was no artifact in between,
because the file on the server was the website.

Now go fix a typo on a modern site. Branch, commit, push, open a PR, wait for
someone to look at it, wait for CI to install dependencies, run the test suite,
run the linter, build the bundle, upload the artifact, invalidate the CDN. Twenty
minutes if nothing goes wrong, and a good chunk of that is a test suite that has
no opinion whatsoever about the character you changed.

So what happened?

## That loop was fast because it was dangerous
<p class="dek">No history, no undo, last save wins, and you were editing production.</p>

The FTP loop was fast because it was dangerous, and I don't want to pretend
otherwise.

There was no history. If you broke the page you fixed it by remembering what it
used to say. Two people editing the same file meant whoever saved last won, and
the other person's work was gone with no record it had existed. You were editing
production, live, with no rehearsal. One bad save at 2am and the site was down
until you noticed. And "it works" meant it worked in *your* browser, which in
2006 was a much smaller claim than it sounds.

Everything we added, we added for a reason. Version control gave us history and
an undo. Review caught things before customers found them. CI meant "it works on
my machine" stopped being the standard. Atomic deploys meant a half-uploaded site
was no longer a state a visitor could observe. Those were real problems and these
were real fixes, and I would not go back.

We traded latency for safety. That was a good trade.

## We won the safety and never went back for the speed
<p class="dek">Nobody chose twenty minutes. It accumulated thirty seconds at a time.</p>

We just never went back and won the latency back.

Once safety was solved, nothing forced the loop to get fast again, because
nobody's job is "make the typo fix quick." Every individual addition was
defensible, each one cost thirty seconds, and thirty seconds times forty
decisions is a workday. Nobody chose twenty minutes. It accumulated, and then it
became the water.

And look at what's actually in those twenty minutes. Installing dependencies to
render text that has none. Running an entire test suite against a one-character
copy change. Rebuilding every page on the site because one of them moved. That's
not safety, it's ceremony wearing safety's clothes. The pipeline can't tell the
difference between "fixed a typo" and "rewrote the auth system," so it treats
every change like the worst one.

The pages got slower too, which is the part that still gets me. In 2006 the
server sent finished HTML and the browser drew it. Now a depressing number of
sites send a script that fetches a description of a page and assembles it on a
phone. We made the deploy slower *and* the result slower, and got a nicer
developer experience in between.

## The best case for the twenty minutes
<p class="dek">Steelman first. The pipeline has a defence, and it's a good one.</p>

**"The pipeline catches real bugs."** It does, and it should keep doing that for
code. The argument here is about proportion, not existence: a one-character
change to a paragraph doesn't need the auth test suite, and a pipeline that can't
tell the difference is spending your time on a distinction it refuses to make.

**"Twenty minutes is nothing next to an outage."** Once, sure. The cost isn't
the twenty minutes. It's the typos that never get fixed because nobody's going to
open a pull request for a comma, and after a year a site is covered in them.

**"Editing production directly is how sites got broken and hacked."** Conceded
in full. Nothing below suggests going back to it. Git-backed editing keeps every
one of the safety properties and drops only the wait.

**"By the industry's own benchmark, twenty minutes is elite."** This is the
strongest one, and it's true. DORA's State of DevOps puts the top tier of
software teams at a lead time for changes of under a day, deploying on demand.[^dora]
Twenty minutes clears that bar by a mile. But that benchmark is for software
changes, and the fact that a paragraph is held to it is the whole complaint. In
2006 the bar for a paragraph was ten seconds. We didn't raise the bar. We
forgot there was a separate one.

## The fast loop still exists. It's the pencil icon.
<p class="dek">Edit on github.com and you get 2006 back, with a revert button.</p>

You can have most of 2006 back without giving any of the safety up. The pieces
exist.

Edit the file on github.com. The pencil icon is the Dreamweaver loop with
version control underneath.[^pencil] Type, commit, done, from a phone if you
want. You get history, a diff, and a revert button, which is strictly more than
Dreamweaver ever offered.

Then make the pipeline proportional. A static site doesn't need a test suite
gating a content change. Cache the dependency install. Deploy the build, not the
build environment. If your CI takes twenty minutes to publish a paragraph, the
problem isn't that CI exists. It's that nobody's ever looked at the bill.

This site is a fair example, and not a flattering one. Fixing a typo here means
a commit, then GitHub Actions installs Ruby, resolves gems, compiles every page,
uploads an artifact, and deploys it. Measured across the last dozen deploys,
that takes twenty-nine seconds on average, with the slowest at forty-eight.[^ours]
Three times slower than Dreamweaver was, for a site with four pages on it, and
every one of those seconds is buying the history and the revert button.

Thirty seconds is survivable. Twenty minutes is a site nobody fixes typos on,
and you can always tell which sites those are.

[^dw]: Dreamweaver MX 2004 added SFTP; Dreamweaver 8, released in 2005, added background file transfers so you could keep working while it uploaded. Adobe's [Dreamweaver 8 release notes](https://www.adobe.com/support/documentation/en/dreamweaver/dw8/releasenotes.html).

[^dora]: DORA, [State of DevOps Report 2024](https://dora.dev/research/2024/dora-report/). The four key metrics; elite performers deploy on demand with a lead time for changes under one day.

[^pencil]: GitHub Docs, [Editing files](https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files). Every commit made this way is a real commit with a real diff, which is the part Dreamweaver never had.

[^ours]: Measured on this repository with `gh run list` on the day of writing: twelve successful deploys, fastest 22 seconds, slowest 48, mean 29. That's checkout, a Ruby install, a gem resolve, a full compile, an artifact upload, and a Pages deploy.
