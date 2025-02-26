#!/bin/bash

brew update
brew upgrade
brew upgrade --cask
brew bundle --file ~/dotfiles/assets/Brewfile --force
brew autoremove
brew cleanup
