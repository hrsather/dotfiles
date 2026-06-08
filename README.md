# My dotfiles
* Managed by GNU stow
* MacOS setup
* Terminal-Based Personal Development Environment
* Keyboard Centric
* Minimal

## Claude skills

AI skills symlinked from an external repo (e.g. `ai-skills`) are gitignored via `claude/.claude/skills/*`. Local skills (checked into this repo) must be explicitly un-ignored in `.gitignore`:

```
!claude/.claude/skills/<skill-name>
!claude/.claude/skills/<skill-name>/**
```
