#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
# shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

printf '\033[?1h\033=' >/dev/tty
bind 'set completion-ignore-case on'

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Use same history file for zsh and bash
export HISTFILE=$HOME/.sh_history

source "$HOME/.aliasrc"
source "$HOME/.functionrc"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
