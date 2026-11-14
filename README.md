# My dotfiles
* Managed by GNU stow
* MacOS setup
* Terminal-Based Personal Development Environment
* Keyboard Centric
* Minimal

## Claude skills

Skills install as Claude Code plugins, declared in `claude/.claude/settings.json`:

| Tier | Repo | Plugins |
|---|---|---|
| Public, generic | [hrsather/ai-skills](https://github.com/hrsather/ai-skills) | `sdlc` (ship workflow + hooks) |
| Private, personal and side businesses | hrsather/personal-skills | `life` |
| Work | `~/Repos/dotfiles-axon` (only on the work machine) | linked by `scripts/update.sh` |

Repo-specific skills live in that repo's `.claude/skills/` (e.g. homelab's cluster skills).
