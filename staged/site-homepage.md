---
permalink: /
title: "Get your work onto GitHub"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

This site was built live, from a fork, during an EvoGen workshop. It took about
fifteen minutes and cost nothing. That is roughly the point.

## What the workshop covers

**Putting a project under version control.** Not for the branching and merging —
for the plainer benefit that your work acquires a history. You can see what changed,
when, and why; you can undo things; and the settings that shaped your results stop
being half-remembered and start being written down in a file with a timestamp.

**Giving it a DOI.** A GitHub URL tells you where code lives today. A DOI tells you
what it was on the day you used it. Zenodo watches your repository and mints a DOI
automatically every time you make a release, which costs one click to set up and one
command to use. Journals increasingly ask for this, and it is much easier to do as
you go than to reconstruct later.

**Putting a website in front of it.** GitHub will host a site for you for free. You
do not have to write it: fork a template, change half a dozen lines in a config
file, and you have a page you can put on a conference poster.

## The one thing to remember

Set up the Zenodo link *before* you make your first release. Zenodo only sees
releases created after you flip the switch, and a release made beforehand cannot be
backfilled — you would have to cut a second one.

## Materials

The run sheet, the full list of commands, and the demo repository are all available
from the workshop organiser. Everything shown was done from the terminal with
`git` and the GitHub CLI (`gh`), apart from two clicks on the Zenodo website.
