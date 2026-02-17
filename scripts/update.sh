#!/bin/bash

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
brew bundle --file ~/dotfiles/assets/Brewfile --force --cleanup
brew cu --all --force
brew autoremove
brew cleanup

# Install neovim in root
/usr/bin/python3 -m pip install --upgrade pip
/usr/bin/python3 -m pip install neovim

# Create dir for conda envs so they don't get overwritten on update
conda config --add envs_dirs $HOME/.conda/envs

# Update nvim packages
nvim --headless "+Lazy! sync" +qa

# Update Treesitter langs
nvim --headless +TSUpdateSync +qa

# Load configs
packages=("zsh" "tmux" "btop" "nvim" "ghostty" "aerospace" "karabiner" "hushlogin" "git" "ruff" "lazygit" "claude" "spotatui")
DOTFILES_DIR="${HOME}/dotfiles"
for package in "${packages[@]}"; do
    stow --dir="$DOTFILES_DIR" "$package"
done

# Link Spotatui app
mkdir -p "${HOME}/Applications"
ln -sf "${HOME}/dotfiles/apps/Spotatui.app" "${HOME}/Applications/Spotatui.app"

# Fix lazygit install location
mkdir -p "${HOME}/Library/Application Support/lazygit/"
rm -f "${HOME}/Library/Application Support/lazygit/config.yml"
ln -s "${HOME}/dotfiles/lazygit/.config/lazygit/config.yml" "${HOME}/Library/Application Support/lazygit/config.yml"

# Update other software
sudo softwareupdate -i -a

# Source tmux
tmux source-file ~/.tmux.conf

# Update submodules
git submodule update --init --recursive
git submodule update --remote --recursive

# Update Firefox
PROFILES_PATH="${HOME}/Library/Application Support/Firefox/Profiles/"
PROFILE=$(ls "$PROFILES_PATH" | grep '\.default-release')
PROFILE_PATH="${PROFILES_PATH}${PROFILE}"
mkdir -p "${PROFILE_PATH}/chrome"
BETTERFOX_DIR="${HOME}/dotfiles/firefox/Betterfox"
for file in "$BETTERFOX_DIR"/*; do
    filename=$(basename "$file")

    if [[ "$filename" == "user.js" ]]; then
        if [[ -e "$PROFILE_PATH/user.js" || -L "$PROFILE_PATH/user.js" ]]; then
            rm -f "$PROFILE_PATH/user.js"
        fi
        ln -s "$(realpath "$file")" "$PROFILE_PATH/user.js"
    else
        if [[ -e "$PROFILE_PATH/chrome/$filename" || -L "$PROFILE_PATH/chrome/$filename" ]]; then
            rm -f "$PROFILE_PATH/chrome/$filename"
        fi
        ln -sf "$(realpath "$file")" "$PROFILE_PATH/chrome/$filename"
    fi
done

# Mac settings
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
