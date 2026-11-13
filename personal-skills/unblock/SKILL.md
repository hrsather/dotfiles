---
name: unblock
description: Get unblocked by a person. Run this when work is stuck on something only a person can provide (access, a decision, missing information, a review, an outage on their side), or when a capped loop gives up. Finds the right person or channel, drafts the ask in Slack for the user to send, and moves on to other work.
metadata:
  author: hsather
  version: "1.0"
---

Try everything you can alone first. If it still needs a person, ask the user, and only then draft a message to someone else for the user to send. Claude never sends anything to anyone but the user.

## Steps

1. **Make sure it needs a person.** Write down the blocker in one sentence and what you already tried. Then try to unblock yourself:
   - search the repo's docs and README, `slack_search_public_and_private` for the error or topic, and existing skills;
   - look at how similar changes were done before (`git log -S`, past PRs);
   - try a different approach or a workaround that stays within the spec's Authority section;
   - if it's a decision you're allowed to make, make it and log it under `## Decisions`.

   If any of these works, continue and stop here.
2. **Check the gate.** Before the PR is green, the only person you may contact is the user, and only if green is unreachable without this. Otherwise add it to `## Open questions` in the spec, keep working, and come back once the PR is green.
3. **Ask the user first** if it's a question they can answer (scope, priority, a decision outside your authority): write the question in the terminal and send a push notification with the PushNotification tool. Don't DM them on Slack: the Slack tools post as the user, so they never get notified. Only go on to step 4 if it needs someone else.
4. **Find who can unblock it,** in this order:
   - the owner of the code or resource: `CODEOWNERS`, `git log` or `git blame` on the relevant files, the resource's tags;
   - a team channel whose topic covers it (`slack_search_channels`, then read its topic and description);
   - a person seen answering this kind of question in Slack search results.

   Prefer the team channel over a DM unless one owner is clear. Never pick someone at random.
5. **Write the ask** in the user's voice: short and casual, readable in five seconds.
   - What you need, as a specific question or action ("can you grant X role on Y", not "having issues with Y").
   - One line of context with a link (PR, error, doc).
   - What you already tried, if it saves them time.
   - When it matters, only if there is a real deadline.
6. **Confirm with the user.**
   - Create it as a draft in the target channel or DM with `slack_send_message_draft`. If it fails with `attached_draft_exists`, put the exact text in the terminal instead, in a code block.
   - Print in the terminal: the draft link, who it goes to and why them, the blocker in one line, and what you'll do meanwhile.
   - Send a push notification with the PushNotification tool: "Blocked on <thing>: draft ready in Slack".
7. **Keep going.** Record the blocker under "Waiting on" in `HANDOFF-<worktree>.md` (run `handoff` if there isn't one). Continue with any part of the spec that doesn't depend on the answer. If nothing is left, say so and stop.
8. **Resume.** The user answers in the terminal. If they point you to a Slack thread, read it with `slack_read_thread`. Check the answer actually removes the blocker, then continue.

## Rules

- Drafts only. Never post to anyone but the user, and never send follow-ups or reminders on your own.
- One ask per blocker. If you are blocked on several things, put them in one message to the same person rather than three.
- Don't guess past a blocker that needs a decision (scope, security, cost, someone else's system). Waiting is better than a confident wrong answer.
