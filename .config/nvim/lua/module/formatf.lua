local external_format = function(cmd)
  return function()
    vim.cmd [[:silent w!]]
    vim.cmd((":silent !%s %%"):format(cmd))
    vim.cmd [[:silent e]]
    vim.cmd [[:silent LuaSnipUnlinkCurrent]]
  end
end

local builtin_fmt = function()
  vim.lsp.buf.format { async = false }
  vim.cmd [[:silent w]]
end

local cmds = {
  cmake = external_format "cmake-format -i",
  c = external_format "clang-format --style=file -i",
  cpp = external_format "clang-format --style=file -i",
  rust = builtin_fmt,
  go = builtin_fmt,
  python = external_format "black",
  html = external_format "prettier -w",
  htmldjango = external_format "prettier -w",
  css = external_format "prettier -w",
  yaml = external_format "prettier -w",
  json = external_format "prettier -w",
  svelte = builtin_fmt,
  vue = builtin_fmt,
  javascript = builtin_fmt,
  typescript = builtin_fmt,
  scss = builtin_fmt,
  lua = external_format "stylua",
  java = external_format "astyle -A2 -s2 -c -J -n -q -z2 -xC80",
  sh = external_format "shfmt -w -i 2 -ci -sr",
  bash = external_format "shfmt -w -i 2 -ci -sr",
  nix = external_format "nixfmt",
  php = external_format "php-cs-fixer fix --rules=@PSR12",
}

local m = {}
m.run = function()
  cmds[vim.o.filetype]()
end

return m
