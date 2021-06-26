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
  Plug 'norcalli/nvim-base16.lua'

  Plug 'kshenoy/vim-signature'

  Plug 'rhysd/git-messenger.vim'
  Plug 'gisphm/vim-gitignore'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-scriptease'
  Plug 'godlygeek/tabular'

  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'tami5/sql.nvim'

" Plugins that have configfiles in ~/.config/nvim/plugins.d/
  Plug 'mhinz/vim-startify'
  Plug 'farmergreg/vim-lastplace'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-symbols.nvim'
  Plug 'nvim-telescope/telescope-frecency.nvim'
  Plug 'pwntester/octo.nvim'

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'junegunn/goyo.vim'
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'nvim-treesitter/playground'
  Plug 'tjdevries/tree-sitter-lua'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'norcalli/snippets.nvim'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'kosayoda/nvim-lightbulb'

  Plug 'mfussenegger/nvim-dap'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'jbyuki/one-small-step-for-vimkind'

  Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
