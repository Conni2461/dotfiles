local cmp = require "cmp"

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append "c"
vim.opt.pumblend = 10

vim.diagnostic.config {
  virtual_text = true,
  underline = false,
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
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

cmp.setup.cmdline({ "/", "?" }, {
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

local function get_python_path()
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

for _, server in ipairs {
  {
    "bashls",
    settings = {
      ["bashIde"] = {
        shellcheckArguments = "--extended-analysis=false -o add-default-case,avoid-nullary-conditions,check-set-e-suppressed,deprecate-which,quote-safe-variables,require-double-brackets,require-variable-braces -S style",
      },
    },
  },
  "buf_ls",
  "cmake",
  {
    "clangd",
    cmd = { "clangd", "--background-index", "--header-insertion=never", "--suggest-missing-includes", "--clang-tidy" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },
  { "cssls", cmd = { "vscode-css-language-server", "--stdio" } },
  "dockerls",
  "gopls",
  { "html", cmd = { "vscode-html-language-server", "--stdio" } },
  "intelephense",
  {
    "java_language_server",
    cmd = { "java-language-server" },
  },
  { "jsonls", cmd = { "vscode-json-language-server", "--stdio" } },
  { "tinymist" },
  {
    "lua_ls",
    cmd = { "lua-language-server" },
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
  },
  {
    "nil_ls",
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixfmt" },
        },
      },
    },
  },
  {
    "pyright",
    on_init = function(client)
      client.config.settings.python.pythonPath = get_python_path()
    end,
  },
  "ruff",
  {
    "rust_analyzer",
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
        },
      },
    },
  },
  "svelte",
  "tailwindcss",
  "texlab",
  "ts_ls",
  "vuels",
  "zls",
} do
  if type(server) == "table" then
    vim.lsp.config(server[1], {
      cmd = server.cmd,
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = server.filetypes,
      settings = server.settings,
      on_init = server.on_init,
    })
    vim.lsp.enable(server[1])
  else
    vim.lsp.config(server, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    vim.lsp.enable(server)
  end
end

local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    -- misc
    -- null_ls.builtins.diagnostics.commitlint,

    -- nix
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.deadnix,

    -- lua
    -- null_ls.builtins.diagnostics.luacheck
  },
}

for _, method in ipairs { "textDocument/diagnostic", "workspace/diagnostic" } do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
