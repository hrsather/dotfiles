# Preferences

- Minimal and explicit — no unnecessary abstractions, comments, or bloat
- Prefer simple, direct solutions over clever or over-engineered ones
- Never commit secrets, tokens, or credentials

## Git
- Commit messages must be prefixed with `fix:` or `feat:`
- Branch names must be prefixed with `feature/` or `fix/`
- Use `git commit -m "message"` — never use heredocs or command substitution in commit commands
- Before every `git push` and `gh pr create`, run the `pre-push-review` skill. Skip it for pushes made inside `pr-review-loop`.
- Always make code changes in a git worktree on a new `feature/` or `fix/` branch (use `EnterWorktree`), never in the main checkout.

## Tasks
- For any non-trivial change, follow the `ship` skill. It orders the skills below and says when to stop.
- Invest in the spec up front. After I approve it, decide things yourself within its Authority section and log the decisions; unblock yourself before involving anyone.
- Don't contact me or anyone else until the PR is green (including any extra green criteria in the Work rules below), unless green is unreachable. Questions go to me first as a push notification, with the details in the terminal (never a Slack DM: those post as me and don't notify); anyone else only via the `unblock` skill's drafts, which I send.
- Before starting a non-trivial change, run the `grill-me` skill to write `SPEC-<worktree>.md`. If the spec leaves a real design choice open, run `propose-options` before building.
- Before I `/clear` or when context gets long mid-task, run the `handoff` skill.
- When a task is complete (PR merged, deploy verified if there is one), append its line to `$SHIP_LOG` (see the `ship` skill), then clean up: delete its `SPEC-` and `HANDOFF-` files, leave and remove the worktree with `ExitWorktree` if it has no uncommitted changes, and delete the merged local branch.

## Debugging
- Find the root cause before changing code: reproduce the problem, read the actual error and logs, then test one hypothesis at a time. No guess-and-patch.
- If two fixes for the same problem fail, stop and re-investigate from the evidence instead of stacking a third.

## Verification
- Never say something is done, fixed, or passing without running the command that proves it in this session and seeing the output. "Should work" is not done.
- If verification was skipped or failed, say so plainly.

## Pull requests
- After every `gh pr create`, and after every commit or push to a branch with an open PR, run the `pr-review-loop` skill. It holds a per-PR lock, so invoking it again while it is running is harmless.

## Shell
- Create bash scripts that will work on MacOS's bash
- Prefer rg over grep and fd over find for repository searches.
- Never use compound shell commands. Execute only one command per Bash call. Do not use &&, ;, or | to chain commands.

## Tips
- To wait on a GitHub Actions run, run `gh run watch <id> --exit-status` in the background and act on its completion — don't poll `gh run list`/`gh run view` with sleep or ScheduleWakeup.
- Because compound shell commands are disallowed, send independent Bash/Read calls (status checks, log fetches, file reads) as multiple tool calls in the same response instead of one per turn.

## Work
Work-specific rules live in a separate private repo, loaded only where it exists:
@~/Repos/dotfiles-axon/CLAUDE.md
