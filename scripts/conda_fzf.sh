#!/bin/bash

# Load conda paths
CONDA_BASE=$(conda info --base)

# Get envs and select
envs=$(conda env list | awk '{print $1}' | tail -n +4)
fzf_output=$(echo "$envs" | fzf --print-query --border --reverse --no-preview --bind 'ctrl-d:execute(conda remove -n {+} --all -y > /dev/null 2>&1)')

query=$(echo "$fzf_output" | sed -n '1p')
match=$(echo "$fzf_output" | sed -n '2p')
selected_env="${match:-$query}"

[[ -z "$selected_env" ]] && echo "No env selected." && exit 0

# Create if needed
if ! echo "$envs" | grep -qx "$selected_env"; then
    echo "Creating environment: $selected_env"
    conda create -y -n "$selected_env" python=3.10
fi

# Send activation command to current tmux pane
tmux send-keys "conda activate $selected_env" C-m
