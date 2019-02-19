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
alias uni="cd /mnt/external/Google\ Drive/Uni/5.\ Semester"
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
alias sc="cd ~/bin/scripts"
alias dot="cd ~/repos/dotfiles"
unalias l
alias l='exa -bghl -sname'
alias ll="exa -bghla -sname"
alias p='sudo pacman'
alias y='yaourt'
alias mirrors='sudo pacman-mirrors --fasttrack && p -Syyu'

# Filemanager
alias ffm="nnn"
alias fm="thunar"
alias rfm="ranger"

alias mkd="mkdir -pv"

alias pdf="evince"
alias ccat='highlight --out-format=ansi'

alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="youtube-dl --add-metadata -xic" # Download only audio
alias YT="youtube-viewer"
alias starwars="telnet towel.blinkenlights.nl"
alias scim="sc-im"
alias sway='export XKB_DEFAULT_LAYOUT=de; export XKB_OPTIONS="grp:alt_shift_toggle"; sway'

# Programs
# peaclock
# calcurse
# gotop
# cava
# cmatrix
# tty-clock

alias marvin="ssh hausersn@marvin.informatik.uni-stuttgart.de"
alias run-ubuntu="sudo docker run -ti --rm ubuntu:latest bash"
alias rasp="ssh home"

shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf) ; }

export PATH=$PATH:/home/conni/bin/scripts:/home/conni/bin/croncmds:/home/conni/bin/i3cmds

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
