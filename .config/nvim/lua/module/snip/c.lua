local U = require'snippets.utils'

local c = {
  ["#if"] = [[
#if ${1:CONDITION}
$0
#endif // $1
]],
  guard = [[
#ifndef _${1:header name|S.v:upper():gsub("%s+", "_")}_H_
#define _$1_H_

$0

#endif // _${|S[1]:gsub("%s+", "_")}_H_
]],
  inc = [[#include "${=vim.fn.expand("%:t"):upper()}"]],
  main = U.match_indentation [[
int main(int argc, char *argv[]) {
	$0
	return 0;
}]],
}

local m = {}

m.get_snippets = function()
  return c
end

return m

--[[
autocmd Filetype c inoremap ,in #include<><ESC>0f<a
autocmd Filetype c inoremap ,de #define<space>
autocmd Filetype c inoremap ,id #ifndef<space><++><Enter>#define<space><++><Enter>#endif<ESC>2k0f<i
autocmd Filetype c inoremap ,ma int main(int argc, char *argv[])<Enter>{<Enter><Enter>return 0;<Enter>}<ESC>2kli
autocmd Filetype c inoremap ,st typedef struct<space>{<Enter><Enter>}<++>;<ESC>0f<i
autocmd Filetype c inoremap ,en enum <++> {<Enter><Enter>};<ESC>2k0f<
--]]
