local U = require'snippets.utils'

local vim = {
  header = U.match_indentation [[
" File: ${=vim.fn.expand("%:t")}
" Author: ${2=vim.g.snips_author}
" Description: ${3}
${4:" Last Modified: ${=os.date("%B %d, %Y")}}]],
  f = U.match_indentation [[
fun! $1($2)
	$0
endf]],
  t = U.match_indentation [[
try
	$0
catch $1
	$2
endtry]],
  ["for"] = U.match_indentation [[
for $1 in $2
	$0
endfor]],
  forkv = U.match_indentation [[
for [$1,$2] in items($3)
	$0
	unlet $1 $2
endfor]],
  wh = U.match_indentation [[
while $1
	$0
endw]],
  ["if"] = U.match_indentation [[
if $1
	$0
endif]],
  ife = U.match_indentation [[
if $1
	$0
else
	$2
endif]],
  au = U.match_indentation [[
augroup $1
	au!
	au ${2:BufRead,BufNewFile} ${3:*.ext,*.ext3} $0
augroup end]],
  plug = [[Plug '$1']],
  plugdo = [[Plug '$1', { 'do': '$2' }]],
  plugon = [[Plug '$1', { 'on': '$2' }]],
  plugfor = [[Plug '$1', { 'for': '$2' }]],
  plugbr = [[Plug '$1', { 'branch': '$2' }]],
  plugtag = [[Plug '$1', { 'tag': '$2' }]],
  let = [[let $1 = $2]],
  se = [[set $1]],
  set = [[set $1 = $2]],
  nn = [[nnoremap $1 $2]],
  no = [[noremap $1 $2]],
  vm = [[xnoremap $1 $2]],
  im = [[inoremap $1 $2]],
  exe = [[execute $1]],
}

local m = {}

m.get_snippets = function()
  return vim
end

return m
