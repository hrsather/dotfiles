#!/bin/bash

export PATH="/opt/homebrew/bin:$PATH"

fzf_output=$(/opt/homebrew/bin/fd --type d --max-depth 1 . "${HOME}/Repos" | sed 's|/*$||' | sed 's|.*/||' | /opt/homebrew/bin/fzf --print-query --border --reverse --no-preview)

query=$(echo "$fzf_output" | sed -n '1p')
match=$(echo "$fzf_output" | sed -n '2p')

if [[ -n "$match" ]]; then
    session_name="$match"
    selected="${HOME}/Repos/${session_name}"
elif [[ -n "$query" ]]; then
    session_name="$query"
    selected="${HOME}/Repos"
else
    exit 0
fi

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$selected"
    if [[ -n "$match" ]]; then
        tmux send-keys -t "$session_name":1 "nt" C-m
    fi
fi

tmux switch-client -t "$session_name"
