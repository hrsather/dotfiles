# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

set -o emacs

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
alias y="yazi"
alias c="clear"

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

# micromamba

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

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
