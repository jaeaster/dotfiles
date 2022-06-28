export HOMEBREW_NO_AUTO_UPDATE=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use starship shell prompt
eval "$(starship init zsh)"

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

alias ls='exa --oneline --color always --group-directories-first'
alias ll='exa --all --long --color always --group-directories-first'

export PATH=/Users/$(whoami)/.local/bin:$PATH

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source asdf
. $(brew --prefix asdf)/libexec/asdf.sh
. $(brew --prefix asdf)/asdf.sh

# Source autojump (a.k.a. `j`)
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Syntax highlighting with less
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

export PATH="$PATH:/Users/jonathaneasterman/.foundry/bin"
export PATH="$PATH:/Users/jonathaneasterman/.gcloud/google-cloud-sdk/bin"
