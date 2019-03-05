#!/bin/bash
# Profile file. Runs on login

export EDITOR='nvim'
export TERMINAL="st"
export BROWSER='chromium'
export READER='zathura'
export FILE="ranger"
export SUDO_ASKPASS="$HOME/bin/scripts/askpass"
export VISUAL='nvim'
export PAGER='less'

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
export PATH=$PATH:/home/conni/bin/scripts:/home/conni/bin/croncmds:/home/conni/bin/i3cmds:/home/conni/bin/vimcmds

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'
