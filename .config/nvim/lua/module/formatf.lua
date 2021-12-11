local cmds = {
  cmake = "cmake-format -i",
  c = "clang-format --style=file -i",
  cpp = "clang-format --style=file -i",
  rust = "rustfmt --edition 2018",
  python = "black",
  html = "prettier -w",
  yaml = "prettier -w",
  json = "prettier -w",
  javascript = "prettier -w",
  typescript = "prettier -w",
  lua = "stylua",
  java = "astyle -A2 -s2 -c -J -n -q -z2 -xC80",
  sh = "shfmt -w -i 2 -ci -sr",
  bash = "shfmt -w -i 2 -ci -sr",
}

local m = {}
m.run = function()
  vim.cmd(":silent w!")
  vim.cmd((":silent !%s %%"):format(cmds[vim.o.filetype]))
  vim.cmd(":silent e")
  vim.cmd(":silent LuaSnipUnlinkCurrent")
end

return m
