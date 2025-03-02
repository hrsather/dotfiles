#!/bin/bash

REPO_PATHS=("$HOME/dotfiles" "$HOME/Repos/callmates/site" "$HOME/Repos/callmates/backend" "$HOME/Repos/learning/learnml")


for REPO in "${REPO_PATHS[@]}"; do
	SESSION_NAME=$(basename "$REPO")

	if [ ! -d "$REPO" ]; then
		echo "Skipping $SESSION_NAME (directory does not exist)"
		continue
	fi

	if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
		echo "Session $SESSION_NAME already exists, skipping..."
		continue
	fi

	tmux new-session -d -s "$SESSION_NAME" -c "$REPO"
	tmux rename-window -t "$SESSION_NAME:1" "Code"
	tmux send-keys -t "$SESSION_NAME:1.1" "n" C-m

	done

