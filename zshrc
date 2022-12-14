# inspration: https://github.com/jonpas/dotfiles/blob/master/.zshrc
# and because oh-my-zsh is so awfully slow to initialize

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/dotfiles/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh

# get uname: [Linux, Darwin]
UNAME=$(uname)

# correct keymapping issues on Linux -- tested on silverblue. what a trip yo.
# no idea if this works elsewhere... user assumes all risk
if [[ "$UNAME" == "Linux" ]]; then
    typeset -g -A key

    key[Delete]='^[[3~'
    key[Home]='^[[H'
    key[End]='^[[F'

    bindkey "${key[Delete]}" delete-char
    bindkey "${key[Home]}" beginning-of-line
    bindkey "${key[End]}" end-of-line
fi

# zsh options
setopt autocd
setopt interactive_comments
setopt no_auto_remove_slash
setopt magicequalsubst

# unset zsh options
# unsetopt MULTIBYTE

# history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY

# tab complete
autoload -Uz compinit compaudit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# edit line in vim with Ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^w' edit-command-line

# load fast syntax highlighting plugin
source "$HOME/dotfiles/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# fzf
if [[ "$UNAME" == "Darwin" ]]; then
    FZF_KEYBINDINGS_PATH="/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
    FZF_COMPLETION_PATH="/opt/homebrew/opt/fzf/shell/completion.zsh"
# works for silverblue, might have to edit if another distro
elif [[ "$UNAME" == "Linux" ]]; then
    FZF_KEYBINDINGS_PATH="/usr/share/fzf/shell/key-bindings.zsh"
    FZF_COMPLETION_PATH="/usr/share/zsh/site-functions/fzf"
fi

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"' # use with fd instead of find
[[ -f "$FZF_KEYBINDINGS_PATH" ]] && source "$FZF_KEYBINDINGS_PATH"
[[ -f "$FZF_COMPLETION_PATH" ]] && source "$FZF_COMPLETION_PATH"

# macOS only: add homebrew bin
if [[ "$UNAME" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# macOS only aliases
if [[ "$UNAME" == "Darwin" ]]; then
    alias ls='gls --color=auto'
elif [[ "$UNAME" == "Linux" ]]; then
    alias ls='ls --color=auto'
fi

# everything aliases
alias l='ls'
alias la='ls -Avh --color=auto'
alias ll='ls -alhFv --color=auto --group-directories-first'

alias fd='fd --hidden'

# require virtualenv for pip and provide workaround
export PIP_REQUIRE_VIRTUALENV=true
pip-global() {
    PIP_REQUIRE_VIRTUALENV=false pip "$@"
}
pip3-global() {
    PIP_REQUIRE_VIRTUALENV=false pip3 "$@"
}

# set our preferred editor
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# setup pyenv because python on macos is a disaster
# if  [[ "${UNAME}" == "Darwin" ]] && command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
#     eval "$(pyenv init --path)"
#     eval "$(pyenv virtualenv-init -)"
# fi
