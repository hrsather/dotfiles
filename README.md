# My dotfiles
* Managed by GNU stow
* MacOS setup
* Terminal-Based Personal Development Environment
* Keyboard Centric
* Minimal

## Claude skills

Skills are Claude Code plugins, never symlinks. Every marketplace and plugin is declared in `claude/.claude/settings.json`, shared by all machines:

| Tier | Marketplace repo | Plugins |
|---|---|---|
| Public, generic | [hrsather/ai-skills](https://github.com/hrsather/ai-skills) | `sdlc` (ship workflow + hooks) |
| Private, personal and side businesses | hrsather/personal-skills | `life` |
| Work | the work skills repo | work plugins |

A machine that can't reach a marketplace (e.g. the personal machine and the work repo) skips it and starts normally, so one settings file serves every machine.

Add a marketplace or plugin by editing `settings.json` and committing it, or with the CLI (which writes to the same stowed file, so commit the result):

```
claude plugin marketplace add <owner>/<repo>
claude plugin install <plugin>@<marketplace>
```

A marketplace repo has `.claude-plugin/marketplace.json` and `plugins/<name>/` with `.claude-plugin/plugin.json`, `skills/<skill>/SKILL.md`, and optionally `hooks/hooks.json` (see ai-skills). Test local edits with `claude --plugin-dir <repo>/plugins/<name>`, then push and run `claude plugin marketplace update <marketplace>`.

Repo-specific skills live in that repo's `.claude/skills/` (e.g. homelab's cluster skills).
