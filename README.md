# EvoGen GitHub workshop

Materials for a ~45 minute live-demo workshop covering three things: getting a
research project onto GitHub, giving it a DOI through Zenodo, and putting a website
in front of it by forking a template.

It is pitched at a research audience where some people have never used git, and it
is written to be *demonstrated* rather than followed along with — with beginners and
three quarters of an hour, a hands-on session disappears into installing things.

Everything is done from the terminal with `git` and the GitHub CLI, apart from two
steps on the Zenodo website and creating the organisation, neither of which has a
CLI equivalent. No analysis is run at any point, so there is nothing to install and
nothing that can break because of somebody's R or Python setup.

## What's here

`RUNSHEET.md` is the thing to read first. It has the pre-flight checklist, what to
say in each block, the gotchas worth calling out while they happen, and a
troubleshooting section for when something goes sideways in front of an audience.

`COMMANDS.sh` is every command in order, numbered to match the run sheet's blocks.
It is a copy-paste sheet, not a script — don't execute it. Keep it open in a second
window and paste from it as you talk.

`demo-repo/` is the folder you copy at the start of Block 1 and turn into a
repository live. A README, a licence, a citation file, a `.gitignore` worth talking
about, and a couple of placeholder files standing in for real work.

`staged/` holds the two things you drop into the forked website: `configure-site.sh`,
which rewrites `_config.yml`, and `site-homepage.md`, which replaces the template's
front page.

## Before you present

Read the pre-flight section of the run sheet the evening before, not the morning of.
Two things in it genuinely need doing in advance: creating the `evogen-demo`
organisation, which cannot be done from the CLI, and rehearsing the Zenodo step
against <https://sandbox.zenodo.org> rather than the real Zenodo, because published
records cannot be deleted.

The names used throughout are set as variables at the top of `COMMANDS.sh`. If
`evogen-demo` has been taken by the time you run this, change it in one place there
and everything else follows.
