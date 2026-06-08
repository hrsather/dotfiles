# Dotfiles Repo

This is a macOS dotfiles repo managed with GNU Stow. Each top-level directory (e.g. `zsh/`, `nvim/`, `git/`) is a stow package — its contents mirror the home directory structure and get symlinked into `~` via `stow <package>`.

## Critical: NEVER write to ~

Config files in `~` are **symlinks** pointing back to this repo. NEVER create, edit, or mkdir anything under `~/` directly. All changes go in this repo at `~/Repos/dotfiles/`. The symlinks handle the rest. This includes `~/.claude/` — edit `claude/.claude/` in this repo instead.

## Structure

Not every top-level directory is a stow package. Only directories listed in the `packages` array in `scripts/update.sh` are stowed. Check that file for the current list. Everything else (e.g. `assets`, `scripts`, `firefox`) is not symlinked via stow.
