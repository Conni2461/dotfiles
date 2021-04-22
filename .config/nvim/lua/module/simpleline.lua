local Job = require("plenary.job")
local devicons = require("nvim-web-devicons")

local hl_groups = {
  default = { "ColorColumn" },
  normal = { "SimplelineNormal", "#005f00", "#afdf00" },
  insert = { "SimplelineInsert", "#005f5f", "#ffffff" },
  visual = { "SimplelineVisual", "#870000", "#ff8700" },
  replace = { "SimplelineReplace", "#ffffff", "#df0000" },
  linenr = { "SimplelineNumber", "#303030", "#9e9e9e" },
}

local mode_map = {
  ['n'] = { 'NORMAL', hl_groups.normal[1] },
  ['i'] = { 'INSERT', hl_groups.insert[1] },
  ['R'] = { 'REPLACE', hl_groups.replace[1] },
  ['v'] = { 'VISUAL', hl_groups.visual[1] },
  ['V'] = { 'V-LINE', hl_groups.visual[1] },
  [""]= { 'V-BLOCK', hl_groups.visual[1] },
  ['c'] = { 'COMMAND', hl_groups.normal[1] },
  ['s'] = { 'SELECT', hl_groups.visual[1] },
  ['S'] = { 'S-LINE', hl_groups.visual[1] },
  [""] = { 'S-BLOCK', hl_groups.visual[1] },
  ['t'] = { 'TERMINAL', hl_groups.insert[1] },
}

local block = function(hi, txt) return string.format("%%#%s#%s", hi, txt) end
local static_entries = {
  filename = block(hl_groups.default[1], " %t"),
  info = block(hl_groups.linenr[1], "%l:%c | %p%%"),
  inactive = block(hl_groups.default[1], "%t"),
}
local cached_entries = { branch = "", filetype = "" }

local severities = { "Error", "Warning", "Information", "Hint" }
local severities_gens = {
  "%%#LspDiagnosticsDefaultError#%%(" .. vim.g.indicator_errors .. "%d %%)",
  "%%#LspDiagnosticsDefaultWarning#%%(" .. vim.g.indicator_warnings .. "%d %%)",
  "%%#LspDiagnosticsDefaultInformation#%%(" .. vim.g.indicator_infos .. "%d %%)",
  "%%#LspDiagnosticsDefaultHint#%%(" .. vim.g.indicator_hints .. "%d %%)",
}
local diagnostics = function()
  local output = {}
  local size = 0
  for i = #severities, 1, -1 do
    local res = vim.lsp.diagnostic.get_count(0, severities[i])
    if res > 0 then
      size = size + 1
      output[size] = string.format(severities_gens[i], res)
    end
  end
  return table.concat(output)
end

local filetype = function()
  if cached_entries.filetype and cached_entries.filetype ~= "" then
    return block(hl_groups.default[1], string.format("%%( %s%%)", cached_entries.filetype))
  end
  return ""
end

local branch = function()
  if cached_entries.branch ~= "" then
    return block(hl_groups.default[1], string.format("%%( |  %s%%)", cached_entries.branch))
  end
  return ""
end

local m = {}

m.init = function()
  vim.cmd [=[ autocmd BufWinEnter,WinEnter * :lua require("module/simpleline").update() ]=]
  for _, tbl in pairs(hl_groups) do
    if #tbl > 1 then vim.cmd(string.format("hi %s gui=bold guifg=%s guibg=%s", unpack(tbl))) end
  end
  m.update()
end

m.update = function()
  Job:new({ "git", "branch", "--show-current", on_exit = function(j, c)
    if c == 0 then cached_entries.branch = j:result()[1] end
  end }):start()
  cached_entries.filetype = devicons.get_icon(vim.fn.expand('%:t'), vim.bo.filetype)

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
  local res = {
    block(mode[2], string.format("%%( %s %%)", mode[1])),
    filetype(),
    static_entries.filename,
    branch(),
    "%=",
    diagnostics(),
    static_entries.info
  }
  return table.concat(res)
end

m.inactive = function()
  return static_entries.inactive
end

return m
