local Job = require("plenary.job")

local mode_map = {
  ['n'] = { 'NORMAL', 'ColorColumn' },
  ['i'] = { 'INSERT', 'Conceal' },
  ['R'] = { 'REPLACE', 'Character' },
  ['v'] = { 'VISUAL', 'Boolean' },
  ['V'] = { 'V-LINE', 'Boolean' },
  [""]= { 'V-BLOCK', 'Boolean' },
  ['c'] = { 'COMMAND', 'ColorColumn' },
  ['s'] = { 'SELECT', 'Boolean' },
  ['S'] = { 'S-LINE', 'Boolean' },
  [""] = { 'S-BLOCK', 'Boolean' },
  ['t'] = { 'TERMINAL', 'Conceal' },
}

local block = function(hi, txt)
  return string.format("%%#%s#%s", hi, txt)
end

local static_entries = {
  filename = block("ColorColumn", "%t"),
  info = block("ColorColumn", "%l:%c | %p%%"),
  inactive = block("ColorColumn", "%t"),
  separator = block("ColorColumn", "%( | %)")
}
local cached_entires = { branch = "" }

local if_left = function(left)
  if left ~= "" then return static_entries.separator end
  return ""
end

local severities = { "Error", "Warning", "Information", "Hint" }
local severities_gens = {
  "%%#LspDiagnosticsDefaultError#%%(" .. vim.g.indicator_errors .. "%d%%)",
  "%%#LspDiagnosticsDefaultWarning#%%(" .. vim.g.indicator_warnings .. "%d%%)",
  "%%#LspDiagnosticsDefaultInformation#%%(" .. vim.g.indicator_infos .. "%d%%)",
  "%%#LspDiagnosticsDefaultHint#%%(" .. vim.g.indicator_hints .. "%d%%)",
}
local diagnostics = function()
  local output = {}
  local size = 0
  for i = #severities, 1, -1 do
    local res = vim.lsp.diagnostic.get_count(0, severities[i])
    if res > 0 then
      if size > 0 then
        output[size] = output[size] .. " "
      end
      size = size + 1
      output[size] = string.format(severities_gens[i], res)
    end
  end
  return table.concat(output)
end

local branch = function()
  if cached_entires.branch ~= "" then
    return block("ColorColumn", string.format("%%( |  %s%%)", cached_entires.branch))
  end
  return ""
end

local m = {}

m.init = function()
  vim.cmd [=[ autocmd BufWinEnter,WinEnter * :lua require("module/simpleline").update() ]=]
  m.update()
end

m.update = function()
  Job:new({ "git", "branch", "--show-current", cwd = vim.loop.cwd(), on_exit = function(j, c)
    if c == 0 then
      cached_entires.branch = j:result()[1]
    end
  end }):start()

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
  local mode = mode_map[vim.fn.mode()]
  local lsp = diagnostics()
  local git = branch()

  local res = {
    block(mode[2], string.format("%%( %s %%)", mode[1])),
    static_entries.filename,
    git,
    "%=",
    lsp,
    if_left(lsp),
    static_entries.info
  }

  return table.concat(res)
end

m.inactive = function()
  return static_entries.inactive
end

return m
