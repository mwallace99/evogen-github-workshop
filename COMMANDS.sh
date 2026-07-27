#!/usr/bin/env bash
# ============================================================================
#  EvoGen GitHub workshop -- every command, in order.
#
#  DO NOT run this file as a script. It is a copy-paste sheet. Work block by
#  block while you talk. Blocks marked [WEB] are the few steps with no CLI
#  equivalent. Blocks map 1:1 onto the sections of RUNSHEET.md.
#
#  Nothing here runs an analysis. No R, no Python, no dependencies to install.
# ============================================================================


# ---------------------------------------------------------------------------
# BLOCK 0 -- Before the audience arrives
# ---------------------------------------------------------------------------

# Where the workshop folder lives (adjust if you moved it)
export SEM="/mnt/c/Users/48441848/OneDrive - Macquarie University/01_Thesis/06_Talks/EvoGen_github_seminar"

# Clean scratch space. Wiped each rehearsal so the demo always starts identical.
export DEMO="$HOME/evogen-demo-live"
rm -rf "$DEMO" && mkdir -p "$DEMO"

# Names used throughout. Only Blocks 1 and 2 use the terminal; Block 3 is all
# browser, so there is nothing to configure for it.
export GH_USER="mwallace99"
export REPO="bee-virome-demo"

# Your git identity. user.email is currently UNSET on this machine -- without it
# your very first commit fails, on stage, in front of everyone.
git config --global user.name  "Matthew Wallace"
git config --global user.email "mwallace9898@outlook.com"

# Defaults that avoid mid-demo prompts and surprises
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global pull.rebase false

# Confirm login and scopes (you need: repo, workflow)
gh auth status

# Terminal readable from the back row: font ~18-20pt, and a short prompt:
#   export PS1="\[\e[1;32m\]demo\$\[\e[0m\] "


# ---------------------------------------------------------------------------
# BLOCK 1 -- A folder becomes a repository  (~15 min)
# ---------------------------------------------------------------------------

# 1.1  Start from an ordinary folder of files, as it would sit on your laptop
cd "$DEMO"
mkdir "$REPO" && cd "$REPO"
cp -r "$SEM/demo-repo/." .
ls -R

# 1.2  Make it a repository. Nothing has left your machine yet.
git init
git status

# 1.3  Show what is being ignored, and why. This is the slide that saves careers.
cat .gitignore

# 1.4  Prove it works: create the kind of file that must never be committed,
#      then show git refusing to see it.
mkdir -p results && echo "fake output" > results/figure1.png
echo "AWS_KEY=hunter2" > .env
git status --short          # <- neither one appears. Pause on this.

# 1.5  First commit
git add -A
git status --short          # confirm: no results/, no .env
git commit -m "Initial commit: project skeleton, licence and citation metadata"
git log --oneline

# 1.6  Create the GitHub repo and push, in one command
gh repo create "$REPO" --public --source=. --remote=origin --push

# 1.7  Look at it. Point out that GitHub has already read CITATION.cff and put a
#      "Cite this repository" button in the sidebar.
gh repo view --web

# 1.8  Now the actual point of version control: make a change and show the diff.
sed -i 's|^A skeleton research repository|A skeleton research repository (updated live at EvoGen)|' README.md
git diff                    # <- pause. Let them read the red and green.

# 1.9  Commit it and show the history building up
git commit -am "Note that this was edited during the workshop"
git push
git log --oneline

# 1.10 Undo is free. Go back to how the file looked one commit ago.
git restore --source=HEAD~1 README.md
git diff
git restore README.md       # ...and change your mind again


# ---------------------------------------------------------------------------
# BLOCK 2 -- A DOI from Zenodo  (~12 min)
# ---------------------------------------------------------------------------

# 2.1  [WEB] Link Zenodo to GitHub. DO THIS BEFORE THE RELEASE.
#      Zenodo only sees releases created AFTER you flip the switch. A release
#      made first gets no DOI and there is no way to backfill it. This is the
#      single most common way people get this wrong.
#
#        https://zenodo.org/account/settings/github/
#        -> log in with GitHub -> "Sync now"
#        -> find bee-virome-demo -> toggle ON
#
#      Only PUBLIC repositories appear in that list.

# 2.2  Verify the webhook exists before you promise anything on stage
gh api "repos/$GH_USER/$REPO/hooks" --jq '.[].config.url'
#      Expect a zenodo.org URL. Empty output means the toggle did not take --
#      hit "Sync now" and re-toggle.

