# EvoGen GitHub workshop — run sheet

Three things, live, from the terminal: get a project onto GitHub, give it a DOI
through Zenodo, and put a website in front of it by forking a template. Pitched at
an audience where some people have never used git at all.

`COMMANDS.sh` has every command in order, numbered to match the blocks below. Keep
it open in a second window and paste from it. Don't run it as a script.

Nothing here runs an analysis. No R, no Python, no packages to install. That's
deliberate — the moment a demo depends on somebody's environment, it breaks.

---

## The shape: watch, watch, then build

Blocks 1 and 2 you **demonstrate** — laptops shut, everyone watching one screen.
Block 3 they **build their own website**, hands on, and leave with it working.

Say this split out loud in your first minute, because it manages expectations in both
directions: nobody sits through the first half feeling they should be typing, and
nobody is caught out when the laptops open.

**Block 3 happens entirely in a web browser.** No terminal, no git installed, nothing
to download. That is the whole reason it's feasible — installing git and the GitHub
CLI for a room of beginners is a twenty-minute detour that fails differently on every
machine and teaches nothing. The browser path reaches the same finished website.

The two supporting documents:

- `PREREQUISITES.md` — the email to send a week out. It asks for one thing: a GitHub
  account with a **verified** email. Send it again the day before.
- `HANDOUT.md` — what attendees follow during Block 3. Print it or share the link.
  Don't make them work from your screen; beginners can't watch and type at once, and
  the room moves at different speeds.

---

## Timing

| Start | Block | Mode | Runs |
|---|---|---|---|
| 0:00 | Framing — git vs GitHub | demo | 5 min |
| 0:05 | Block 1 — a folder becomes a repository | demo | 13 min |
| 0:18 | Block 2 — a DOI from Zenodo | demo | 11 min |
| 0:29 | Block 3 — build your own website | **hands on** | 25 min |
| 0:54 | Wrap | — | 3 min |

Fifty-seven on paper. Blocks 1 and 2 are trimmed from the demo-only version to buy
Block 3 the time it needs — hands-on always runs long, and a room of beginners
finishes at wildly different speeds.

Three things are marked **CUT** below. Drop those first if you're behind, and don't
drop anything else. If you're badly behind, cut into the Zenodo block rather than
Block 3 — people forgive a rushed explanation, they don't forgive being abandoned
half-way through building something.

---

## The evening before

Twenty minutes, and it removes almost every way this can go wrong.

**Send the prerequisites email** a week out and again the day before — the text is in
`PREREQUISITES.md`. Chase anyone who hasn't confirmed they have a GitHub account with
a **verified** email; that's the one thing that will cost you time on the day.

**Check the template and preview are still up.** Nothing should have changed them,
but they're load-bearing now:
<https://github.com/mwallace99/evogen-website-template> and
<https://mwallace99.github.io/evogen-website-preview/>.

**Set your git identity.** `git config --global user.email` is unset on this
machine. Without it your first commit fails on stage. Block 0 fixes it.

**Rehearse against Zenodo Sandbox**, not the real thing —
<https://sandbox.zenodo.org>. Published Zenodo records cannot be deleted. Rehearsing
against production leaves permanent junk DOIs with your name on them.

**Do a full dry run.** For Block 3, fork the template into a spare GitHub account and
follow your own handout exactly as an attendee would — that's the only way to find
the step where the instructions are ambiguous. Delete the rehearsal repos afterwards.

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

## 0:29 — Block 3: build your own website (25 min, hands on)

**Laptops open.** Hand out `HANDOUT.md` — printed, or as a link in the chat. Don't
make them work from your screen; beginners can't watch and type at the same time, and
the room will spread out over several minutes' progress within about ninety seconds.

**Show them the finished thing first**, before anyone touches anything:
<https://mwallace99.github.io/evogen-website-preview/>. Thirty seconds. People work
much better towards something they've seen.

Then introduce **fork**, which you deliberately saved until now: your own copy of
somebody else's repository, which you can change freely without affecting theirs.
They're forking `mwallace99/evogen-website-template` — a stripped-down version of
academicpages with the developer tooling and most of the example content removed, so
there's less to be confused by. Say that it's someone else's work you've trimmed;
it's a good, quiet demonstration of the norm you're teaching.

**Do every step on the projector yourself, one step ahead of them**, and pause on each
checkpoint until hands are up. The handout has four:

1. Fork exists, named `YOURNAME.github.io`
2. `_config.yml` edited and committed
3. Pages switched on in Settings
4. Site loads

**Where people actually get stuck**, in rough order of frequency:

- *Typed their username wrong in the repo name.* Catch it at checkpoint 1 — it's a
  thirty-second fix then, and a confusing one later.
- *Broke the YAML* by deleting a quote or changing indentation. The repo shows a red
  X. Fix via the file's History → revert. Reassure loudly: nothing is broken
  permanently, this is exactly what version control is for. It's a nice callback to
  Block 1.
- *Unverified email.* Pages silently refuses to build and gives no message. If someone
  has done everything right and nothing appears, check this first.
- *Already had a `username.github.io`.* They named it something else; they now need
  `baseurl: "/thatname"` in `_config.yml`. Handle individually, it's ten seconds.

**The three-minute build wait is your friend, not dead air.** Use it deliberately:
answer questions, and mention the ORCID feature — put your ORCID iD in `_config.yml`
and the Publications page fills itself in from your ORCID record, updating whenever
you add a paper. Worth being straight that Google Scholar can't do this, because
someone always asks: no public API, and scraping breaks Google's terms. ORCID is the
way round it.

**Expect a spread.** Some will finish in eight minutes, some in twenty. Give the fast
ones something to do — replace the profile photo, edit the homepage text, add their
ORCID iD — and spend your time with the stragglers. Say early and clearly that nobody
needs to finish today and the site will still be there tomorrow.

> **CUT if behind:** the sidebar and homepage personalisation. Getting a live URL is
> the win; making it pretty can happen at home. Do not cut the build wait — you can't.

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

**Someone can't fork** — they already forked the template earlier, perhaps in a
rehearsal. You can't fork the same repository twice into one account. They delete the
old fork in its Settings, or use *Use this template* instead, which has no such limit.

**Someone's site is an unstyled wall of text** — the `url` line in their `_config.yml`
is wrong. It must be `"https://THEIRNAME.github.io"`, quoted, no trailing slash.

**The site 404s** — Pages needs a couple of minutes on first build. Check `.status`
from that same API call; you want `built`.

**`gh api ... /pages` returns 409** — Pages is already enabled. Fine, move on.

**Pushing a workflow file is rejected** — your token lacks the `workflow` scope.
`gh auth refresh -s workflow`. (Your current token already has it.)

**The network is dead** — fall back to the browser tabs from the pre-flight list and
talk through them. All of this is a means to an end; the ideas survive without a live
terminal.
