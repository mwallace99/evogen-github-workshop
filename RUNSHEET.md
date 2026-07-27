# EvoGen GitHub workshop — run sheet

Three things, live, from the terminal: get a project onto GitHub, give it a DOI
through Zenodo, and put a website in front of it by forking a template. Pitched at
an audience where some people have never used git at all.

`COMMANDS.sh` has every command in order, numbered to match the blocks below. Keep
it open in a second window and paste from it. Don't run it as a script.

Nothing here runs an analysis. No R, no Python, no packages to install. That's
deliberate — the moment a demo depends on somebody's environment, it breaks.

---

## Decide this first: they watch, they don't follow along

With mixed-to-no experience and 45 minutes, run it as a demonstration. Say so in
your first minute — *"you don't need laptops open, I'll send you all of this
afterwards"* — because otherwise half the room spends Block 1 installing git,
someone's `gh auth login` opens a browser they can't find, and twenty minutes go to
setup that teaches nobody anything.

Everything below assumes that. A genuine hands-on version is a two-hour session with
a setup email a week beforehand, and it's a different build.

---

## Timing

| Start | Block | Runs |
|---|---|---|
| 0:00 | Framing — git vs GitHub | 5 min |
| 0:05 | Block 1 — a folder becomes a repository | 15 min |
| 0:20 | Block 2 — a DOI from Zenodo | 12 min |
| 0:32 | Block 3 — a website, by forking | 15 min |
| 0:47 | Wrap | 3 min |

Fifty on paper: about 45 if you're crisp, about 60 with questions. Beginners ask
more than you expect and you want them to. Two things are marked **CUT** below —
drop those first if you're behind, and don't drop anything else.

---

## The evening before

Twenty minutes, and it removes almost every way this can go wrong.

**Create the org.** Free GitHub organisations can't be made from the CLI — the API
endpoint is Enterprise-only — so this one is a web step:
<https://github.com/organizations/plan> → Free → name it `evogen-demo`. The name was
available when this was written; if it's gone, pick another and change `ORG` at the
top of `COMMANDS.sh`.

An org rather than your own account, for three reasons: your personal
`mwallace99.github.io` already exists and hosts your real site, so the demo can't use
that name; an org site gets the clean root URL `https://evogen-demo.github.io/` with
no `baseurl` fiddling; and it's disposable afterwards. It also lets you make the
aside that a lab should have one of these.

**Set your git identity.** `git config --global user.email` is unset on this
machine. Without it your first commit fails on stage. Block 0 fixes it.

**Rehearse against Zenodo Sandbox**, not the real thing —
<https://sandbox.zenodo.org>. Published Zenodo records cannot be deleted. Rehearsing
against production leaves permanent junk DOIs with your name on them.

**Do a full dry run**, including the fork, then delete both repos. The fork is the
step with the most moving parts and the longest wait.

**Check the room's projector** with your actual terminal font size. 18–20pt.

**Have the finished versions open in browser tabs** as a fallback: a repo with a DOI
badge, a Zenodo record, and a built site. If the network dies you can still talk
through all three.

---

## 0:00 — Framing (5 min)

Don't open with tooling. Open with the folder. Everyone in the room has
`analysis_final_v3_actually_final.R`, everyone laughs, and that's your hook.

Then spend ninety seconds on the distinction beginners get stuck on for months and
that nobody ever explains to them:

> **Git is not GitHub.** Git is track-changes running on your own laptop. It works
> offline, on a machine that never touches the internet. GitHub is a website you can
> choose to send a copy to.

People conflate the two and then get frightened that everything they do will be
public. Say it once, clearly, and half your questions disappear.

Two more definitions, one sentence each, and no more than that:

- A **commit** is a save point with a note attached — and *you* choose when.
- A **repository** is a folder that git is watching.

Leave *fork* until Block 3 and *branch* out entirely. You will be tempted to explain
branching. Don't. It is the single most common way an introductory git talk loses
the room, and nothing in this session needs it.

Finally, defuse the terminal, because for a chunk of your audience the black window
is the actual barrier: everything you type is being pasted from a sheet, nobody
memorises these, and there's a graphical version of all of it. That's disarming, and
it's true.

---

## 0:05 — Block 1: a folder becomes a repository (15 min)

`git init`, then `git status`. Stress that nothing has left the laptop yet — this is
the payoff for the git-versus-GitHub framing you just did.

**Then slow right down on `.gitignore`.** This is the emotional centre of the session
for a genomics audience and it's the part everyone skips. Don't just show the file —
run the proof: create `results/figure1.png` and a `.env` holding a fake AWS key, then
`git status`, and let them see that neither appears. Then say the thing they need to
hear: a pushed credential is compromised forever, because deleting the commit doesn't
remove it from clones and forks that already exist.

`git add`, `git commit`, then `gh repo create --source=. --push` — one command makes
the remote repository and pushes to it. Open it in the browser and point out that
GitHub has already read `CITATION.cff` and added a "Cite this repository" button
without being asked. That lands well; it feels like the platform is on their side.

**The moment that actually converts people:** edit the README, run `git diff`, and
then stop talking. Red and green, no narration, a good five seconds of silence. Let
them read it. Then commit, push, `git log --oneline`, and the history is visibly
accumulating in front of them.

> **CUT if behind:** the `git restore --source=HEAD~1` undo demo at step 1.10. It's a
> lovely idea, but `HEAD~1` needs explaining and beginners glaze. Instead just say
> "and you can go back to any of these" while pointing at the log.