# 2.3  Cut the release. This is the moment the DOI is minted.
gh release create v1.0.0 \
  --title "v1.0.0 -- EvoGen workshop" \
  --notes "First archived version of the workshop demo repository."

# 2.4  Zenodo picks it up within a minute
gh release view v1.0.0 --web
#      [WEB] refresh https://zenodo.org/account/settings/github/
#      A DOI badge appears beside the repo. Click through to the record and show
#      them: Zenodo has archived a full zip of the repo at that exact commit.

# 2.5  Explain the two DOIs on that page:
#        - the VERSION DOI  -> this release, forever, unchangeable
#        - the CONCEPT DOI  -> "whatever the latest version is"
#      Cite the version DOI in a paper. Put the concept DOI in your CV.

# 2.6  Put the badge in the README. Replace XXXXXXX with your real record number.
export DOI="10.5281/zenodo.XXXXXXX"
sed -i "1i [![DOI](https://zenodo.org/badge/DOI/${DOI}.svg)](https://doi.org/${DOI})\n" README.md
head -3 README.md

# 2.7  Point the citation file at the real repository
sed -i "s|https://github.com/OWNER/REPO|https://github.com/$GH_USER/$REPO|" CITATION.cff

git commit -am "Add Zenodo DOI badge and citation metadata"
git push
gh repo view --web


# ---------------------------------------------------------------------------
# BLOCK 3 -- A website, by forking  (~25 min, HANDS ON)
#
# This block is almost entirely [WEB]. Attendees follow HANDOUT.md on their own
# machines; you mirror every step on the projector, one step ahead of them.
# Deliberately no command line -- installing git and gh for a room of beginners
# is a twenty-minute detour that fails differently on every laptop.
# ---------------------------------------------------------------------------

# 3.1  [WEB] Show them where they are heading, before anyone touches anything.
#      https://mwallace99.github.io/evogen-website-preview/

# 3.2  [WEB] Everyone forks the template.
#      https://github.com/mwallace99/evogen-website-template
#      Fork button -> Repository name: THEIRNAME.github.io
#      -> tick "Copy the main branch only" -> Create fork
#
#      CHECKPOINT 1: hands up when you see "forked from mwallace99/..."

# 3.3  [WEB] Everyone edits _config.yml (pencil icon) and changes five lines:
#        title       your site title
#        name        your name  (keep the &name part!)
#        url         "https://THEIRNAME.github.io"
#        repository  "THEIRNAME/THEIRNAME.github.io"
#        bio         a sentence about their research
#      Then: Commit changes.
#
#      Only url and repository have to be right. Keep the quotes; don't touch
#      the indentation.
#
#      CHECKPOINT 2: hands up when you can see your own name in the file

# 3.4  [WEB] Settings -> Pages -> Source: "Deploy from a branch"
#                                 Branch: main   Folder: / (root)  -> Save
#
#      CHECKPOINT 3: hands up when it says your site is being built

# 3.5  Wait 1-3 minutes. Use it: take questions, and mention the ORCID feature
#      (add author.orcid_id to _config.yml and the Publications page fills
#      itself from ORCID). Be straight that Google Scholar cannot do this --
#      no public API, and scraping breaks their terms.

# 3.6  [WEB] https://THEIRNAME.github.io
#
#      CHECKPOINT 4: done.

# --- Your own copy, if you want one on screen ------------------------------
# You cannot fork to mwallace99.github.io -- that name is taken by your real
# site. Either drive a spare account, or fork to a different name and add
# baseurl: "/thatname" to _config.yml.

# --- Troubleshooting, from the front of the room ---------------------------
# Red X on their repo        -> broken YAML. File -> History -> revert.
# 404 that will not go away  -> repo name must be exactly THEIRNAME.github.io
# Loads but unstyled         -> url line wrong in _config.yml
# Nothing ever publishes     -> unverified email; github.com/settings/emails


# ---------------------------------------------------------------------------
# BLOCK 4 -- Teardown (AFTER the workshop, not during)
# ---------------------------------------------------------------------------
# gh repo delete "$GH_USER/$REPO" --yes
# gh repo delete "$ORG/$ORG.github.io" --yes
#
# Zenodo records CANNOT be deleted once published -- that is what an archive
# means. Rehearse against https://sandbox.zenodo.org instead.
