#!/usr/bin/env bash
# Configure a freshly forked academicpages site.
#
# Run this from inside the clone of your forked site repo:
#   bash configure-site.sh
#
# Why a script and not "just edit the file live": _config.yml has THREE different
# keys called `name` at three different indent levels (top-level site name at
# col 0, author.name indented 2, and another under a plugin block). An
# unanchored `sed s/Your Name/.../` hits the wrong ones. Every expression below
# is anchored to its exact indentation.

set -euo pipefail

# ---- Edit these six lines, then run the script ----------------------------
ORG="evogen-demo"                                  # GitHub org (or username) that owns the site
SITE_REPO="evogen-demo.github.io"                  # repo name -> https://ORG.github.io
SITE_TITLE="EvoGen Reproducibility Demo"
YOUR_NAME="Matthew Wallace"
YOUR_BIO="PhD candidate working on bee viromes, gut microbiomes and diet."
YOUR_EMAIL="mwallace9898@outlook.com"
# ---------------------------------------------------------------------------

CONFIG="_config.yml"
[[ -f "$CONFIG" ]] || { echo "ERROR: no $CONFIG here. Are you inside the site repo clone?" >&2; exit 1; }

cp "$CONFIG" "$CONFIG.bak"   # so you can diff or undo if a demo goes sideways

# --- Top-level site settings (column 0, no leading whitespace) -------------
sed -i -E \
  -e "s|^title( +): .*|title\1: \"${SITE_TITLE}\"|" \
  -e "s|^name( +): &name .*|name\1: \&name \"${YOUR_NAME}\"|" \
  -e "s|^description( +): &description .*|description\1: \&description \"Reproducible analysis, archived and citable.\"|" \
  -e "s|^url( +): .*|url\1: \"https://${ORG}.github.io\"|" \
  -e "s|^baseurl( +): .*|baseurl\1: \"\"|" \
  -e "s|^repository( +): .*|repository\1: \"${ORG}/${SITE_REPO}\"|" \
  "$CONFIG"

# --- Author block ----------------------------------------------------------
# Matched on the template's placeholder VALUES, not on the key names. Keying off
# `^  name` would also hit `social.name`, which sits at the same indent further
# down the file. Each of these placeholder strings occurs exactly once.
sed -i \
  -e "s|\"Your Sidebar Name\"|\"${YOUR_NAME}\"|" \
  -e "s|\"Short biography for the left-hand sidebar\"|\"${YOUR_BIO}\"|" \
  -e "s|\"Earth\"|\"Sydney, Australia\"|" \
  -e "s|\"Red Brick University\"|\"Macquarie University\"|" \
  -e "s|\"none@example.org\"|\"${YOUR_EMAIL}\"|" \
  -e "s|\"academicpages\"|\"${ORG}\"|" \
  "$CONFIG"

echo "Changed lines:"
diff "$CONFIG.bak" "$CONFIG" || true

echo
echo "Sanity check -- these must all be YOUR values, not the template defaults:"
grep -nE "^(title|name|url|baseurl|repository) +:" "$CONFIG"
