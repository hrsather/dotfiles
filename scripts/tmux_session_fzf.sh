#!/bin/bash

export PATH="/opt/homebrew/bin:$PATH"

session_name=$(tmux list-sessions -F '#S' | /opt/homebrew/bin/fzf --border --reverse --no-preview)

if [[ -z "$session_name" ]]; then
    exit 0
fi

tmux switch-client -t "$session_name"
