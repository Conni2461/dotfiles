" Install vimplug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo 'Downloading junegunn/vim-plug to manage plugins...'
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  augroup plug
    au!
    au VimEnter * PlugInstall
  augroup END
endif

" Plugin
call plug#begin('~/.config/nvim/plugged')
  Plug 'morhetz/gruvbox'

  Plug 'kshenoy/vim-signature'

  Plug 'rhysd/git-messenger.vim'
  Plug 'gisphm/vim-gitignore'

  Plug 'numToStr/Comment.nvim'
  Plug 'tpope/vim-scriptease'
  Plug 'godlygeek/tabular'

  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'tami5/sql.nvim'

" Plugins that have configfiles in ~/.config/nvim/plugins.d/
  Plug 'mhinz/vim-startify'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-symbols.nvim'
  Plug 'nvim-telescope/telescope-frecency.nvim'
  Plug 'nvim-telescope/telescope-smart-history.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'pwntester/octo.nvim'

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'rcarriga/nvim-notify'

  Plug 'junegunn/goyo.vim'
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/playground'
  Plug 'tjdevries/tree-sitter-lua'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'L3MON4D3/LuaSnip'

  Plug 'mfussenegger/nvim-dap'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'jbyuki/one-small-step-for-vimkind'

  Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

let g:loaded_gzip         = 1
let g:loaded_tar          = 1
let g:loaded_tarPlugin    = 1
let g:loaded_zipPlugin    = 1
let g:loaded_2html_plugin = 1
let g:loaded_netrw        = 1
let g:loaded_netrwPlugin  = 1
let g:loaded_matchit      = 1
let g:loaded_spec         = 1
