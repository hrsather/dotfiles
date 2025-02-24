set -o emacs

export EDITOR="nvim"
export VISUAL="nvim"
export HISTSIZE=10000
export SAVEHIST=10000

alias t="btop"
alias n="nvim"
alias lg="lazygit"
alias ls="lsd"
alias la="ls -a"
alias lt="ls --tree"
alias rm="trash-put"
alias ds="find . -name '.DS_Store' -type f -delete"

# fzf ctrl-r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTCONTROL=ignoredups
setopt HIST_IGNORE_DUPS   # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS  # Remove ALL previous duplicates when saving
setopt HIST_SAVE_NO_DUPS  # Do not save duplicate commands to history
setopt HIST_EXPIRE_DUPS_FIRST  # Remove older duplicates first
setopt HIST_FIND_NO_DUPS  # Do not show duplicate results in history search

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"

eval "$(zoxide init --cmd cd bash)"
eval "$(starship init zsh)"
