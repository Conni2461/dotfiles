#!/bin/bash
# Profile file. Runs on login

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL="st"
export BROWSER='firefox'
export READER='zathura'
export FILE="ranger"
export SUDO_ASKPASS="$HOME/bin/scripts/askpass"
export PAGER='less'

# NNN Settings
export NNN_OPENER=mimeopen
export NNN_CONTEXT_COLORS='1234'
export NNN_SCRIPT=/home/conni/.config/nnn/plugins
export NNN_USE_EDITOR=1
export NNN_TRASH=1


if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)
export PATH=$PATH:/home/conni/bin/scripts:/home/conni/bin/croncmds:/home/conni/bin/i3cmds:/home/conni/bin/gitcmds:/home/conni/bin/statusbar:/home/conni/bin/vimcmds:/home/conni/bin/external/fstools

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'
