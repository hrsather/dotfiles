#!/bin/bash

brew update
brew upgrade
brew upgrade --cask --greedy
brew bundle --file ~/dotfiles/assets/Brewfile --force --cleanup
brew cu --all --force
brew autoremove
brew cleanup

# Update nvim packages
nvim --headless "+Lazy! sync" +qa

# Update Treesitter langs
nvim --headless +TSUpdateSync +qa
