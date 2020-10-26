local U = require'snippets.utils'

local sh = {
  ["#!"] = [[#!/bin/sh]],
  ["s#!"] = [[
#!/bin/sh
set -eu]],
  safe = [[set -eu]],
  bash = [[#!/bin/bash]],
  sbash = [[
#!/bin/bash
set -euo pipefail
IFS=\$'\n\t']],
  ["if"] = U.match_indentation [[
if [ $1 ]; then
	$0
fi]],
  elif = U.match_indentation [[
elif [ $1 ]; then
	$0]],
  ["for"] = U.match_indentation [[
for (( ${2:i} = 0; $2 < ${1:count}; $2++ )); do
	$0
done]],
  fori = U.match_indentation [[
for ${1:el} in $2; do
	$0
done]],
  wh = U.match_indentation [[
while [ $1 ]; do
	$0
done]],
  ["until"] = U.match_indentation [[
until [ $1 ]; do
	$0
done]],
  case = U.match_indentation [[
case $1 in
	$2)
		$0;;
esac]],
  root = [[if [ \$(id -u) -ne 0 ]; then exec sudo \$0; fi]],
  fun = U.match_indentation [[
$1() {
	$0
}]],
  ["fun-bash"] = U.match_indentation [[
function $1() {
	$0
}]],
}

local m = {}

m.get_snippets = function()
  return sh
end

return m
