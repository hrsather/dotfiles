#!/bin/bash

# Audo hide dock
defaults write com.apple.dock "autohide" -bool true
# Audo hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# System-wide dark mode
defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark"

# Key repeats
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Mouse doesn't get larger
defaults write ~/Library/Preferences/.GlobalPreferences CGDisableCursorLocationMagnification -bool true

# Don't add a period on a double space
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Save screenshots to downloads
defaults write com.apple.screencapture location ~/Downloads
