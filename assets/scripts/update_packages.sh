#!/bin/bash

brew bundle --file ~/dotfiles/assets/Brewfile

brew update
brew upgrade
brew upgrade --cask
brew cleanup
