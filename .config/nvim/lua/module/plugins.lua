local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
end

require("packer").startup(function(use)
  local local_use = function(v, opts)
    opts = vim.F.if_nil(opts, {})

    if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. v)) == 1 then
      opts[1] = "~/plugins/" .. v
    else
      print("~/plugins/" .. v .. " does not exist")
      return
    end
    use(opts)
  end

  use "wbthomason/packer.nvim"
  use "morhetz/gruvbox"

  use "kshenoy/vim-signature"

  use "rhysd/git-messenger.vim"
  use "gisphm/vim-gitignore"

  use {
    "numToStr/Comment.nvim",
    config = function()
      require "module.comment"
    end,
  }
  use "tpope/vim-scriptease"
  use "godlygeek/tabular"

  use "kyazdani42/nvim-web-devicons"

  -- use 'tami5/sql.nvim'

  use {
    "mhinz/vim-startify",
    config = function()
      require "module.startify"
    end,
  }

  local_use "plenary.nvim"
  local_use "telescope.nvim"
  local_use "telescope-fzf-native.nvim"
  use "nvim-telescope/telescope-symbols.nvim"
  local_use "telescope-ui-select.nvim"
  -- use 'nvim-telescope/telescope-frecency.nvim'
  -- use 'nvim-telescope/telescope-smart-history.nvim'

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  }

  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  }

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/nvim-treesitter-refactor"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/playground"
  local_use "tree-sitter-lua"

  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "kosayoda/nvim-lightbulb"
  use "j-hui/fidget.nvim"

  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"

  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }
end)
