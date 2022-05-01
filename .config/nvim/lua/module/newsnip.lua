local ls = require "luasnip"
-- some shorthands...
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

vim.g.snips_author = "conni2461"
vim.g.snips_email = "Simon-Hauser@outlook.de"
vim.g.snips_github = "conni2461"

ls.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
}

local function mirror(args)
  return sn(nil, { t { args[1][1] } })
end

local force_comment = function()
  return f(function()
    return { string.format(vim.bo.commentstring, "") }
  end, {})
end

ls.add_snippets("all", {
  s({ trig = "copyright" }, {
    force_comment(),
    t { "Copyright (C) " },
    i(1, { vim.g.snips_author }),
    t { " " },
    i(2, { os.date "%Y" }),
    i(0),
  }),
  s({ trig = "todo" }, {
    force_comment(),
    t { "TODO(" },
    i(1, { vim.g.snips_author }),
    t { "): " },
    i(0),
  }),
  s({ trig = "fixme" }, {
    force_comment(),
    t { "FIXME(" },
    i(1, { vim.g.snips_author }),
    t { "): " },
    i(0),
  }),
  s({ trig = "note" }, {
    force_comment(),
    t { "NOTE(" },
    i(1, { vim.g.snips_author }),
    t { "): " },
    i(0),
  }),
})

local function luadoc(args, old_state)
  local nodes = {
    t { "--- " },
    i(1, { "A short Description" }),
  }
  local param_nodes = {}

  if old_state then
    nodes[2] = i(1, old_state.descr:get_text())
  end
  param_nodes.descr = nodes[2]

  local insert = 2
  for _, arg in ipairs(vim.split(args[1][1], ", ", true)) do
    if arg ~= "" then
      local inode
      -- if there was some text in this parameter, use it as static_text for this new snippet.
      if old_state and old_state[arg] then
        inode = i(insert, old_state["arg" .. arg]:get_text())
      else
        inode = i(insert)
      end
      vim.list_extend(nodes, { t { "", "" }, t { "---@param " .. arg .. " " }, inode })
      param_nodes["arg" .. arg] = inode

      insert = insert + 1
    end
  end

  local snip = sn(nil, nodes)
  -- Error on attempting overwrite.
  snip.old_state = param_nodes
  return snip
end

ls.add_snippets("lua", {
  s({ trig = "fn" }, {
    d(3, luadoc, { 2 }),
    t { "", "" },
    t { "function " },
    i(1, { "myFunc" }),
    t { "(" },
    i(2),
    t { ")", "  " },
    i(0),
    t { "", "end" },
  }),
})

local function cdocs(args, old_state)
  local nodes = {
    t { "/**", " * " },
    i(1, { "A short Description" }),
    t { "", "" },
  }

  -- These will be merged with the snippet; that way, should the snippet be updated,
  -- some user input eg. text can be referred to in the new snippet.
  local param_nodes = {}

  if old_state then
    nodes[2] = i(1, old_state.descr:get_text())
  end
  param_nodes.descr = nodes[2]

  -- At least one param.
  if string.find(args[2][1], ", ") then
    vim.list_extend(nodes, { t { " * ", "" } })
  end

  local insert = 2
  for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
    -- Get actual name parameter.
    arg = vim.split(arg, " ", true)[2]
    if arg then
      local inode
      -- if there was some text in this parameter, use it as static_text for this new snippet.
      if old_state and old_state[arg] then
        inode = i(insert, old_state["arg" .. arg]:get_text())
      else
        inode = i(insert)
      end
      vim.list_extend(nodes, { t { " * @param " .. arg .. " " }, inode, t { "", "" } })
      param_nodes["arg" .. arg] = inode

      insert = insert + 1
    end
  end

  if args[1][1] ~= "void" then
    local inode
    if old_state and old_state.ret then
      inode = i(insert, old_state.ret:get_text())
    else
      inode = i(insert)
    end

    vim.list_extend(nodes, { t { " * ", " * @return " }, inode, t { "", "" } })
    param_nodes.ret = inode
    insert = insert + 1
  end

  vim.list_extend(nodes, { t { " */" } })

  local snip = sn(nil, nodes)
  -- Error on attempting overwrite.
  snip.old_state = param_nodes
  return snip
end

local c_cc_snip = {
  s({ trig = "main" }, {
    t { "int main(int argc, char *argv[]) {", "  " },
    i(0),
    t { "", "  return 0;", "}" },
  }),
  s({ trig = "ndef" }, {
    t { "#idndef " },
    i(1),
    t { "", "#define " },
    d(2, mirror, { 1 }),
    t { " " },
    i(3),
    t { "", "#endif /* ifndef " },
    d(4, mirror, { 1 }),
    t { " */", "" },
    i(0),
  }),
  s({ trig = "guard" }, {
    t { "#idndef " },
    i(1),
  }),
  s({ trig = "fn" }, {
    d(4, cdocs, { 1, 3 }),
    t { "", "" },
    i(1, { "void" }),
    t { " " },
    i(2, { "myFunc" }),
    t { "(" },
    i(3),
    t { ")" },
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),
}
ls.add_snippets("cpp", c_cc_snip)
ls.add_snippets("c", c_cc_snip)

vim.cmd [[
  imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'
  imap <silent><expr> <C-j> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>'

  snoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(1)<Cr>
  snoremap <silent> <C-j> <cmd>lua require'luasnip'.jump(-1)<Cr>
]]
