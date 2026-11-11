---
name: pr-review-loop
description: Handle AI reviewer comments on a pull request. Run this automatically after every `gh pr create` and after every commit or push to a branch that has an open PR. Waits for the AI review, fixes valid comments, replies to and resolves irrelevant ones, and stops after 5 rounds. Leaves human comments alone.
metadata:
  author: hsather
  version: "1.0"
---

Address AI review comments on the current branch's PR, then stop. One loop per PR at a time.

Helper: `~/.claude/skills/pr-review-loop/pr-review.sh` (called `PR` below). Run one command per Bash call.

## Rules

- **One loop at a time.** `PR acquire` takes a per-PR lock. If it exits 3, another loop is running: stop silently. The commits this skill makes are part of the loop, so they never start a new one.
- **No agents, no extra shells.** Don't use the Agent or Workflow tools. Run `PR wait` as the only background command, and don't start another until it finishes.
- **Max 5 rounds.** `PR bump` counts them and exits 4 after the 5th. Then stop and treat the PR as good enough. This is how nitpick loops end.
- **Humans are the user's.** Never reply to, resolve or change code for a comment from a human. Report them at the end.
- **Don't re-trigger reviews.** Never post `/spoc`, add review labels, or otherwise ask the AI for another pass.
- Never force push. Follow the user's git rules (prefix `fix:`/`feat:`, `git commit -m`, no heredocs).

## Steps

1. **Find the PR.** `gh pr view --json url`. No PR: stop.
2. **Lock.** `PR acquire`. Exit 3: stop silently.
3. **Wait for the AI review.** Run `PR wait <head-sha>` with `run_in_background: true`, where the sha is `git rev-parse HEAD` of what you pushed (make sure it is pushed). It blocks until the AI review checks finish, up to 25 minutes, and prints findings as JSON. Don't poll it: act when it completes, then read its output file.
4. **Count the round.** `PR bump`. Exit 4: `PR release` and go to the report.
5. **Triage** the JSON (see below). Nothing in `ai_threads` or `ai_comments`: `PR release` and go to the report.
6. **Fix.** Make the changes for the valid items, run the repo's quick local checks (tests, lint, `terragrunt hcl fmt`, whatever the repo uses), commit, and push. Push before replying.
7. **Reply and resolve.**
   - Review thread, fixed: `PR reply <thread_id> "Fixed in <short-sha>: <what changed>"`, then `PR resolve <thread_id>`.
   - Review thread, not relevant: `PR reply <thread_id> "<one-sentence reason>"`, then `PR resolve <thread_id>`.
   - Thread you can't decide: reply with the question and leave it unresolved.
   - Comment that isn't a thread (`ai_comments`, ids start with `c` or `r`): reply only if it asked for something, using `PR comment "<text>"`. Summaries and "LGTM" need no reply.
   - Then `PR mark-handled <id>...` for every `ai_comments` id and every `human` id you reported, so they aren't reported again.
8. **Loop.** If you pushed a commit in step 6, go back to step 3 with the new head. If nothing was pushed, nothing new will be reviewed: `PR release` and go to the report.

## Triage

For each item, read the code it points at as it is on HEAD (`outdated: true` means the code moved, so check whether the concern still applies), then decide:

- **Valid** (a real bug, a violated repo rule or check, a missing test for changed behavior): fix it.
- **Already fixed**: reply "Addressed in <sha>" and resolve.
- **Not relevant**: wrong about the code, conflicts with an explicit requirement or the user's preferences (for example it asks for comments or abstractions the user avoids), or a pure style preference. Reply with a short, specific reason and resolve.
- **Needs a decision** (design trade-off, security or data-handling policy, scope change): don't guess. Leave it unresolved and report it.

Fix cheaply and minimally. Don't refactor beyond what the comment asks. If two comments conflict, report it instead of picking one.

## Report

Print a short summary, then stop:

```
PR review loop: <rounds> round(s)
Fixed: <n> (<commit shas>)
Declined and resolved: <n>
Left for you: <human comments and undecided items, with links>
Stopped because: no more AI comments | hit the 5 round cap | another loop was running
```

If the cap ended it, say so plainly and don't try to address anything further.

## Notes

- Items are classified by author. AI reviewers match `PR_REVIEW_AI_LOGINS` (default includes spockulus, copilot, claude, coderabbit). CI bots (snyk, infracost, jenkins, github-actions, ...) are ignored. Everyone else is human. Comments this skill posts end with a hidden marker, so it never mistakes its own replies for a human's.
- Lock and counters live in `${TMPDIR:-/tmp}/pr-review-loop/`. A lock with no activity for 2 hours is treated as stale and taken over.
- Reads the first 100 threads and comments per PR.
- Other env knobs: `PR_REVIEW_MAX_LOOPS`, `PR_REVIEW_WAIT_TIMEOUT`, `PR_REVIEW_CHECKS` (regex for which checks count as AI review), `PR_REVIEW_IGNORE_LOGINS`.
