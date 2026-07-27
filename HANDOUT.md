# Build your own website — follow along

Print this, or share it as a link. Everything happens in your browser. Nothing to
install, no command line.

Wherever you see `YOURNAME`, put your own GitHub username.

---

Here's one already finished, so you can see where you're heading:
**<https://mwallace99.github.io/evogen-website-preview/>**

---

## Step 1 — Take your own copy of the template

Go to **<https://github.com/mwallace99/evogen-website-template>**

Click the **Fork** button, top right. A fork is your own copy of somebody else's
project, which you can change however you like without affecting theirs.

On the page that appears, change **Repository name** to exactly:

```
YOURNAME.github.io
```

That exact name is what gives you the clean web address `https://YOURNAME.github.io`.
Getting it wrong doesn't break anything permanently — you can rename later — but it's
easier now.

Tick **Copy the main branch only**, then click **Create fork**.

> **Already have a repository called `YOURNAME.github.io`?** Call this one
> `my-site` instead and put your hand up — there's one extra setting you'll need and
> it takes ten seconds.

✅ **Checkpoint:** you're looking at a page titled `YOURNAME/YOURNAME.github.io`, with
"forked from mwallace99/evogen-website-template" underneath it.

If you see a yellow banner about workflows being disabled, ignore it. That's a good
thing and you don't need them.

---

## Step 2 — Put your own details in

In your new repository, click on the file **`_config.yml`**.

Click the **pencil icon** (top right of the file) to edit it.

Change these five things. They're all near the top — the line numbers are a guide,
but use the names to find them, since they shift as the template is updated.

| Line | Setting | Change it to |
|---|---|---|
| ~12 | `title` | Your site's title, in quotes |
| ~14 | `name` | Your name — **keep the `&name` bit**, only change the text in quotes |
| ~16 | `url` | `"https://YOURNAME.github.io"` |
| ~19 | `repository` | `"YOURNAME/YOURNAME.github.io"` |
| ~29 | `bio` | A sentence about you, in quotes |

**`url` and `repository` are the two that must be right.** The other three are just
so the site looks like yours.

Two rules that will save you: keep the quotes, and don't change the spacing at the
start of a line. This file cares about indentation.

Scroll to the bottom, then click the green **Commit changes** button. A commit is a
save point — you can leave the message as it is.

✅ **Checkpoint:** you're back on the file view and your own name is visible in it.

---

## Step 3 — Switch the website on

Click **Settings** (along the top of your repository, with the gear icon).

In the left-hand menu, click **Pages**.

Under **Build and deployment → Source**, choose **Deploy from a branch**.

Underneath, set the branch to **`main`** and the folder to **`/ (root)`**. Click
**Save**.

✅ **Checkpoint:** the page now says your site is being built, or shows a web address.

---

## Step 4 — Wait, then look

The first build takes **one to three minutes**. Nothing you can do makes it faster.

Refresh the Settings → Pages screen until it shows a live link, then open:

```
https://YOURNAME.github.io
```

✅ **Done.** That's a real website, on the real internet, that you can put on a poster.

---

## If it doesn't work

**A 404 page.** Almost always just too early — wait another two minutes and refresh.
If it persists, check that your repository is named exactly `YOURNAME.github.io`, all
lowercase.

**The page loads but looks like plain text with no styling.** The `url` line in
`_config.yml` is wrong. Go back and check it's `"https://YOURNAME.github.io"` with
the quotes and no trailing slash.

**Nothing happens at all, and Settings → Pages looks fine.** Check your GitHub email
address is verified — <https://github.com/settings/emails>. Pages will not publish
for unverified accounts and it doesn't warn you.

**A red X appeared on your repository.** Something in `_config.yml` has a formatting
problem, usually a missing quote or changed indentation. Open the file's **History**,
find your edit, and you can undo it.

**You're stuck and everyone else has moved on.** Put your hand up. Nothing here is
time-critical and the site will still be there tomorrow.

---

## Afterwards

Your site's pages live in the **`_pages`** folder — edit those the same way you edited
`_config.yml`. Publications, talks and CV each have their own file.

### Publications that keep themselves up to date

If you have an ORCID iD, add it to `_config.yml`:

```yaml
author:
  orcid_id : "0000-0002-1825-0097"     # your own iD, digits only
```

That's the entire setup. Your Publications page then fills itself from your ORCID
record, grouped by year with DOI links, and a new paper appears on your site as soon
as it appears on ORCID. Nothing to rebuild and nothing to maintain.

Google Scholar can't do this — Google provides no API for it and scraping breaks
their terms — so the sidebar links to your Scholar profile instead. If your ORCID
record is thin, ORCID's *Search & Link* wizards will import from Crossref, Scopus and
PubMed in a few clicks; do that once and this page looks after itself.

### Where to go next

A fuller guide to the underlying template is at <https://academicpages.github.io>.
Everything from this session is at
<https://github.com/mwallace99/evogen-github-workshop>.
