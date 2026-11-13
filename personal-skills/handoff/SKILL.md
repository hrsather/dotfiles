---
name: handoff
description: Write HANDOFF-<worktree>.md so a fresh session can pick up the work. Run this when the user is about to /clear or end the session, says "handoff", or when context is getting long mid-task.
metadata:
  author: hsather
  version: "1.0"
---

Write `HANDOFF-<worktree>.md` at the worktree root, where `<worktree>` is `basename "$(git rev-parse --show-toplevel)"`. It is gitignored. Overwrite any old one. A session-start hook tells the next session it exists.

Write it for an agent with no memory of this session. Facts, not narrative:

```
# Handoff: <task>

Spec: SPEC-<worktree>.md (or "none")
Branch: <branch> · PR: <url or none> · Last commit: <short-sha>

## Done
- <what is finished and verified, with how it was verified>

## In progress
- <what is half-done, and exactly where it stands>

## Next
1. <the next concrete step>

## Gotchas
- <dead ends tried and why they failed, surprising behavior, decisions the user made>

## Waiting on
- <approvals, CI runs, background jobs, with links>
```

Then tell the user the file is written and that it's safe to `/clear`.
