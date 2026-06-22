#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ask for sudo upfront
sudo -v

# Update other software
sudo softwareupdate -i -a

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install FZF shell integrations (bindings + completions) if missing
if ! command -v fzf &>/dev/null; then
    yes | "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
fi

# Update brew packages
brew update
brew upgrade
brew upgrade --cask --greedy
brew trust hashicorp/tap
brew trust ankitpokhrel/jira-cli
brew trust buo/cask-upgrade
brew trust nikitabobko/tap
brew trust dimentium/autoraise
brew bundle --file "$DOTFILES_DIR/assets/Brewfile" --force
brew cu --all --force --yes
brew autoremove
brew cleanup

# Install neovim in root
/usr/bin/python3 -m pip install --upgrade pip
/usr/bin/python3 -m pip install neovim

# Create dir for conda envs so they don't get overwritten on update
conda config --add envs_dirs "$HOME/.conda/envs"

# Update nvim packages
nvim --headless "+lua vim.pack.update()" +qa

# Stow all packages
packages=("zsh" "tmux" "btop" "nvim" "ghostty" "aerospace" "karabiner" "hushlogin" "git" "ruff" "lazygit" "claude")
for package in "${packages[@]}"; do
    stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$package"
done

# Fix lazygit install location (Library path has spaces, can't use stow)
mkdir -p "${HOME}/Library/Application Support/lazygit/"
rm -f "${HOME}/Library/Application Support/lazygit/config.yml"
ln -s "$DOTFILES_DIR/lazygit/.config/lazygit/config.yml" "${HOME}/Library/Application Support/lazygit/config.yml"

# Update npm and global packages
npm install -g npm@latest
npm update -g

# Install/Update OpenSpec
npm install -g --allow-scripts=@fission-ai/openspec @fission-ai/openspec@latest

# Source tmux
tmux source-file ~/.config/tmux/tmux.conf

# Update submodules
git -C "$DOTFILES_DIR" submodule update --init --recursive
git -C "$DOTFILES_DIR" submodule update --remote --recursive

# Update Firefox
PROFILES_PATH="${HOME}/Library/Application Support/Firefox/Profiles/"
PROFILE=$(ls -t "$PROFILES_PATH" | grep '\.default-release' | head -1)
PROFILE_PATH="${PROFILES_PATH}${PROFILE}"
mkdir -p "${PROFILE_PATH}/chrome"
FIREFOX_DIR="$DOTFILES_DIR/firefox"
rm -f "$PROFILE_PATH/user.js"
cp "$FIREFOX_DIR/user.js" "$PROFILE_PATH/user.js"
ln -sf "$(realpath "$FIREFOX_DIR/userChrome.css")" "$PROFILE_PATH/chrome/userChrome.css"
cp "$FIREFOX_DIR/userContent.css" "$PROFILE_PATH/chrome/userContent.css"
cp "$DOTFILES_DIR/assets/background.png" "$PROFILE_PATH/chrome/background.png"

# Mac settings
# Auto-hide scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Audo hide dock
defaults write com.apple.dock "autohide" -bool true
# Audo hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# System-wide dark mode
defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark"
# Key repeats
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 12
# Mouse doesn't get larger
defaults write ~/Library/Preferences/.GlobalPreferences CGDisableCursorLocationMagnification -bool true
# Don't add a period on a double space
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Save screenshots to downloads
defaults write com.apple.screencapture location ~/Downloads
# Open home dir in finder by default
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Disable recent apps in dock
defaults write com.apple.dock show-recents -bool false
# Disable standard click to show desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
# Set wallpaper
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$DOTFILES_DIR/assets/background.png\""
# Disable pop up for special chars when typing
defaults write -g ApplePressAndHoldEnabled -bool false
# Set color theme to graphite
defaults write -g AppleAccentColor -int -1
# Set icons to clear
defaults write -g AppleIconStyle -string Tinted
# Set Text highlight color to nord
defaults write -g AppleHighlightColor -string "0.533 0.753 0.816"
defaults write -g AppleAccentColor -int -2
defaults write -g AppleAccentColorRGB -string "0.532999 0.753083 0.815873"
