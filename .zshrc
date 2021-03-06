autoload -Uz colors
colors
setopt PROMPT_SUBST

PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%c%{$fg[red]%}]%{$reset_color%}$(git_super_status)%B$%b '

# History Settings
# Use same history file for zsh and bash
HISTFILE="$HOME/.sh_history"
HISTSIZE=10000000
SAVEHIST=10000000
unsetopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Completions
zmodload zsh/complist
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# Enable gpg signing over ssh
export GPG_TTY=$(tty)

# Fix ssh for some terminals
export TERM=xterm-256color

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/functionrc" ] && source "$HOME/.config/functionrc"

# Load grc aliases
[ -f "/etc/grc.zsh" ] && source /etc/grc.zsh

# History repeat edit
fh() { print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sk | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g') ; }

# Window title
autoload -Uz vcs_info
precmd () {
	vcs_info
	print -Pn "\e]0;%~\a"
}
preexec () { print -Pn "\e]0;%~\a" }

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Automatic rehash
zstyle ':completion:*' rehash true

# KEYBINDINGS
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

bindkey "^u"      backward-kill-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^a"      beginning-of-line
bindkey "^e"      end-of-line
bindkey "^r"      history-incremental-search-backward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Load zsh-syntax-highlighting; should be last.
[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Local plugins
[ -f "$XDG_CONFIG_HOME/zsh/plugins/you-should-use.zsh" ] && source $XDG_CONFIG_HOME/zsh/plugins/you-should-use.zsh
[ -f "$XDG_CONFIG_HOME/zsh/plugins/git-prompt.zsh" ] && source $XDG_CONFIG_HOME/zsh/plugins/git-prompt.zsh
