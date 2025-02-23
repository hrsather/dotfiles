export EDITOR="nvim"
export VISUAL="nvim"
export HISTSIZE=10000
export SAVEHIST=10000

alias ls='lsd'
alias la='ls -a'
alias lt='ls --tree'
alias rm='trash-put'

alias n='nvim'

# fzf ctrl-r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"

eval "$(zoxide init --cmd cd bash)"
eval "$(starship init zsh)"
