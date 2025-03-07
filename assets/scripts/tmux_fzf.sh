#!/bin/bash

# Get list of existing tmux sessions
sessions=$(tmux list-sessions -F "#S" 2>/dev/null)

# Use fzf to select or enter a new session name
fzf_output=$(echo "$sessions" | fzf --print-query --border --reverse --no-preview)

query=$(echo "$fzf_output" | sed -n '1p')
match=$(echo "$fzf_output" | sed -n '2p')

# If match exists, use it; otherwise, use the query as the session name
if [[ -n "$match" ]]; then
    selected_session="$match"
else
    selected_session="$query"
fi
echo $selected_session

# If no session selected, exit
if [[ -z "$selected_session" ]]; then
    exit 0
fi

# Check if session exists
if ! echo "$sessions" | grep -qx "$selected_session"; then
    tmux new-session -d -s "$selected_session"
fi

# Attach to the session
tmux switch-client -t "$selected_session"
