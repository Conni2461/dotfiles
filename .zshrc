#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ls
unalias ls
alias ls="ls --color=auto"

# Uni
UNI=/mnt/external/Google\ Drive/Uni/5.\ Semester
alias uni="cd $UNI"
alias calw='gcalcli calw'

# Customize to your needs..
alias df="df -khT"
alias rm="trash"

# Config files
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias eL="vim ~/.config/polybar/launch.sh"
alias eP="vim ~/.config/polybar/config"
alias eV="vim ~/.vimrc"
alias eT="vim ~/.tmux.conf"
unalias l
alias l='exa -bghl -sname'
alias ll="exa -bghla -sname"
alias p='sudo pacman'
alias mirrors='sudo pacman-mirrors --fasttrack && p -Syyu'

# Filemanager
alias ffm="nnn"
alias fm="thunar"
alias rfm="ranger"

alias pdf="evince"
alias ccat='pygmentize -g'

# Programs
# peaclock
# calcurse
# gotop
# cava
# cmatrix
# tty-clock

alias marvin="ssh hausersn@marvin.informatik.uni-stuttgart.de"
alias run-ubuntu="sudo docker run -ti --rm ubuntu:latest bash"
alias rasp="ssh pi@pi.apengine.de"

export PATH=$PATH:/home/conni/bin/scripts:/home/conni/.gem/ruby/2.5.0/bin

# nitrogen as Background manager
# lxappearance as theme manager

autoload -Uz promptinit
promptinit
#prompt skwp
prompt pure

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx 2> /dev/null
fi

export HISTSIZE=10000000
export SAVEHIST=10000000

neofetch
