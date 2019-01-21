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
alias uni="cd /mnt/external/Google\ Drive/Uni/5.\ Semester"

# Qt
alias QtMaintenanceTool="/opt/Qt/MaintenanceTool"
alias QtCreator="/opt/Qt/Tools/QtCreator/bin/qtcreator"

# Customize to your needs..
alias df="df -khT"
alias rm="trash"
alias sizeof="du -hs"
function ssizeof()
{
	sizeof $* | sort -h
}

# Config files
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias eL="vim ~/.config/polybar/launch.sh"
alias eP="vim ~/.config/polybar/config"
alias eV="vim ~/.vimrc"
alias ll="exa -bghla -sname"

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

alias propaada="gnatmake -gnat12 -gnatwa -gnatwl -gnaty3abcefhiklmnprt"
alias propac="gcc -std=c99 -pedantic -Wall -Wextra -Werror"
alias propac++="c++ -std=c++11 -Wall -Werror -pedantic -O3"
alias propahaskell="ghc -fwarn-tabs"
alias propajava="javac -Xlint:all -Xlint:-serial -Werror"

export PATH=$PATH:/home/conni/.gem/ruby/2.5.0/bin

# nitrogen as Background manager
# lxappearance as theme manager

function docker-pwd()
{
	if [ $# -eq 0 ]; then
		echo "Error provide a docker image"
		return 1
	fi
	sudo docker run  -v `pwd`:`pwd` -w `pwd` -i -t $1 /bin/bash
}

function evaluate-and-start-file()
{
	file $1 | fgrep $2 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		$3 $1
		return 0
	fi
	return 1
}

function show()
{
	if [ $# -eq 0 ]; then
       		echo "Error provide a file"
		return 1
	fi

	evaluate-and-start-file $1 image sxiv && return 0
	evaluate-and-start-file $1 "PDF document" evince && return 0
	evaluate-and-start-file $1 script less && return 0
	evaluate-and-start-file $1 "source" less && return 0

	echo "Found no command to show the content of the file"
	return 1
}

function uninstall()
{
	yaourt -R $1 --recursive
}

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
