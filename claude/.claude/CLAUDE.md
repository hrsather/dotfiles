# Preferences

- Minimal and explicit — no unnecessary abstractions, comments, or bloat
- Prefer simple, direct solutions over clever or over-engineered ones
- Never commit secrets, tokens, or credentials

## Shell
- Create bash scripts that will work on MacOS's bash
- Prefer rg over grep and fd over find for repository searches.
- Never use compound shell commands. Execute only one command per Bash call. Do not use &&, ;, or | to chain commands.

## Jira (project: AIPE)
- When starting work, check for active tickets that correlate: `jira issue list -s "In Progress" -s "To Do" -s "Backlog" -a hsather@axon.com --project AIPE`
- If current work relates to an existing ticket, ask the user if the ticket should be updated (status change, comment, etc.)
- If new work looks like it should be tracked, recommend creating a ticket and create it if the user agrees
- Always ask before making any Jira changes — never update or create tickets without user confirmation
- Every new ticket must have a parent (`-P`). List epics to find the right one and recommend it to the user before creating.
- Use `jira-cli` for all Jira operations (e.g. `jira issue create`, `jira issue move`, `jira issue comment add`)
