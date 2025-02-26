#!/bin/bash

brew update
brew upgrade
brew upgrade --cask
brew bundle --file ~/dotfiles/assets/Brewfile --force --cleanup
brew autoremove
brew cleanup
