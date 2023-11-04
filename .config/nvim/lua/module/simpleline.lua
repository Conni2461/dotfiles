local Job = require "plenary.job"
local devicons = require "nvim-web-devicons"

local hl_groups = {
  default = { "ColorColumn" },
  normal = { "SimplelineNormal", "#005f00", "#afdf00" },
  insert = { "SimplelineInsert", "#005f5f", "#ffffff" },
  visual = { "SimplelineVisual", "#870000", "#ff8700" },
  replace = { "SimplelineReplace", "#ffffff", "#df0000" },
  linenr = { "SimplelineNumber", "#303030", "#9e9e9e" },
}
local mode_map = {
  ["n"] = { "N", hl_groups.normal[1] },
  ["i"] = { "I", hl_groups.insert[1] },
  ["R"] = { "R", hl_groups.replace[1] },
  ["v"] = { "V", hl_groups.visual[1] },
  ["V"] = { "V", hl_groups.visual[1] },
  [""] = { "V", hl_groups.visual[1] },
  ["c"] = { "C", hl_groups.normal[1] },
  ["s"] = { "S", hl_groups.visual[1] },
  ["S"] = { "S", hl_groups.visual[1] },
  [""] = { "S", hl_groups.visual[1] },
  ["t"] = { "T", hl_groups.insert[1] },
}

local block = function(hi, txt)
  return string.format("%%#%s#%s", hi, txt)
end
local static_entries = {
  filename = block(hl_groups.default[1], " %t"),
  info = block(hl_groups.linenr[1], "%l:%c ▏%p%%"),
  inactive = block(hl_groups.default[1], "%t"),
}
local cached_entries = { branch = "", filetype = "" }

local severities = { "Error", "Warn", "Info", "Hint" }
local severities_gens = (function()
  local res = {}
  for _, s in ipairs(severities) do
    table.insert(
      res,
      "%%#Diagnostic" .. s .. "#%%(" .. vim.trim(vim.fn.sign_getdefined("DiagnosticSign" .. s)[1].text) .. "%d %%)"
    )
  end
  return res
end)()
local severity = vim.diagnostic.severity
local get_counts = function(diags)
  local errors, warnings, infos, hints = 0, 0, 0, 0
  for _, d in ipairs(diags) do
    if d.severity == severity.ERROR then
      errors = errors + 1
    elseif d.severity == severity.WARN then
      warnings = warnings + 1
    elseif d.severity == severity.INFO then
      infos = infos + 1
    else
      hints = hints + 1
    end
  end
  return { errors, warnings, infos, hints }
end
local diagnostics = function()
  local output = {}
  local counts = get_counts(vim.diagnostic.get(0))
  for i = #severities, 1, -1 do
    if counts[i] > 0 then
      table.insert(output, string.format(severities_gens[i], counts[i]))
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
    return block(hl_groups.default[1], string.format("%%( ▏ %s%%)", cached_entries.branch))
  end
  return ""
end

local m = {}

m.init = function()
  vim.cmd [=[ autocmd BufWinEnter,WinEnter * :lua require("module/simpleline").update(true) ]=]
  vim.cmd [=[ autocmd WinLeave * :lua require("module/simpleline").update(false) ]=]
  for _, tbl in pairs(hl_groups) do
    if #tbl > 1 then
      vim.cmd(string.format("hi %s gui=bold guifg=%s guibg=%s", unpack(tbl)))
    end
  end
  m.update()
end

m.update = function(active)
  active = vim.F.if_nil(active, true)

  local curr = vim.api.nvim_get_current_win()
  if active == true then
    Job:new({
      "git",
      "branch",
      "--show-current",
      on_exit = function(j, c)
        if c == 0 then
          cached_entries.branch = j:result()[1]
        end
      end,
    }):start()
    cached_entries.filetype = devicons.get_icon(vim.fn.expand "%:t", vim.bo.filetype)
    vim.api.nvim_win_set_option(curr, "statusline", [=[%!luaeval('require("module/simpleline").active()')]=])
  else
    vim.api.nvim_win_set_option(
      curr,
      "statusline",
      string.format([=[%%!luaeval('require("module/simpleline").inactive(%d)')]=], curr)
    )
  end
end

m.active = function()
  local mode = mode_map[vim.fn.mode()]
  return table.concat {
    block(mode[2], string.format("%%( %s %%)", mode[1])),
    filetype(),
    static_entries.filename,
    branch(),
    "%=",
    diagnostics(),
    static_entries.info,
  }
end

m.inactive = function(winid)
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local icon = devicons.get_icon(
    vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"),
    vim.api.nvim_buf_get_option(bufnr, "filetype")
  )
  return table.concat {
    icon and block(hl_groups.default[1], string.format("%%(%s %%)", icon)) or "",
    static_entries.inactive,
  }
end

return m
