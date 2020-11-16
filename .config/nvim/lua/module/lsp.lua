local lspconfig = require'lspconfig'
local util      = require'lspconfig/util'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet'}},
    {complete_items = {'path'}, triggered_only = {'./', '/'}},
    {complete_items = {'buffers'}},
  },
  string = {
    {complete_items = {'path'}, triggered_only = {'./', '/'}},
    {complete_items = {'buffers'}},
  },
  comment = {},
}

local bytemarkers = { {0x7FF, 192}, {0xFFFF, 224}, {0x1FFFFF, 240} }
local function utf8(decimal)
  if decimal < 128 then
    return string.char(decimal)
  end
  local charbytes = {}
  for bytes,vals in ipairs(bytemarkers) do
    if decimal <= vals[1] then
      for b = bytes + 1, 2, -1 do
        local mod = decimal % 64
        decimal = (decimal - mod) / 64
        charbytes[b] = string.char(128 + mod)
      end
      charbytes[1] = string.char(vals[2] + decimal)
      break
    end
  end
  return table.concat(charbytes)
end

local customize_lsp_label = {
  Method = utf8(0xf794) .. ' [method]',
  Function = utf8(0xf794) .. ' [function]',
  Variable = utf8(0xf6a6) .. ' [variable]',
  Field = utf8(0xf6a6) .. ' [field]',
  Class = utf8(0xfb44) .. ' [class]',
  Struct = utf8(0xfb44) .. ' [struct]',
  Interface = utf8(0xf836) .. ' [interface]',
  Module = utf8(0xf668) .. ' [module]',
  Property = utf8(0xf0ad) .. ' [property]',
  Value = utf8(0xf77a) .. ' [value]',
  Enum = utf8(0xf77a) .. ' [enum]',
  Operator = utf8(0xf055) .. ' [operator]',
  Reference = utf8(0xf838) .. ' [reference]',
  Keyword = utf8(0xf80a) .. ' [keyword]',
  Color = utf8(0xe22b) .. ' [color]',
  Unit = utf8(0xe3ce) .. ' [unit]',
  ["snippets.nvim"] = utf8(0xf68e) .. ' [nsnip]',
  Snippet = utf8(0xf68e) .. ' [snippet]',
  Text = utf8(0xf52b) .. ' [text]',
  Buffers = utf8(0xf64d) .. ' [buffers]',
  TypeParameter = utf8(0xf635) .. ' [type]',
}

local on_attach = function(_, _)
  require'completion'.on_attach({
    chain_complete_list = chain_complete_list,
    customize_lsp_label = customize_lsp_label,
    enable_auto_popup = 1,
    enable_auto_signature = 1,
    auto_change_source = 1,
    enable_auto_hover = 1,
  })
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
  if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
    vim.api.nvim_command('autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer> lua require"lsp_extensions".inlay_hints{ prefix = " » ", highlight = "NonText" }')
  end
end

local cap = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}

local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua"
    if vim.fn.isdirectory(lua_path) == 1 then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand("$VIMRUNTIME/lua")] = true
  return result
end

local lua_settings = {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = {
      enable = true,
      globals = { "vim" },
    },
    workspace = {
      library = get_lua_runtime()
    },
  },
}

local function setup_ls(ls, ls_cmd, backup, backup_cmd, passed_settings)
  local bin, arr
  local backup_bin, backup_arr
  if type(ls_cmd) == "string" then
    bin = ls_cmd
    arr = { ls_cmd }
  else
    bin = ls_cmd[1]
    arr = ls_cmd
  end

  if not (backup_cmd == nil) then
    if type(backup_cmd) == "string" then
      backup_bin = backup_cmd
      backup_arr = { backup_cmd }
    else
      backup_bin = backup_cmd[1]
      backup_arr = backup_cmd
    end
  end

  if util.has_bins(bin) then
    lspconfig[ls].setup{
      on_attach = on_attach,
      cmd = arr,
      capabilities = cap,
      settings = passed_settings,
    }
  else
    if backup ~= nil then
      if backup_bin ~= nil and util.has_bins(backup_bin) then
        lspconfig[backup].setup{
          on_attach = on_attach,
          cmd = backup_arr,
          capabilities = cap,
          settings = passed_settings,
        }
      end
    end
  end
end

setup_ls("als", "ada_language_server")
setup_ls("bashls", { "bash-language-server", "start" })
setup_ls("clangd", { "clangd", "--background-index" })
setup_ls("cmake", "cmake-language-server")
setup_ls("cssls", { "css-languageserver", "--stdio" })
setup_ls("dockerls", { "docker-langserver", "--stdio" })
setup_ls("elixirls", "elixir-ls")
setup_ls("flow", {"npm", "run", "flow", "lsp"})
setup_ls("fortls", "fortls")
setup_ls("gopls", "gopls")
setup_ls("html", { "html-languageserver", "--stdio" })
-- setup_ls("jdtls", { "jdtls" })
setup_ls("jsonls", { "vscode-json-languageserver", "--stdio" })
setup_ls("kotlin_language_server", "kotlin-language-server")
setup_ls("metals", "metals")
setup_ls("pyls_ms", "mspyls", "pyls", "pyls")
setup_ls("r_language_server", { "R", "--slave", "-e", "languageserver::run()" })
setup_ls("rust_analyzer", "rust-analyzer", "rls", "rls")
setup_ls("solargraph", { "solargraph", "stdio" })
setup_ls("sumneko_lua", "lua-language-server", nil, nil, lua_settings)
setup_ls("sqlls", "sql-language-server")
setup_ls("texlab", "texlab")
setup_ls("tsserver", { "typescript-language-server", "--stdio" })
setup_ls("vimls", { "vim-language-server", "--stdio" })

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
