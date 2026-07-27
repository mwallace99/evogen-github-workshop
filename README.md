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

`PREREQUISITES.md` is the email to send a week beforehand. It asks for one thing: a
GitHub account with a verified email address.

`HANDOUT.md` is what attendees follow during the hands-on block. Print it or share
the link — don't make people work from your screen.

## The website they build

Attendees fork **<https://github.com/mwallace99/evogen-website-template>**, a trimmed
copy of [Academic Pages](https://github.com/academicpages/academicpages.github.io)
with the developer tooling and most of the example content removed. Setup is
browser-only: fork, edit five lines, switch Pages on.

A finished example lives at
**<https://mwallace99.github.io/evogen-website-preview/>** — show it before anyone
starts, and keep it open as a fallback.

Put an ORCID iD in `_config.yml` and the Publications page fills itself from that
ORCID record, so it stays current with no maintenance. Google Scholar can't be
automated the same way — no public API, and scraping breaks Google's terms — so the
template links to a Scholar profile instead.

## Before you present

Read the pre-flight section of the run sheet the evening before, not the morning of.
Two things in it genuinely need doing in advance: sending the prerequisites email and
chasing anyone who hasn't set up a GitHub account, and rehearsing the Zenodo step
against <https://sandbox.zenodo.org> rather than the real Zenodo, because published
records cannot be deleted.

Rehearse Block 3 by forking the template into a spare account and following
`HANDOUT.md` exactly as an attendee would. That's the only reliable way to find the
step where your own instructions turn out to be ambiguous.
