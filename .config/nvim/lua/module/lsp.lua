local lspconfig = require'lspconfig'
local util      = require'lspconfig/util'

require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

vim.lsp.protocol.CompletionItemKind = {
  ' [text]',
  ' [method]',
  'ƒ [function]',
  ' [constructor]',
  ' [field]',
  ' [variable]',
  ' [class]',
  ' [interface]',
  ' [module]',
  ' [property]',
  ' [unit]',
  ' [value]',
  ' [enum]',
  ' [keyword]',
  '﬌ [snippet]',
  ' [color]',
  ' [file]',
  ' [reference]',
  ' [dir]',
  ' [enummember]',
  ' [constant]',
  ' [struct]',
  '  [event]',
  ' [operator]',
  ' [type]',
}

local on_attach = function(_, _)
  require'lsp_signature'.on_attach{
    handler_opts = {
      border = "none"
    }
  }
  vim.cmd [[autocmd CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()]]
  if vim.bo.filetype == 'rust' then
    vim.cmd('autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer> ' ..
            'lua require"lsp_extensions".inlay_hints{ prefix = " » ", highlight = "NonText", ' ..
            'aligned = true, enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }')
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
      path = vim.split(package.path, ';'),
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
    lspconfig[ls].setup{
      on_attach = on_attach,
      cmd = ls_cmd,
      settings = passed_settings,
    }
  elseif backup and backup_cmd and util.has_bins(backup_cmd[1]) then
    lspconfig[backup].setup{
      on_attach = on_attach,
      cmd = backup_cmd,
      settings = passed_settings,
    }
  end
end

setup_ls("als", "ada_language_server")
setup_ls("bashls", { "bash-language-server", "start" })
setup_ls("clangd", { "clangd", "--background-index", "--header-insertion=never" })
setup_ls("cmake", "cmake-language-server")
setup_ls("cssls", { "css-languageserver", "--stdio" })
setup_ls("dockerls", { "docker-langserver", "--stdio" })
setup_ls("elixirls", "elixir-ls")
setup_ls("flow", {"npm", "run", "flow", "lsp"})
setup_ls("fortls", "fortls")
setup_ls("gopls", "gopls")
setup_ls("html", { "html-languageserver", "--stdio" })
setup_ls("jsonls", { "vscode-json-languageserver", "--stdio" })
setup_ls("kotlin_language_server", "kotlin-language-server")
setup_ls("metals", "metals")
-- setup_ls("pyright", { "pyright-langserver", "--stdio" }, "pyls", "pyls")
setup_ls("r_language_server", { "R", "--slave", "-e", "languageserver::run()" })
setup_ls("rust_analyzer", "rust-analyzer", "rls", "rls")
setup_ls("solargraph", { "solargraph", "stdio" })
setup_ls("sumneko_lua", "lua-language-server", nil, nil, lua_settings)
setup_ls("sqlls", "sql-language-server")
setup_ls("texlab", "texlab")
setup_ls("tsserver", { "typescript-language-server", "--stdio" })
setup_ls("vimls", { "vim-language-server", "--stdio" })
setup_ls("yamlls", { "yaml-language-server", "--stdio" })

lspconfig.pyright.setup{
  on_attach = on_attach,
  root_dir = function() return vim.loop.cwd() end,
}

if util.has_bins('diagnostic-languageserver') then
  lspconfig.diagnosticls.setup{
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
              security = 3
            }
          },
          securities = {
            error = "error",
            warning = "warning",
          }
        },
      }
    }
  }
end
