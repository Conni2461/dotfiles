#!/bin/sh
# Profile file. Runs on login

export PATH=$PATH:$(find $HOME/bin -mindepth 1 -maxdepth 1 -type d | grep -Ev 'external|shared' | tr '\n' ':' | sed 's/:*$//')

export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL="st"
export BROWSER='firefox'
export READER='zathura'
export SUDO_ASKPASS="$HOME/bin/scripts/askpass"
export PAGER='less'

# Enable X11 VA-API for Firefox
export MOZ_X11_EGL=1

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"
# Disable Less hist
export LESSHISTFILE=-

# Set XDG BASE DIRECTORIES
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# Change Config Dirs
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# Enable Calibre Dark Mode
export CALIBRE_USE_DARK_PALETTE=1

# Fixing misbehaving Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# Bash specific stuff
if echo $SHELL | grep 'bash' >/dev/null; then
	export HISTCONTROL=ignoreboth:erasedups
	if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
fi

# ZSH specific stuff
if echo "$SHELL" | grep 'zsh' >/dev/null; then
	if [ -f ~/.zshrc ]; then . ~/.zshrc; fi
fi
