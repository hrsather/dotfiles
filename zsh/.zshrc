# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

printf '\n%.0s' {1..100}
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

set -o emacs

clear-screen-bottom() {
  printf '\n%.0s' {1..$LINES}
  zle reset-prompt
}
zle -N clear-screen-bottom
bindkey '^L' clear-screen-bottom
bindkey '\e[1~' beginning-of-line

setopt interactive_comments

export EDITOR="nvim"
export VISUAL="nvim"

alias t="btop"
alias n="nvim"
alias lg="lazygit"
alias ls="lsd"
alias la="ls -a"
alias lt="ls --tree"
alias rm="trash-put"
alias ds="find . -name '.DS_Store' -type f -delete"
alias gp="git pull"
alias gP="git push"
alias gs="git status"
alias y="yazi"
alias c="clear"
alias cat="bat"
alias ca="conda activate"
alias cc="bash ~/dotfiles/scripts/conda_fzf.sh"
alias tma="tmux attach"
alias nt="tmux rename-window -t 1 Code && tmux new-window -n Shell && tmux new-window -n Claude && tmux send-keys -t Claude 'claude --dangerously-skip-permissions' Enter && tmux select-window -t Code && n"
alias k="kubectl"

export BAT_THEME="Nord"
export OPENSPEC_TELEMETRY=0

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_R_OPTS="--reverse"
export FZF_DEFAULT_OPTS="
  --color=bg:-1,bg+:-1,hl:#88C0D0
  --color=fg:#ECEFF4,fg+:#E5E9F0,hl+:#8FBCBB
  --color=info:#81A1C1,prompt:#81A1C1,pointer:#88C0D0
  --color=marker:#81A1C1,spinner:#88C0D0,header:#81A1C1
  --color=selected-bg:#4C566A,selected-fg:#ECEFF4
  --color=current-bg:#3B4252,current-fg:#ECEFF4
  --highlight-line
"


# Remove dups
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoredups
setopt HIST_IGNORE_DUPS   # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS  # Remove ALL previous duplicates when saving
setopt HIST_SAVE_NO_DUPS  # Do not save duplicate commands to history
setopt HIST_EXPIRE_DUPS_FIRST  # Remove older duplicates first
setopt HIST_FIND_NO_DUPS  # Do not show duplicate results in history search

# zsh plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# trash-cli
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"

# Agent skills — AI_SKILLS_DIRS is a comma-separated list of skill source dirs
mkdir -p ~/.agents/skills
for _skill in "$HOME/Repos/dotfiles/personal-skills"/*(/N); do
  ln -sfn "$_skill" ~/.agents/skills/"$(basename "$_skill")"
done
_skill_sources="${AI_SKILLS_DIRS:-$AI_SKILLS_DIR}"
if [[ -n "$_skill_sources" ]]; then
  IFS=',' read -rA _skill_dirs <<< "$_skill_sources"
  for _dir in "${_skill_dirs[@]}"; do
    _dir="${${_dir## }%% }"
    if [[ -d "$_dir" ]]; then
      for _skill in "$_dir"/*(/N); do
        ln -sfn "$_skill" ~/.agents/skills/"$(basename "$_skill")"
      done
    else
      echo "[skills] warning: directory not found: $_dir" >&2
    fi
  done
  unset _skill_sources _skill_dirs _dir _skill
fi

# powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

vpn() {
  osascript -e 'tell application "Viscosity" to connect "dv1-vpn-client"'
  osascript -e 'tell application "Viscosity" to connect "ag1-vpn-client"'
  osascript -e 'tell application "Viscosity" to connect "us5-vpn-client"'
  (while true; do curl -sf https://argocd.ai.wa.main.us5.axon.io > /dev/null; sleep 30; done) &
  (while true; do curl -sf https://argocd.ai.va.main.ag1.axon.us > /dev/null; sleep 30; done) &
  (while true; do curl -sf https://git.taservs.net/ > /dev/null; sleep 30; done) &
}

vpn-stop() {
  osascript -e 'tell application "Viscosity" to disconnectAll'
  kill $(jobs -p) 2>/dev/null
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


