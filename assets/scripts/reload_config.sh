#!/bin/bash

DOTFILES_DIR="${HOME}/dotfiles"

packages=("zsh" "tmux" "btop" "nvim" "ghostty" "aerospace" "karabiner" "hushlogin" "git")

for package in "${packages[@]}"; do
  stow --dir="$DOTFILES_DIR" "$package"
done

# For Lazygit
mkdir -p "${HOME}/Library/Application Support/lazygit/"
rm -f "${HOME}/Library/Application Support/lazygit/config.yml"
ln -s "${HOME}/dotfiles/lazygit/.config/lazygit/config.yml" "${HOME}/Library/Application Support/lazygit/config.yml"
