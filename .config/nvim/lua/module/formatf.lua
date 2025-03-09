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
  bash = external_format "shfmt -w -i 2 -ci -sr",
  c = external_format "clang-format --style=file -i",
  cmake = external_format "cmake-format -i",
  cpp = external_format "clang-format --style=file -i",
  css = external_format "prettier -w",
  go = builtin_fmt,
  html = external_format "prettier -w",
  htmldjango = external_format "prettier -w",
  java = external_format "astyle -A2 -s2 -c -J -n -q -z2 -xC80",
  javascript = builtin_fmt,
  json = external_format "prettier -w",
  lua = external_format "stylua",
  nix = builtin_fmt,
  php = external_format "php-cs-fixer fix --rules=@PSR12",
  python = external_format "black",
  rust = builtin_fmt,
  scss = builtin_fmt,
  sh = external_format "shfmt -w -i 2 -ci -sr",
  svelte = builtin_fmt,
  toml = external_format "taplo format",
  typescript = builtin_fmt,
  typst = external_format "typstyle -i",
  vue = builtin_fmt,
  yaml = external_format "prettier -w",
  zig = builtin_fmt,
}

local m = {}
m.run = function()
  cmds[vim.o.filetype]()
end

return m
