#!/bin/bash

# Audo hide dock
defaults write com.apple.dock "autohide" -bool true
# Audo hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# System-wide dark mode
defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark"

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

osascript -e 'tell application "System Events" to set picture of desktop 1 to "/Users/hsather/dotfiles/assets/background.png"'

