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

	Plug 'dstein64/vim-startuptime'

	Plug 'kshenoy/vim-signature'

	Plug 'psliwka/vim-smoothie'

	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'
	Plug 'rhysd/git-messenger.vim'
	Plug 'rhysd/committia.vim'

	Plug 'gisphm/vim-gitignore'

	Plug 'dhruvasagar/vim-table-mode'
	Plug 'gyim/vim-boxdraw'

	Plug 'AndrewRadev/splitjoin.vim'

	Plug 'rhysd/clever-f.vim'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-scriptease'
	Plug 'cometsong/CommentFrame.vim'
	Plug 'godlygeek/tabular'

	Plug 'rafcamlet/nvim-luapad'

" Plugins that have configfiles in ~/.config/nvim/plugins.d/
	Plug 'mhinz/vim-startify'

	Plug 'farmergreg/vim-lastplace'

	Plug 'camspiers/animate.vim'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/telescope.nvim'

	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'

	Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }

	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'nvim-treesitter/nvim-treesitter-refactor'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'nvim-treesitter/playground'
	Plug 'romgrk/nvim-treesitter-context'

	Plug 'neovim/nvim-lspconfig'
	Plug 'norcalli/snippets.nvim'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-lua/diagnostic-nvim'
	Plug 'nvim-lua/lsp_extensions.nvim'
	Plug 'steelsojka/completion-buffers'


	Plug 'itchyny/lightline.vim'
	Plug 'kyazdani42/nvim-web-devicons'

	Plug 'norcalli/nvim-colorizer.lua'
	call plug#end()
