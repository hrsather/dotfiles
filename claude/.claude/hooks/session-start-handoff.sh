#!/bin/bash
# SessionStart hook: point a new session at the worktree's handoff and spec files.

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
name=$(basename "$root")

for f in "HANDOFF-$name.md" "SPEC-$name.md"; do
    [ -f "$root/$f" ] && echo "Found $root/$f from an earlier session. Read it before starting."
done
exit 0
