#!/bin/bash
# Profile file. Runs on login

export PATH=$PATH:$(find $HOME/bin -mindepth 1 -maxdepth 1 -type d | grep -Ev 'external|shared' | tr '\n' ':' | sed 's/:*$//')

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL="st"
export BROWSER='firefox'
export READER='zathura'
export SUDO_ASKPASS="$HOME/bin/scripts/askpass"
export PAGER='less'

export HISTCONTROL=ignoreboth:erasedups

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# Git Review
export REVIEW_BASE=master

# Fixing misbehaving Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi
