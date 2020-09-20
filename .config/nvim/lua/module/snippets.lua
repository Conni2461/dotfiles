local snippets = require'snippets'
local U = require'snippets.utils'

local snips = {}

snips._global = {
  copyright = U.force_comment [[Copyright (C) Ashkan Kiani ${=os.date("%Y")}]];
  todo = U.force_comment [[TODO(${1=io.popen("id -un"):read"*l"}): ]];
  uname = function() return vim.loop.os_uname().sysname end;
  date = function() return os.date() end;
  epoch = function() return os.time() end;
  note = U.force_comment [[NOTE(${1=io.popen("id -un"):read"*l"}): ]];
}

snips.lua = {
  req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']];
  func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]];
  ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]];
  -- Match the indentation of the current line for newlines.
  ["for"] = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]];
}

snips.c = {
  ["#if"] = [[
#if ${1:CONDITION}
$0
#endif // $1
]];
  guard = [[
#ifndef _${1:header name|S.v:upper():gsub("%s+", "_")}_H_
#define _$1_H_

$0

#endif // _${|S[1]:gsub("%s+", "_")}_H_
]];
  inc = [[#include "${=vim.fn.expand("%:t"):upper()}"]];
}

snippets.snippets = snips
snippets.use_suggested_mappings()
