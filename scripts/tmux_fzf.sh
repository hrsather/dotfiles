#!/bin/bash

export PATH="/opt/homebrew/bin:$PATH"

session_name=$(/opt/homebrew/bin/fd --type d --max-depth 1 . "${HOME}/Repos" | sed 's|/*$||' | sed 's|.*/||' | /opt/homebrew/bin/fzf --border --reverse --no-preview)

if [[ -z "$session_name" ]]; then
    exit 0
fi

selected="${HOME}/Repos/${session_name}"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$selected"
    tmux send-keys -t "$session_name":1 "nt" C-m
fi

tmux switch-client -t "$session_name"
