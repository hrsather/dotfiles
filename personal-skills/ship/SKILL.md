---
name: ship
description: The end-to-end pipeline for a non-trivial task, from spec to verified in production. Run this at the start of any non-trivial change, and re-read it whenever unsure what comes next. It orders the other skills, says what Claude decides alone, and when it may reach out to people.
metadata:
  author: hsather
  version: "1.1"
---

One workstream per session, in its own worktree. The spec is where the user spends their time; after it is approved, work autonomously until the PR is green.

## Stages

1. **Worktree.** `EnterWorktree` on a new `feature/` or `fix/` branch. If `HANDOFF-<worktree>.md` or `SPEC-<worktree>.md` exists, read them and resume from where they say.
2. **Spec.** Run `grill-me`. This is the main human conversation, so be thorough here rather than asking later. Exit: the user said yes to `SPEC-<worktree>.md`.
3. **Design.** If the spec leaves a real design choice open, run `propose-options`. Exit: a design is recorded in the spec.
4. **Build and test.** Implement in small commits. For each "done when" item, write or extend an automated test where the repo has tests, and run it. Follow the Debugging rules when something fails. Exit: every Verification item in the spec has been run and passed, with output seen this session.
5. **Review.** Run `pre-push-review`, then push (the pre-push hook runs the repo's checks) and open the PR. Exit: PR open.
6. **Get to green.** Run `pr-review-loop`, plus any repo-specific green checks from CLAUDE.md. Exit: green, as defined below.
7. **Reach out.** Now, and not before: send the user one Slack DM with the decisions log and any open questions, then run the repo's human-gated skill if CLAUDE.md names one, or ask the user to review and merge. Exit: merged, deployed, and verified in the live environment where there is one.
8. **Log.** If `$SHIP_LOG` is set, append one JSON line to it (`echo '<json>' >> "$SHIP_LOG"`), filled from this session and the spec:
   ```
   {"date":"YYYY-MM-DD","repo":"owner/name","pr":"<url>","outcome":"shipped|abandoned|handed-off",
    "local_review_fixed":N,"remote_ai_fixed":N,"pr_rounds":N,"ci_fixes":N,
    "decisions_alone":N,"open_questions":N,"user_contacts":N,"other_contacts":N,
    "plan_not_ours":N,"deploy":"success|failure|none","verified":true|false,
    "notes":"<one line: what slowed it down or what a step caught that others missed>"}
   ```
   `remote_ai_fixed` counts valid findings the remote reviewer still raised after the local review: it is the measure of whether `pre-push-review` pays off.
9. **Clean up.** Delete `SPEC-` and `HANDOFF-` files, `ExitWorktree` with removal if the tree is clean, delete the merged local branch. Report what shipped.

## Green

- Every required check on the PR passes, and `pr-review-loop` has no AI items left.
- Any extra green criteria CLAUDE.md sets for the repo are met.

## Decide, don't ask

Between the approved spec and green, make decisions yourself. Ask only when a choice is outside what the spec authorizes (its Authority section), or is:
- destructive or hard to reverse (deleting resources or data, replacing stateful resources, rewriting history);
- a security, access or cost change beyond what the spec says;
- a scope change.

For everything else, pick the option that best fits the spec, prefer the reversible and simpler one, and log it in the spec under `## Decisions` as `- <decision>: <why> (<alternatives>)`. The user reviews the log at stage 7.

When stuck, unblock yourself before involving anyone: search the code, docs and Slack for the answer, read logs, try a different approach, check how similar changes were done before (`git log -S`, past PRs). Count it as stuck only after those fail.

## Reaching out

- **Not before green.** Don't message the user or anyone else until the PR is green. Questions that come up earlier go under `## Open questions` in the spec; keep working on your best answer and revisit if the answer changes things.
- **One exception:** if green is unreachable (blocked on access, someone else's outage, or a question outside your authority with no work left that doesn't depend on it), DM the user. Say what you tried and what you need, and never contact anyone else first.
- **Questions go to the user first, on Slack:** DM with `slack_send_message` to the user's own id, plus a push notification with the PushNotification tool. Contacting anyone else goes through `unblock`, which drafts the message for the user to send.
- **Replies:** you aren't notified of Slack replies. After sending, continue with other work. At each stage boundary, and before stopping, read the DM thread with `slack_read_thread`. If nothing is left to do, say in the terminal that you're waiting and that the user can reply either there or in the thread.

Before the user clears context or the session ends, run `handoff`.

## Report

At each stage boundary, one line: `ship: <stage> done, next <stage>` (or `blocked on <thing>`).
