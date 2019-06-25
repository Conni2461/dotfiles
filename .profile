#!/bin/bash
# Profile file. Runs on login

export PATH=$PATH:/home/conni/bin/scripts:/home/conni/bin/croncmds:/home/conni/bin/wmcmds:/home/conni/bin/gitcmds:/home/conni/bin/statusbar:/home/conni/bin/vimcmds:/home/conni/bin/external/fstools

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL="st"
export BROWSER='firefox'
export READER='zathura'
export FILE="ranger"
export SUDO_ASKPASS="$HOME/bin/scripts/askpass"
export PAGER='less'

# NNN Settings
export NNN_CONTEXT_COLORS='1234'
export NNN_USE_EDITOR=1
export NNN_TRASH=1

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi
