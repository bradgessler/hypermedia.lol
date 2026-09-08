---
title: Twenty minutes to fix a typo
date: September 8, 2026
description: In 2006 you opened the file over SFTP, fixed the character, hit save, and it was live. We traded that latency for safety — a good trade we then never revisited.
accent: amber
sprite: floppy
---

Here's a workflow from 2006.

You spot a typo on a page. You open Dreamweaver, which already has the SFTP
credentials for the server. You double-click the file in the remote pane. You fix
the character. You hit <kbd>⌘S</kbd>. Dreamweaver uploads it. The next person who
requests that page gets the corrected one.

Elapsed time: about ten seconds. No build. No pipeline. No pull request. The
thing you edited *was* the thing being served — there was no artifact in between,
because the file on the server was the website.

Now go fix a typo on a modern site. Branch, commit, push, open a PR, wait for
someone to look at it, wait for CI to install dependencies, run the test suite,
run the linter, build the bundle, upload the artifact, invalidate the CDN. Twenty
minutes if nothing goes wrong, and a good chunk of that is a test suite that has
no opinion whatsoever about the character you changed.

So what happened?

## The honest part

The FTP loop was fast because it was dangerous, and I don't want to pretend
otherwise.

There was no history. If you broke the page you fixed it by remembering what it
used to say. Two people editing the same file meant whoever saved last won, and
the other person's work was gone with no record it had existed. You were editing
production, live, with no rehearsal — one bad save at 2am and the site was down
until you noticed. And "it works" meant it worked in *your* browser, which in
2006 was a much smaller claim than it sounds.

Everything we added, we added for a reason. Version control gave us history and
an undo. Review caught things before customers found them. CI meant "it works on
my machine" stopped being the standard. Atomic deploys meant a half-uploaded site
was no longer a state a visitor could observe. Those were real problems and these
were real fixes, and I would not go back.

We traded latency for safety. That was a good trade.

## The part nobody did

We just never went back and won the latency back.

Once safety was solved, nothing forced the loop to get fast again, because
nobody's job is "make the typo fix quick." Every individual addition was
defensible, each one cost thirty seconds, and thirty seconds times forty
decisions is a workday. Nobody chose twenty minutes. It accumulated, and then it
became the water.

And look at what's actually in those twenty minutes. Installing dependencies to
render text that has none. Running an entire test suite against a one-character
copy change. Rebuilding every page on the site because one of them moved. That's
not safety, it's ceremony wearing safety's clothes — the pipeline can't tell the
difference between "fixed a typo" and "rewrote the auth system," so it treats
every change like the worst one.

The pages got slower too, which is the part that still gets me. In 2006 the
server sent finished HTML and the browser drew it. Now a depressing number of
sites send a script that fetches a description of a page and assembles it on a
phone. We made the deploy slower *and* the result slower, and got a nicer
developer experience in between.

## What the fast loop looks like now

You can have most of 2006 back without giving any of the safety up. The pieces
exist.

Edit the file on github.com — the pencil icon is genuinely the Dreamweaver loop
with version control underneath. Type, commit, done, from a phone if you want.
You get history, a diff, and a revert button, which is strictly more than
Dreamweaver ever offered.

Then make the pipeline proportional. A static site doesn't need a test suite
gating a content change. Cache the dependency install. Deploy the build, not the
build environment. If your CI takes twenty minutes to publish a paragraph, the
problem isn't that CI exists — it's that nobody's ever looked at the bill.

This site is a fair example, and not a flattering one. Fixing a typo here means
a commit, then GitHub Actions installs Ruby, resolves gems, compiles every page,
uploads an artifact, and deploys it. That's about a minute — six times slower
than Dreamweaver was, for a site with four pages on it.

A minute is survivable. Twenty is a site nobody fixes typos on, and you can
always tell which sites those are.
