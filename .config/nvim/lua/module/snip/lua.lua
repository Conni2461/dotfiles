local U = require'snippets.utils'

local lua = {
  req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']],
  func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]],
  ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]],
  ["for"] = U.match_indentation [[
for ${1:i}=${2:1},${3:10} do
  $0
end]],
  forp = U.match_indentation [[
for ${1:i},${2:v} in pairs(${3:table_name}) do
  $0
end]],
  fori = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]],
  ["if"] = U.match_indentation [[
if $1 then
  $2
end]],
  ife = U.match_indentation [[
if $1 then
  $2
else
  $0
end]],
  elif = U.match_indentation [[
elseif $1 then
  $0]],
  ["repeat"] = U.match_indentation [[
repeat
  $1
until $0]],
  ["while"] = U.match_indentation [[
while $1 do
  $0
end]],
  print = [[print("$1")]]
}

local m = {}

m.get_snippets = function()
  return lua
end

return m
