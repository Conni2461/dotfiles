local indent = require'snippets.utils'.match_indentation

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
  ["if"] = indent [[
if [ $1 ]; then
	$0
fi]],
  elif = indent [[
elif [ $1 ]; then
	$0]],
  ["for"] = indent [[
for (( ${2:i} = 0; $2 < ${1:count}; $2++ )); do
	$0
done]],
  fori = indent [[
for ${1:el} in $2; do
	$0
done]],
  wh = indent [[
while [ $1 ]; do
	$0
done]],
  ["until"] = indent [[
until [ $1 ]; do
	$0
done]],
  case = indent [[
case $1 in
	$2)
		$0;;
esac]],
  root = [[if [ \$(id -u) -ne 0 ]; then exec sudo \$0; fi]],
  fun = indent [[
$1() {
	$0
}]],
  ["fun-bash"] = indent [[
function $1() {
	$0
}]],
}

local m = {}

m.get_snippets = function()
  return sh
end

return m
