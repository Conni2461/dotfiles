local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local cmp = require("cmp")

cmp.setup{
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm{
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = true,
  signs = true,
  update_in_insert = true,
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "<leader>ad", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>at", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>ai", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>an", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>ap", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<Leader>ar", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap("n", "<leader>ac", "<cmd>lua RTELE(); require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
  buf_set_keymap(
    "n",
    "<leader>aw",
    "<cmd>lua RTELE(); require'telescope.builtin'.lsp_workspace_symbols{ query = vim.fn.input('Query >') }<CR>",
    opts
  )
  buf_set_keymap("n", "<leader>aa", "<cmd>lua RTELE(); require'telescope.builtin'.lsp_code_actions{}<cr>", opts)

  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
    buf_set_keymap("n", "<leader>am", ":ClangdSwitchSourceHeader<CR>", opts)
  end

  vim.cmd([[autocmd CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()]])
  if vim.bo.filetype == "rust" then
    vim.cmd(
      "autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer> "
        .. 'lua require"lsp_extensions".inlay_hints{ prefix = " » ", highlight = "NonText", '
        .. 'aligned = true, enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }'
    )
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

  result[vim.fn.expand("$VIMRUNTIME/lua")] = true
  return result
end

local lua_settings = {
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
    },
  },
}

local function setup_ls(ls, ls_cmd, backup, backup_cmd, passed_settings)
  if type(ls_cmd) == "string" then
    ls_cmd = { ls_cmd }
  end
  if backup_cmd and type(backup_cmd) == "string" then
    backup_cmd = { backup_cmd }
  end

  if util.has_bins(ls_cmd[1]) then
    lspconfig[ls].setup({
      on_attach = on_attach,
      cmd = ls_cmd,
      settings = passed_settings,
      capabilities = capabilities,
    })
  elseif backup and backup_cmd and util.has_bins(backup_cmd[1]) then
    lspconfig[backup].setup({
      on_attach = on_attach,
      cmd = backup_cmd,
      settings = passed_settings,
      capabilities = capabilities,
    })
  end
end

setup_ls("als", "ada_language_server")
setup_ls("bashls", { "bash-language-server", "start" })
setup_ls(
  "clangd",
  { "clangd", "--background-index", "--header-insertion=never", "--suggest-missing-includes", "--clang-tidy" }
)
setup_ls("cmake", "cmake-language-server")
setup_ls("cssls", { "css-languageserver", "--stdio" })
setup_ls("dockerls", { "docker-langserver", "--stdio" })
setup_ls("elixirls", "elixir-ls")
setup_ls("flow", { "npm", "run", "flow", "lsp" })
setup_ls("fortls", "fortls")
setup_ls("gopls", "gopls")
setup_ls("html", { "html-languageserver", "--stdio" })
setup_ls("jsonls", { "vscode-json-languageserver", "--stdio" })
setup_ls("java_language_server", "java-language-server")
setup_ls("kotlin_language_server", "kotlin-language-server")
setup_ls("metals", "metals")
setup_ls("rust_analyzer", "rust-analyzer", "rls", "rls")
setup_ls("solargraph", { "solargraph", "stdio" })
setup_ls("sumneko_lua", "lua-language-server", nil, nil, lua_settings)
setup_ls("sqlls", "sql-language-server")
setup_ls("texlab", "texlab")
setup_ls("tsserver", { "typescript-language-server", "--stdio" })
setup_ls("vimls", { "vim-language-server", "--stdio" })
setup_ls("yamlls", { "yaml-language-server", "--stdio" })

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Check for a poetry.lock file
  if vim.fn.glob(util.path.join(workspace, 'poetry.lock')) ~= '' then
    return util.path.join(vim.fn.trim(vim.fn.system('poetry env info -p')), 'bin', 'python')
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(util.path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    return util.path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end
}
