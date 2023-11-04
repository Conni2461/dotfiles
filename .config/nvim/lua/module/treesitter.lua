local ts = require "nvim-treesitter.configs"
local parsers = require "nvim-treesitter.parsers"

vim.treesitter.query.set("lua", "folds", "")
vim.treesitter.query.set("lua", "indents", "")

ts.setup {
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<cr>",
      node_decremental = "<tab>",
      scope_incremental = "<s-cr>",
    },
  },
  indent = { enable = false },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = { enable = false },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
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
      set_jumps = true, -- whether to set jumps in the jumplist
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
    persist_queries = false,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "c_sharp",
    "clojure",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "fennel",
    "glimmer",
    "go",
    "gomod",
    "graphql",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "latex",
    "nix",
    "php",
    "python",
    "ql",
    "query",
    "r",
    "regex",
    "rst",
    "ruby",
    "rust",
    "svelte",
    "toml",
    "typescript",
    "yaml",
  },
}

local configs = parsers.get_parser_configs()
local treesitter_group = vim.api.nvim_create_augroup("custom_treesitter_stuff", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  pattern = table.concat(
    vim.tbl_map(function(ft)
      return configs[ft].filetype or ft
    end, parsers.available_parsers()),
    ","
  ),
  command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
  group = treesitter_group,
})
