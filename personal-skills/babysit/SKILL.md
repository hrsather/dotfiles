---
name: babysit
description: Babysit an OpenSpec change end-to-end. Implement tasks, run verification, diagnose and fix failures, loop until green or max attempts reached.
metadata:
  author: hsather
  version: "2.0"
---

Babysit an OpenSpec change from implementation through verification. Apply tasks, run verification commands, fix failures, and repeat until everything passes.

**Input**: The argument after `/babysit` is an optional change name. If omitted, auto-select the active change or ask.

---

## Working Directories

There are two modes depending on where the work lives:

### `~/Repos` mode

Most repos live at `~/Repos/<repo-name>`. Read and make changes directly in the relevant repos there. If you need to clone additional repos for context (e.g., to understand an upstream dependency or a shared library), clone them into `~/Repos/`.

### `~/Projects` mode (multi-repo)

When working on a project that spans multiple repos, work happens in `~/Projects/<project-name>/`. All relevant repos are cloned as subdirectories of the project folder so they can be worked on in parallel (e.g., `~/Projects/myproject/repo-a/`, `~/Projects/myproject/repo-b/`).

### Note

The user will always init Claude and OpenSpec in the correct location before invoking this skill. Work from the current working directory — don't navigate elsewhere unless the change context points you to other repos that need fixes.

---

## Workflow

### 1. Select the change

- If a change name was provided, use it.
- Otherwise, run `openspec list --json` and auto-select if only one active change exists.
- If ambiguous, use the **AskUserQuestion tool** to let the user select.
- Print the change name so the user can follow along.

### 2. Load context

```bash
openspec status --change "<name>" --json
openspec instructions apply --change "<name>" --json
```

Read all `contextFiles` from the apply instructions output (proposal, specs, design, tasks — whatever the schema provides).

### 3. Check for verification section

Look for a `## Verification` section in the tasks file (typically `tasks.md`). This section must contain one or more shell commands that validate the implementation.

Expected format in tasks.md:

```markdown
## Verification
- `npm test`
- `npm run build`
- `npm run lint`
```

**If the section is missing or empty:**
- Stop and tell the user: "The tasks file is missing a `## Verification` section. I need to know how to verify this change works."
- Use the **AskUserQuestion tool** to ask: "What commands should I run to verify this change? (e.g., test, build, lint commands)"
- Add the `## Verification` section to the tasks file with the user's answer before proceeding.

### 4. Implement tasks

Follow the same logic as `opsx:apply`:

- For each pending task (`- [ ]`):
  - Show which task is being worked on
  - Make the code changes
  - Mark task complete: `- [ ]` → `- [x]`
- Continue until all tasks are done or a blocker is hit.

**Pause if:**
- Task is unclear → ask for clarification
- Implementation reveals a design issue → ask the user
- Error that isn't a verification failure → report and wait

### 5. Run verification

Execute each command from the `## Verification` section sequentially. Run them via Bash.

- **All pass**: Continue to step 7.
- **Any fail**: Continue to step 6.

### 6. Diagnose and fix

1. Read the verification output carefully. Identify the root cause — test failures, build errors, lint issues, type errors, runtime errors, etc.
2. Read the relevant source files and understand the context.
3. Make the minimal fix needed. Do not refactor, do not "improve" — just fix what's broken.
4. If the fix requires updating a task checkbox (e.g., the task was incomplete), update it.
5. Increment the fix attempt counter.
6. **If fix attempts >= 10**: Stop and report. Summarize what you've tried and what's still failing.
7. **Otherwise**: Go back to step 5.

### 7. Completion check

After verification passes:

- If all tasks are done (`- [ ]` count is 0): proceed to step 8.
- If tasks remain: go back to step 4 for the next batch.

### 8. Commit, push, and watch CI/CD

Once local verification passes:

1. **Commit and push**:
   - Stage only files you changed.
   - Commit with a descriptive message and `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>`.
   - Push to the PR branch. If no PR exists, create one with `gh pr create`.

2. **Watch GitHub Actions CI/CD**:
   ```bash
   gh pr checks <pr-number> --watch --fail-fast
   ```
   - **All passing**: Note any output artifacts (package name, image tag, build URL) from the CI logs for use in downstream steps. Continue to step 9.
   - **Any failed**: Fetch logs with `gh run view <run-id> --log-failed`, diagnose, fix, commit, push, and re-watch. This counts toward the 10 fix attempt limit.

3. **Extract CI artifacts**: If CI produces a package name, image tag, or other artifact reference, capture it from the build logs or check output. You may need this for AzureML job submission or other downstream verification.

### 9. Watch AzureML jobs (if applicable)

If the verification section or change context involves AzureML jobs:

1. **Submit or identify the job**:
   - If a job needs to be submitted, use the project's submission method (e.g., `az ml job create -f <job.yml>`).
   - If watching an existing job, get the job name from context or ask.

2. **Poll job status**:
   ```bash
   az ml job show --name <job-name> --query "{status:status, name:name}" -o tsv
   ```
   Poll every 60 seconds until terminal state (Completed, Failed, Canceled). **Use `job_status` as the variable name** (not `status` — zsh read-only).

3. **If the job fails**:
   - Get details: `az ml job show --name <job-name>`
   - Check for child jobs (pipeline jobs): `az ml job list --parent-job-name <job-name> --query "[].{name:name, status:status}" -o table`
   - Download logs: `az ml job download --name <job-name-or-child> --download-path /tmp/aml_logs`
   - Key log: `user_logs/std_log_process_0.txt`. Also check `logs/azureml/stderrlogs.txt`.
   - Diagnose, fix the source, commit, push, watch CI for a new image if needed, then resubmit the job. This counts toward the 10 fix attempt limit.

4. **If the job succeeds**: Continue to step 10.

### 10. Final report

```
## Babysit Complete

**Change:** <change-name>
**Tasks:** N/N complete
**Verification:** All passing
**CI/CD:** Green
**AzureML:** Completed (if applicable)
**Fix attempts:** M

Ready to verify with `/opsx:verify` or archive with `/opsx:archive`.
```

---

## Rules

- **Max 10 fix attempts.** Total across local verification, CI/CD, and AzureML cycles combined. After 10, stop and report.
- **Minimal fixes only.** Fix the failure, nothing else. No drive-by improvements.
- **Verification section is mandatory.** Never skip verification. If missing, always ask.
- **Run ALL verification commands every time.** Don't skip commands that passed before — a fix for one failure can break another.
- **Never force push.** Always regular push.
- **Don't guess at fixes.** If the failure is unclear (ambiguous logs, infrastructure issue, flaky test), stop and ask.
- **If the fix requires a design decision**, stop and ask the user.
- **If the failure is a data issue, infra issue, or quota problem**, stop and explain. Don't try to fix non-code problems.
- **Don't guess image tags.** Get the actual image reference from CI output or the container registry.
- **Print status updates** at each stage:
  - `Implementing tasks for change: <name>...`
  - `Tasks complete. Running verification...`
  - `Verification failed: <brief description>. Fixing (attempt 1/10)...`
  - `Fix applied. Re-running verification...`
  - `Local verification passing. Pushing and watching CI...`
  - `CI failed: <check-name>. Diagnosing (attempt N/10)...`
  - `CI green. Submitting AzureML job...`
  - `AzureML job failed. Diagnosing (attempt N/10)...`
  - `All passing. Change complete.` or `Giving up after 10 fix attempts.`
