# Preferences

- Minimal and explicit — no unnecessary abstractions, comments, or bloat
- Prefer simple, direct solutions over clever or over-engineered ones
- Never commit secrets, tokens, or credentials

## Git
- Commit messages must be prefixed with `fix:` or `feat:`
- Branch names must be prefixed with `feature/` or `fix/`
- Use `git commit -m "message"` — never use heredocs or command substitution in commit commands

## Shell
- Create bash scripts that will work on MacOS's bash
- Prefer rg over grep and fd over find for repository searches.
- Never use compound shell commands. Execute only one command per Bash call. Do not use &&, ;, or | to chain commands.

## Tips
- To wait on a GitHub Actions run, run `gh run watch <id> --exit-status` in the background and act on its completion — don't poll `gh run list`/`gh run view` with sleep or ScheduleWakeup.
- Because compound shell commands are disallowed, send independent Bash/Read calls (status checks, log fetches, file reads) as multiple tool calls in the same response instead of one per turn.
