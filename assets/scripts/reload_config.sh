#!/bin/bash

DOTFILES_DIR="${HOME}/dotfiles"

packages=("zsh" "tmux" "starship" "btop" "nvim" "ghostty" "aerospace" "karabiner")

for package in "${packages[@]}"; do
  stow --dir="$DOTFILES_DIR" "$package"
done
