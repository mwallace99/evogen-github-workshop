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

# Names used throughout
export GH_USER="mwallace99"
export REPO="bee-virome-demo"
export ORG="evogen-demo"

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
# BLOCK 3 -- A website, by forking  (~15 min)
# ---------------------------------------------------------------------------

# 3.1  Fork academicpages into the org, renaming as we go. Naming the repo
#      <org>.github.io is what gets a clean root URL with no baseurl juggling.
#      --default-branch-only keeps the fork small.
gh repo fork academicpages/academicpages.github.io \
  --org "$ORG" \
  --fork-name "$ORG.github.io" \
  --default-branch-only

# 3.2  Clone it, shallow -- you want the template, not eight years of its history
cd "$DEMO"
gh repo clone "$ORG/$ORG.github.io" -- --depth 1
cd "$ORG.github.io"

# 3.3  Delete the workflows inherited from upstream. They are that project's own
#      CI (PR linting, a scheduled scraper). In your fork they are noise that
#      will email you about failures forever.
rm -rf .github/workflows

# 3.4  Configure the site. Open the script and show them the six variables first.
cp "$SEM/staged/configure-site.sh" .
sed -n '15,25p' configure-site.sh
bash configure-site.sh

# 3.5  Replace the homepage
cp "$SEM/staged/site-homepage.md" _pages/about.md

# 3.6  Ship it
git add -A
git commit -m "Configure site for EvoGen workshop"
git push

# 3.7  Turn on GitHub Pages: source is the main branch, root folder.
#      academicpages is built by Pages' own Jekyll builder, not by a workflow --
#      which is why this is "deploy from a branch" rather than "GitHub Actions".
gh api -X POST "repos/$ORG/$ORG.github.io/pages" \
  -f "source[branch]=main" -f "source[path]=/"

# 3.8  Watch it build. Takes 1-3 minutes -- fill it with the fork-vs-template
#      talk, or take questions.
gh api "repos/$ORG/$ORG.github.io/pages" --jq '.status, .html_url'

# 3.9  Open the finished site
echo "https://$ORG.github.io/"

# 3.10 Optional closer, costs nothing: the build you just watched WAS automation.
#      Show them the deployment history and make the point that they have been
#      using CI for the last three minutes without being told.
gh api "repos/$ORG/$ORG.github.io/deployments" --jq '.[0] | {environment, created_at}'


# ---------------------------------------------------------------------------
# BLOCK 4 -- Teardown (AFTER the workshop, not during)
# ---------------------------------------------------------------------------
# gh repo delete "$GH_USER/$REPO" --yes
# gh repo delete "$ORG/$ORG.github.io" --yes
#
# Zenodo records CANNOT be deleted once published -- that is what an archive
# means. Rehearse against https://sandbox.zenodo.org instead.
