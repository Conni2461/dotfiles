local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme "gruvbox"
    end,
  },

  "kshenoy/vim-signature",

  "rhysd/git-messenger.vim",
  "gisphm/vim-gitignore",

  {
    "numToStr/Comment.nvim",
    config = function()
      require "module.comment"
    end,
  },
  "tpope/vim-scriptease",

  "kyazdani42/nvim-web-devicons",

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

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  },

  { "nvim-lua/plenary.nvim", dev = true },
  { "nvim-telescope/telescope.nvim", dev = true },
  { "nvim-telescope/telescope-fzf-native.nvim", dev = true },
  "nvim-telescope/telescope-symbols.nvim",
  { "nvim-telescope/telescope-ui-select.nvim", dev = true },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/playground",
      { "tjdevries/tree-sitter-lua", dev = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {}, tag = "legacy" },
      "kosayoda/nvim-lightbulb",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}, {
  dev = {
    path = "~/plugins",
  },
})
