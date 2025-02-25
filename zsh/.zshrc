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

# fzf ctrl-r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_R_OPTS="--reverse"

# Remove dups
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoredups
setopt HIST_IGNORE_DUPS   # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS  # Remove ALL previous duplicates when saving
setopt HIST_SAVE_NO_DUPS  # Do not save duplicate commands to history
setopt HIST_EXPIRE_DUPS_FIRST  # Remove older duplicates first
setopt HIST_FIND_NO_DUPS  # Do not show duplicate results in history search

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"

eval "$(zoxide init --cmd cd zsh)"
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

conda config --set auto_activate_base false


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
