---
name: pre-push-review
description: Critically review the whole unpushed branch locally before it goes to GitHub. Run this before every `git push` and `gh pr create`. A fresh Opus agent reviews the diff against what was asked, the main agent triages and fixes, then pushes. Skip for pushes made inside `pr-review-loop`.
metadata:
  author: hsather
  version: "1.0"
---

Catch problems locally so the slow remote AI review has less to find. One review round, then push.

## Steps

1. **Commit.** Commit any pending work first, following the user's git rules.
2. **Find the base.** Use the upstream if the branch has one: `git rev-parse @{upstream}`. Otherwise `git merge-base origin/main HEAD` (use the repo's default branch). Nothing between base and `HEAD`: push and stop.
3. **Review (Opus).** Launch one Agent with `model: "opus"`, `subagent_type: "general-purpose"`. Give it the repo path, the base sha, and the spec: `SPEC-<worktree>.md` if it exists, otherwise what the user asked for, in their words, plus any plan or ticket. Leave out your own opinion of the code. Prompt:

   > Critically review `git diff <base>...HEAD` in `<repo>`. The change is meant to: <spec>. Read surrounding code as needed. First check whether the change does what the spec asks, and nothing it doesn't. Then look for bugs, broken edge cases, security issues, violated repo conventions (see CLAUDE.md files), and needless complexity. Don't edit files or run git commands that change state. Report each finding as: severity (high/medium/low), `file:line`, the problem, and a concrete fix. If nothing is worth changing, say so. Don't pad the list with style nits.

4. **Triage.** For each finding, read the code and decide:
   - **Valid** (real bug, spec gap, violated rule, missing test for changed behavior): fix it minimally.
   - **Not relevant** (wrong about the code, pure style preference, conflicts with the user's preferences): skip it.
   - **Needs a decision** (design trade-off, scope change, security policy): don't guess. Ask the user before pushing.
5. **Check and commit.** Run the repo's quick checks (tests, lint, formatters) if it has them. Commit the fixes as one commit.
6. **Push.** `git push` (or `gh pr create` if that was the request). Then `pr-review-loop` takes over as usual.
7. **Report.** Print:

   ```
   Pre-push review: <n> finding(s)
   Fixed: <list> (<short-sha>)
   Skipped: <list with reasons>
   Pushed: <branch>
   ```

## Rules

- One review round. Don't re-review your own fixes.
- Don't refactor beyond what a finding asks.
- Never force push.