Questions that always come up, worth pre-empting: *Is it private?* (Yes if you want —
but Zenodo needs public.) *What about big data?* (It doesn't go in git. The repo holds
code and small tables; the data lives on Gadi or in a data repository.) *Do I need the
command line?* (No — GitHub Desktop does most of this. The commands are just what's
reproducible and what fits on a slide.)

---

## 0:20 — Block 2: a DOI from Zenodo (12 min)

Your easiest block, because a DOI is the one concept here your audience already
understands completely — they cite things every day. Lead with that: a URL tells you
where something lives today, a DOI tells you what it *was* on the day you used it.

**Say the ordering trap out loud before you do it, and again while you're doing it:**
link Zenodo to the repo *first*, release *second*. Zenodo only sees releases created
after the switch is flipped, and there's no way to backfill. Nearly everyone who gets
this wrong gets it wrong in this exact way.

Log in to Zenodo with GitHub, Sync now, toggle the repo on. Only public repos appear
in that list. Then verify the webhook exists from the terminal before you promise
anything — if `gh api repos/.../hooks` prints nothing, the toggle didn't take. Sync
and re-toggle.

`gh release create v1.0.0`. Refresh Zenodo, and the DOI is there.

**The bit people don't expect:** click into the record and show them that Zenodo has
archived a complete zip of the repository at that exact commit. That's the moment a
DOI stops being bureaucracy and becomes insurance. Don't skip it.

Then the two DOIs, two sentences: the **version DOI** points at this release and never
changes; the **concept DOI** always resolves to the newest version. Version DOI in a
paper, concept DOI on your CV.

Finish by adding the badge to the README so the DOI is the first thing anyone sees.

---

## 0:32 — Block 3: a website, by forking (15 min)

Start the fork running first, then talk over it.

Now introduce **fork**, which you deliberately saved until here: a fork is your own
copy of somebody else's repository. It keeps a link back to the original, so you can
pull in their improvements later. A *template* gives you a clean copy with no
connection to the source. academicpages officially recommends the template button
these days — you're forking because the relationship to upstream is easier to *show*,
and because forking is the operation they'll actually use the first time they touch
someone else's code.

Three things to say as you hit them. Each is the difference between a working site and
a broken one:

**The repo name is load-bearing.** Naming it `evogen-demo.github.io` is what buys the
clean root URL. Any other name makes it a *project* site at `org.github.io/name/`, and
then you must set `baseurl` in `_config.yml` or every stylesheet 404s and you get an
unstyled wall of text. This is the most common academicpages complaint anywhere.

**Delete `.github/workflows/` from your fork.** You inherit upstream's own CI — PR
linting and a scheduled scraper — which in your copy is noise that emails you about
failures forever.

**Pages source is "deploy from a branch → main → /", not "GitHub Actions",** because
academicpages is built by Pages' own Jekyll builder. Getting this wrong is the usual
reason a forked academicpages site comes up blank.

Show the six variables at the top of `configure-site.sh` before you run it. Worth a
sentence on why it's a script rather than live editing: `_config.yml` has three
different keys called `name` at three indent levels, so a naive find-and-replace edits
the wrong one. The script matches the template's placeholder values instead.

Push, enable Pages, and you now have one to three minutes of build time. **That's your
questions slot — don't fill it with talking.** Then reveal the site.

> **CUT if behind:** the `gh api .../deployments` call at step 3.10. With this
> audience, "that build you just watched was a computer running your work
> automatically — you've been using continuous integration for three minutes" is
> better as one spoken sentence than as another API call on screen.

---

## 0:47 — Wrap (3 min)

Give them one action, not five: **put one existing project into a repo this week,
even a private one, and write the `.gitignore` first.**

Then make the offer that actually converts — twenty minutes with you, one to one, to
get their first repo up. That does more than the talk does.

Point them at the materials repository.

---

## When it goes wrong

**`git commit` fails asking who you are** — Block 0 wasn't run. `git config --global
user.email "..."`.

**`gh repo create` says the name exists** — append `-2` and carry on, or
`gh repo delete OWNER/NAME --yes` if it's a leftover rehearsal.

**Zenodo doesn't list the repository** — it's private (must be public), or Zenodo
hasn't synced. Hit "Sync now". A brand-new repo sometimes takes a minute to appear.

**You released before enabling Zenodo** — no DOI, and it can't be backfilled. Enable
the toggle, then cut `v1.0.1`. Say out loud that this is exactly the trap you just
warned about; owning it live is a better lesson than the clean version would have
been.

**No DOI a few minutes after the release** — check `gh api repos/OWNER/REPO/hooks`.
No zenodo.org URL means the webhook was never created. Re-toggle and re-release.

**The fork already exists** — you can't fork the same repo twice into one account.
`gh repo delete evogen-demo/evogen-demo.github.io --yes` and fork again.

**The site is an unstyled wall of text** — `url`/`baseurl` are wrong in `_config.yml`,
or Pages is serving the wrong branch. Check `gh api repos/ORG/REPO/pages`.

**The site 404s** — Pages needs a couple of minutes on first build. Check `.status`
from that same API call; you want `built`.

**`gh api ... /pages` returns 409** — Pages is already enabled. Fine, move on.

**Pushing a workflow file is rejected** — your token lacks the `workflow` scope.
`gh auth refresh -s workflow`. (Your current token already has it.)

**The network is dead** — fall back to the browser tabs from the pre-flight list and
talk through them. All of this is a means to an end; the ideas survive without a live
terminal.
