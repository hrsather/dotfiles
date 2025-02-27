#!/bin/bash

brew update
brew upgrade
brew upgrade --cask --greedy
brew bundle --file ~/dotfiles/assets/Brewfile --force --cleanup
brew cu --all --force
brew autoremove
brew cleanup
