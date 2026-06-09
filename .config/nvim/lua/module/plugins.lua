local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme "gruvbox"
    end,
  },
  { "projekt0n/github-nvim-theme" },
  { "catppuccin/nvim" },
  { "folke/tokyonight.nvim" },

  "kshenoy/vim-signature",

  "rhysd/git-messenger.vim",
  "tpope/vim-fugitive",

  "tpope/vim-scriptease",

  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        override_by_extension = {
          ["toml"] = {
            icon = "",
            color = "#6d8086",
            cterm_color = "66",
            name = "Toml",
          },
          ["tpp"] = {
            icon = "",
            color = "#8810b0",
            cterm_color = "53",
            name = "Tpp",
          },
        },
      }
    end,
  },

  {
    "mhinz/vim-startify",
    config = function()
      require "module.startify"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  { "nvim-lua/plenary.nvim", dev = true },
  { "nvim-telescope/telescope.nvim", dev = true },
  { "nvim-telescope/telescope-fzf-native.nvim", dev = true },
  "nvim-telescope/telescope-symbols.nvim",
  { "nvim-telescope/telescope-ui-select.nvim", dev = true },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim" },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib" },
    build = function()
      require("blink.cmp").build():pwait()
    end,
    config = false,
  },
  "nvimtools/none-ls.nvim",

  {
    "catgoose/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nickjvandyke/opencode.nvim",
    config = function()
      require "module.opencode"
    end,
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     interactions = {
  --       chat = { adapter = "opencode" },
  --       inline = { adapter = "opencode" },
  --       cli = {
  --         agent = "opencode",
  --         agents = {
  --           opencode = {
  --             cmd = "opencode",
  --             args = {},
  --             description = "Opencode CLI",
  --             provider = "terminal",
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end,
  },
}, {
  dev = {
    path = "~/plugins",
  },
})
