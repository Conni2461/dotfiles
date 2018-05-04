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

# Customize to your needs..
alias rm="trash"
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias ls="exa -bghla -snew"
alias filemanager="thunar"
alias pdf="evince"
alias top="htop"
alias marvin="ssh hausersn@marvin.informatik.uni-stuttgart.de"

alias propaada="gnatmake -gnat12 -gnatwa -gnatwl -gnaty3abcefhiklmnprt"
alias propac="gcc -std=c99 -pedantic -Wall -Wextra -Werror"
alias propac++="c++ -std=c++11 -Wall -Werror -pedantic -O3"
alias propahaskell="ghc -fwarn-tabs"
alias propajava="javac -Xlint:all -Xlint:-serial -Werror"

autoload -Uz promptinit
promptinit
prompt pure

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx 2> /dev/null
fi

export HISTSIZE=10000000 
export SAVEHIST=10000000
