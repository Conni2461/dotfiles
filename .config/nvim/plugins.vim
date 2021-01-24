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

	Plug 'psliwka/vim-smoothie'

	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'
	Plug 'rhysd/git-messenger.vim'
	Plug 'rhysd/committia.vim'

	Plug 'gisphm/vim-gitignore'

	Plug 'rhysd/clever-f.vim'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-scriptease'
	Plug 'godlygeek/tabular'

	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'pwntester/octo.nvim'

	Plug 'tami5/sql.nvim'

" Plugins that have configfiles in ~/.config/nvim/plugins.d/
	Plug 'mhinz/vim-startify'

	Plug 'farmergreg/vim-lastplace'

	Plug 'camspiers/animate.vim'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'
	Plug 'nvim-telescope/telescope-dap.nvim'
	Plug 'nvim-telescope/telescope-symbols.nvim'
	Plug 'nvim-telescope/telescope-cheat.nvim'
	Plug 'nvim-telescope/telescope-frecency.nvim'

	Plug 'tami5/lispdocs.nvim'

	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'

	Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }

	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'nvim-treesitter/nvim-treesitter-refactor'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'nvim-treesitter/playground'

	Plug 'neovim/nvim-lspconfig'
	Plug 'norcalli/snippets.nvim'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-lua/lsp_extensions.nvim'
	Plug 'steelsojka/completion-buffers'

	Plug 'mfussenegger/nvim-dap'
	Plug 'theHamsta/nvim-dap-virtual-text'

	Plug 'itchyny/lightline.vim'

	Plug 'norcalli/nvim-colorizer.lua'
	call plug#end()

let g:lispdocs_mappings = 0
