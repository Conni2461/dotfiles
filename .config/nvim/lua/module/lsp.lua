local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local cmp = require "cmp"

vim.fn.sign_define("DiagnosticSignError", {
  text = " ",
  texthl = "DiagnosticError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
  text = " ",
  texthl = "DiagnosticWarn",
})
vim.fn.sign_define("DiagnosticSignInfo", {
  text = " ",
  texthl = "DiagnosticInfo",
})
vim.fn.sign_define("DiagnosticSignHint", {
  text = "ﯦ ",
  texthl = "DiagnosticHint",
})

vim.cmd [[
  hi DiagnosticError guifg=Red guibg=#282a2e
  hi DiagnosticWarn guifg=Orange guibg=#282a2e
  hi DiagnosticInfo guifg=LightBlue guibg=#282a2e
  hi DiagnosticHint guifg=LightGrey guibg=#282a2e
]]

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append "c"
vim.opt.pumblend = 10

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or d.user_data.lsp.code
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}

require("fidget").setup {}
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      select = true,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  },
  experimental = {
    native_menu = false,
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer", keyword_length = 5 },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

vim.lsp.protocol.CompletionItemKind = {
  " [text]",
  " [method]",
  "ƒ [function]",
  " [constructor]",
  " [field]",
  " [variable]",
  " [class]",
  " [interface]",
  " [module]",
  " [property]",
  " [unit]",
  " [value]",
  " [enum]",
  " [keyword]",
  "﬌ [snippet]",
  " [color]",
  " [file]",
  " [reference]",
  " [dir]",
  " [enummember]",
  " [constant]",
  " [struct]",
  "  [event]",
  " [operator]",
  " [type]",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    local input = { ... }
    vim.keymap.set(input[1], input[2], input[3], { buffer = 0, noremap = true, silent = true })
  end
  buf_set_keymap("n", "<leader>ad", vim.lsp.buf.definition)
  buf_set_keymap("n", "<leader>at", vim.lsp.buf.type_definition)
  buf_set_keymap("n", "<leader>ai", vim.lsp.buf.declaration)
  buf_set_keymap("n", "K", vim.lsp.buf.hover)
  buf_set_keymap("i", "<c-s>", vim.lsp.buf.signature_help)
  buf_set_keymap("n", "<leader>an", vim.diagnostic.goto_next)
  buf_set_keymap("n", "<leader>ap", vim.diagnostic.goto_prev)
  buf_set_keymap("n", "<Leader>ar", require("telescope.builtin").lsp_references)
  buf_set_keymap("n", "<leader>ac", R("telescope.builtin").lsp_document_symbols)
  buf_set_keymap("n", "<leader>aw", function()
    R("telescope.builtin").lsp_workspace_symbols { query = vim.fn.input "Query >" }
  end)
  buf_set_keymap("n", "<leader>aa", vim.lsp.buf.code_action)

  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
    buf_set_keymap("n", "<leader>am", ":ClangdSwitchSourceHeader<CR>")
  end

  local lsp_group = vim.api.nvim_create_augroup("custom_lsp_stuff", { clear = true })
  vim.api.nvim_create_autocmd(
    "CursorHold,CursorHoldI",
    { pattern = "<buffer>", callback = require("nvim-lightbulb").update_lightbulb, group = lsp_group }
  )
end

for _, server in ipairs {
  "bashls",
  "cmake",
  {
    "clangd",
    { "clangd", "--background-index", "--header-insertion=never", "--suggest-missing-includes", "--clang-tidy" },
  },
  { "cssls", { "css-languageserver", "--stdio" } },
  "dockerls",
  "gopls",
  { "html", { "html-languageserver", "--stdio" } },
  "intelephense",
  { "jsonls", { "vscode-json-languageserver", "--stdio" } },
  "rnix",
  "rust_analyzer",
  "texlab",
  "tsserver",
  "vimls",
  "yamlls",
  "ocamllsp",
} do
  if type(server) == "table" then
    lspconfig[server[1]].setup {
      cmd = server[2],
      on_attach = on_attach,
      capabilities = capabilities,
    }
  else
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua"
    local stat = vim.loop.fs_stat(lua_path)
    if stat and stat.type == "directory" then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand "$VIMRUNTIME/lua"] = true
  return result
end

lspconfig.lua_ls.setup {
  cmd = { "lua-language-server" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        enable = true,
        globals = { "vim", "describe", "it", "before_each", "teardown", "pending" },
      },
      workspace = {
        library = get_lua_runtime(),
        maxPreload = 1000,
        preloadFileSize = 1000,
        checkThirdParty = false,
      },
    },
  },
}

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Check for a poetry.lock file
  if vim.fn.glob(util.path.join(workspace, "poetry.lock")) ~= "" then
    return util.path.join(vim.fn.trim(vim.fn.system "poetry env info -p"), "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(util.path.join(workspace, "Pipfile"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
    return util.path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,
}
