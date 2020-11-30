local ts = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'

ts.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  indent = {
    enable = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      }
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      }
    }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["ie"] = "@block.inner",
        ["ae"] = "@block.outer",
        ["im"] = "@call.inner",
        ["am"] = "@call.outer",
        ["iC"] = "@class.inner",
        ["aC"] = "@class.outer",
        ["ad"] = "@comment.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["is"] = "@parameter.inner",
        ["as"] = "@statement.outer",
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false
  },
  ensure_installed = { -- one of 'all', 'language' or a list of languages
    'bash',
    'c',
    'cpp',
    'css',
    'c_sharp',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'python',
    'regex',
    'rst',
    'ruby',
    'rust',
    'teal',
    'toml',
    'typescript',
  }
}

local configs = parsers.get_parser_configs()
local ft_str = table.concat(vim.tbl_map(function(ft) return configs[ft].filetype or ft end, parsers.available_parsers()), ',')
vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')

vim.cmd('autocmd VimEnter * TSContextDisable')
