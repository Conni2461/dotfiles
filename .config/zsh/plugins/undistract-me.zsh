# This is a slim zsh implementation for undistract-me.
# It's loosely based on https://github.com/MichaelAquilina/zsh-auto-notify
# It uses dunstify and is less configurable because I'm too lazy.

command -v dunstify &>/dev/null || return

_undistract_me_track() {
  _undistract_me_cmd="${1:-$2}"
  _undistract_me_start="$(date +%s)"
}

_undistract_me_send() {
  local rc="${?}"
  local -a ignore_cmds=(
    'g'
    'gc'
    'gd'
    'gdc'
    'htop'
    'journalctl'
    'less'
    'man'
    'nix-shell'
    'nvim'
    'ssh'
    'tmux'
    'v'
    'vim'
    'visops'
    'watch'
  )

  # Nothing set -> nothing to do
  [[ -z "$_undistract_me_cmd" && -z "$_undistract_me_start" ]] && return

  # Check if ignored
  local cmd="${_undistract_me_cmd//^\s*/}"
  cmd="${cmd//^sudo\s*/}"
  cmd="${cmd%% *}"
  if [[ ${ignore_cmds[(ie)$cmd]} -gt ${#ignore_cmds} ]]; then
    # Check if too much time elapsed
    let "elapsed = $(date +%s) - _undistract_me_start"
    if [[ $elapsed -gt 10 ]]; then
      dunstify -a zsh -t 5000 "Command completed after ${elapsed}s (rc ${rc})" "${_undistract_me_cmd}"
    fi
  fi

  _undistract_me_reset
}

_undistract_me_reset() {
  unset _undistract_me_cmd
  unset _undistract_me_start
}

# Start up
autoload -Uz add-zsh-hook
add-zsh-hook preexec _undistract_me_track
add-zsh-hook precmd _undistract_me_send
_undistract_me_reset
