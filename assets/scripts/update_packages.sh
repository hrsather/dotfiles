#!/bin/bash

brew bundle --file ~/dotfiles/assets/Brewfile --force
brew update
brew upgrade
brew upgrade --cask
brew autoremove
brew cleanup
