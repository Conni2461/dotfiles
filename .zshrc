#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

alias rm="trash"
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias ls="exa -bghla -snew"

autoload -Uz promptinit
promptinit
prompt pure

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx 2> /dev/null
fi

export HISTSIZE=10000000 
export SAVEHIST=10000000
