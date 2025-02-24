#!/bin/bash

REPOS=("test" "test2")

BASE_DIR="$HOME/Repos"

# Loop through each repository
for REPO in "${REPOS[@]}"; do
	SESSION_NAME="$REPO"
	REPO_PATH="$BASE_DIR/$REPO"

	# Check if repo directory exists
	if [ ! -d "$REPO_PATH" ]; then
		echo "Skipping $SESSION_NAME (directory does not exist)"
		continue
	fi

	# Check if session already exists
	if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
		echo "Session $SESSION_NAME already exists, skipping..."
		continue
	fi

	tmux new-session -d -s "$SESSION_NAME" -c "$REPO_PATH"
	tmux rename-window -t "$SESSION_NAME:1" "Code"
	tmux send-keys -t "$SESSION_NAME:1.1" "n" C-m

	done

