export HOMEBREW_NO_AUTO_UPDATE=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use starship shell prompt
eval "$(starship init zsh)"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_ignore_dups

# Case insensitive completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ZSH plugins
source /opt/homebrew/opt/zplug/init.zsh
zplug "plugins/git",   from:oh-my-zsh

zplug "zsh-users/zsh-history-substring-search"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

set -o vi
alias vim='nvim'
export EDITOR='nvim'

alias ls='eza --oneline --color always --group-directories-first'
alias ll='eza --all --long --color always --group-directories-first'

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
source <(fzf --zsh)

# Source asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Source autojump (a.k.a. `j`)
[[ -s /opt/homebrew/etc/autojump.sh ]] && . /opt/homebrew/etc/autojump.sh

# Syntax highlighting with less
LESSPIPE=$(which src-hilite-lesspipe.sh)
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

# Aliases
alias pn=pnpm
alias tf=terraform

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/Library/pnpm:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.wasmtime/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.claude/local:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
