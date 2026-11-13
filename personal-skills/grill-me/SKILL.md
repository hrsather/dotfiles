---
name: grill-me
description: Interview the user thoroughly until the task is fully specified, including what Claude may decide alone, then write SPEC-<worktree>.md. Run this before starting any non-trivial change (new feature, behavior change, infra change, anything touching more than a couple of files). Skip it for typos, one-line fixes, and tasks the user already specified in detail.
metadata:
  author: hsather
  version: "1.0"
---

Get to a spec good enough that a fresh agent could build, review and ship the change from it alone. This is the user's main time investment: after it is approved, Claude works on its own until the PR is green and doesn't come back with questions it could have asked now. Be thorough.

## Steps

1. **Read first.** Look at the code and docs the task touches, so you only ask what the code can't answer.
2. **Grill.** Ask one question at a time with AskUserQuestion, each with a recommended answer first. Keep going until every item below is settled:
   - **Goal:** what problem this solves and for whom.
   - **Done when:** concrete, checkable acceptance criteria.
   - **Scope:** what is in, and what is explicitly out.
   - **Constraints:** repos, environments, compatibility, cost, security, approvals.
   - **Risks:** what could break or be destroyed, and how it rolls back.
   - **Verification:** the commands or checks that prove it works.
   - **Authority:** what Claude may decide alone and what needs the user. Default: decide anything reversible within scope; ask about destructive changes, security, access, cost and scope.
   - **People:** who reviews or approves, and who else might need to be asked for something.

   Push back on vague answers ("make it better", "handle errors") until they're specific. Look ahead: imagine building, reviewing and deploying it, and ask now about anything that would otherwise stop the work later. Stop asking once the answers stop changing the plan.
3. **Write the spec** to `SPEC-<worktree>.md` at the worktree root, where `<worktree>` is `basename "$(git rev-parse --show-toplevel)"`. It is gitignored. Use the eight headings above plus empty `## Decisions` and `## Open questions` sections, terse bullets, no filler.
4. **Confirm.** Show the user the spec and ask for a yes before writing code. Edit it until they agree.
5. **Design choice?** If more than one approach is plausible, run `propose-options` next. Otherwise build.

The spec is what `pre-push-review` hands its reviewer, and what `handoff` points back to.
