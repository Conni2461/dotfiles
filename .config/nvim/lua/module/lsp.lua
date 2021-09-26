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
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
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
  require("lsp_signature").on_attach({
    handler_opts = {
      border = "none",
    },
  })

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "<leader>ad", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>at", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>ai", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>as", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>an", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>ap", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<leader>av", "<cmd>lua MyLspRename()<CR>", opts)
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
setup_ls("pyright", { "pyright-langserver", "--stdio" }, "pyls", "pyls")
setup_ls("rust_analyzer", "rust-analyzer", "rls", "rls")
setup_ls("solargraph", { "solargraph", "stdio" })
setup_ls("sumneko_lua", "lua-language-server", nil, nil, lua_settings)
setup_ls("sqlls", "sql-language-server")
setup_ls("texlab", "texlab")
setup_ls("tsserver", { "typescript-language-server", "--stdio" })
setup_ls("vimls", { "vim-language-server", "--stdio" })
setup_ls("yamlls", { "yaml-language-server", "--stdio" })

lspconfig.r_language_server.setup({
  on_attach = on_attach,
  root_dir = function()
    return vim.loop.cwd()
  end,
})

if util.has_bins("diagnostic-languageserver") then
  lspconfig.diagnosticls.setup({
    cmd = { "diagnostic-languageserver", "--stdio" },
    filetypes = { "sh" },
    on_attach = on_attach,
    init_options = {
      filetypes = {
        sh = "shellcheck",
      },
      linters = {
        shellcheck = {
          sourceName = "shellcheck",
          command = "shellcheck",
          debounce = 100,
          args = { "--format=gcc", "-" },
          offsetLine = 0,
          offsetColumn = 0,
          formatLines = 1,
          formatPattern = {
            "^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
            {
              line = 1,
              column = 2,
              message = 4,
              security = 3,
            },
          },
          securities = {
            error = "error",
            warning = "warning",
          },
        },
      },
    },
  })
end

function MyLspRename()
  local current_word = vim.fn.expand("<cword>")

  local plenary_window = require("plenary.window.float").percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, "buftype", "prompt")
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= "" then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

        vim.lsp.buf.rename(text)
      end)
    else
      print("Nothing to rename!")
    end
  end)

  vim.cmd([[startinsert]])
end

local function rename()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local cword = vim.fn.expand("<cword>")
  local line_nr, col = cursor[1], cursor[2] + 1
  local title = "Rename '" .. cword .. "'"

  local i = 1
  local word_start, word_end = string.find(line, cword, col - i)
  while word_end == nil or col - i < 0 do
    i = i + 1
    word_start, word_end = string.find(line, cword, col - i)
  end

  local popup_opts = {
    padding = { 0, 0, 0, 0 },
    width = #title + 4,
    line = line_nr + 1,
    col = word_start + math.floor((word_end - word_start) / 2),
    cursor_line = true,
    border = true,
    title = title,
    enter = true,
    callback = function()
      print("Hello")
    end,
  }

  local buf_no, buf_opts
  popup.create(cword, popup_opts)
  local buf = vim.api.nvim_win_get_buf(buf_no)
  print(buf)
end
