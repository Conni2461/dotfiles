local ts = require "nvim-treesitter.configs"

-- vim.treesitter.query.set("lua", "folds", "")
-- vim.treesitter.query.set("lua", "indents", "")

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
    "diff",
    "dockerfile",
    "doxygen",
    "fennel",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "glimmer",
    "go",
    "gomod",
    "gosum",
    "graphql",
    "html",
    "htmldjango",
    "http",
    "ini",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "julia",
    "kotlin",
    "latex",
    "make",
    "nix",
    "php",
    "proto",
    "python",
    "ql",
    "query",
    "r",
    "regex",
    "requirements",
    "ruby",
    "rust",
    "sql",
    "ssh_config",
    "strace",
    "svelte",
    "terraform",
    "toml",
    "tsx",
    "twig",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
    "zig",
  },
}

vim.wo.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false
