local mode_map = {
  ['n'] = 'NORMAL',
  ['i'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ["\\<C-v>"]= 'V-BLOCK',
  ['c'] = 'COMMAND',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ["\\<C-s>"] = 'S-BLOCK',
  ['t'] = 'TERMINAL',
}

local block = function(hi, txt, new)
  return string.format("%%#%s#%s%s", hi, txt, new and "%=" or "")
end

local m = {}

m.init = function()
  vim.cmd [=[ autocmd BufWinEnter,WinEnter * :lua require("module/simpleline").update() ]=]
  m.update()
end

m.update = function()
  local curr = vim.fn.winnr()
  local last = vim.fn.winnr("$")
  for i = 1, last do
    if i == curr then
      vim.fn.setwinvar(i, "&statusline", [=[%!luaeval('require("module/simpleline").active()')]=])
    else
      vim.fn.setwinvar(i, "&statusline", [=[%!luaeval('require("module/simpleline").inactive()')]=])
    end
  end
end

m.active = function()
  local mode = vim.api.nvim_get_mode().mode

  local res = {
    block("ColorColumn", string.format("%%( %s %%)", mode_map[mode]), false),
    block("ColorColumn", "%t", true),
    block("ColorColumn", "%p%%")
  }

  return table.concat(res)
end

m.inactive = function()
  return table.concat({ block("ColorColumn", "%t") })
end

return m
