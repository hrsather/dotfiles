#!/bin/bash
# PreToolUse hook: run the repo's quick checks before Claude runs `git push`.
# Exit 2 blocks the push and shows the failure to Claude.

set -uo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // ""')
dir=$(echo "$input" | jq -r '.cwd // "."')

echo "$cmd" | grep -Eq '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push([[:space:]]|$)' || exit 0
c_dir=$(echo "$cmd" | sed -nE 's/.*git[[:space:]]+-C[[:space:]]+([^[:space:]]+)[[:space:]]+push.*/\1/p')
[ -n "$c_dir" ] && dir=$c_dir
cd "$dir" 2>/dev/null || exit 0
root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0

base=$(git rev-parse '@{upstream}' 2>/dev/null)
if [ -z "$base" ]; then
    for ref in origin/HEAD origin/main origin/master; do
        base=$(git merge-base "$ref" HEAD 2>/dev/null) && break
    done
fi
[ -n "$base" ] || exit 0
[ -n "$(git diff --name-only "$base" HEAD)" ] || exit 0

log=$(mktemp)
fail() { echo "pre-push checks failed: $1" >&2; tail -n 60 "$log" >&2; rm -f "$log"; exit 2; }

if [ -f .pre-commit-config.yaml ] && command -v pre-commit >/dev/null; then
    pre-commit run --from-ref "$base" --to-ref HEAD >"$log" 2>&1 || fail "pre-commit"
fi

if [ -f package.json ]; then
    pm=npm
    [ -f pnpm-lock.yaml ] && pm=pnpm
    for s in format:check lint typecheck test; do
        if jq -e --arg s "$s" '.scripts[$s]' package.json >/dev/null; then
            "$pm" run "$s" >"$log" 2>&1 || fail "$pm run $s"
        fi
    done
fi

rm -f "$log"
exit 0
