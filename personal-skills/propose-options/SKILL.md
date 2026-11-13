---
name: propose-options
description: Generate three different designs for a specified change, have a fresh judge pick the best, and record the decision in the spec before building. Run this after `grill-me` when the spec leaves a real design choice open (more than one plausible approach, or the right layer or tool is unclear). Skip it when there is one obvious approach.
metadata:
  author: hsather
  version: "1.0"
---

Pick the approach on paper before writing code. Designs only, no implementation, until the user confirms.

## Steps

1. **Spec.** Read `SPEC-<worktree>.md` (`<worktree>` is `basename "$(git rev-parse --show-toplevel)"`). No spec: run `grill-me` first.
2. **Propose (3 Sonnet agents, in parallel).** Launch three Agents in one message, each with `model: "sonnet"`, `subagent_type: "general-purpose"`. Give each the repo path, the spec path, and one angle:
   - **A, minimal:** the smallest change that meets every "done when" item.
   - **B, robust:** the version that best handles the spec's risks and future change, still within scope.
   - **C, different:** a deliberately different approach from the obvious one, e.g. another layer, an existing tool or config instead of new code, or removing something instead of adding.

   Prompt:

   > Read the spec at `<spec path>` and the code it touches in `<repo>`. Propose one design using this angle: <angle>. Don't edit files. Reply in under 300 words with: Approach (what and why), Files touched, Risks and how it rolls back, Verification (how to prove it meets each "done when" item), Cost (rough size of the change). If this angle can't meet the spec, say so instead of stretching it.

3. **Judge (1 Opus agent).** Launch one Agent with `model: "opus"`, `subagent_type: "general-purpose"`. Give it the spec path and the three proposals labeled A, B, C, without their angle names or your opinion. Prompt:

   > Read the spec at `<spec path>` and check the proposals against the code in `<repo>`. Score each on: meets every "done when" item, risk (especially anything destructive or hard to roll back), simplicity, and verification. Proposals that don't meet the spec are out regardless of other scores. Pick a winner, or combine parts if that is clearly better, and say why in under 150 words. Name the runner-up and the one thing it does better.

4. **Decide.** Go with the judge's pick, unless it needs something outside the spec's Authority section (destructive, security, access, cost or scope beyond the spec). In that case pick the best option that stays within authority, and add the other to `## Open questions`. If the user is still in the conversation right after `grill-me`, show the pick in a few lines; don't wait for an answer.
5. **Record.** Append to the spec:

   ```
   ## Design
   <chosen approach, files touched, verification>

   Rejected: <one line each for the others and why>
   ```

6. **Build** the chosen design. `pre-push-review` will review against the updated spec.

## Rules

- Proposers never edit files. Only the main agent implements.
- If all three proposals converge on the same approach, say so, record it, and build. Don't invent a fourth.
- If the judge says none meets the spec, the spec is likely wrong: go back to `grill-me` instead of picking the least bad.
