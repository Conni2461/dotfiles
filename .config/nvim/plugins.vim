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
	Plug 'kshenoy/vim-signature'

	Plug 'psliwka/vim-smoothie'

	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'mhinz/vim-signify'
	Plug 'rhysd/git-messenger.vim'
	Plug 'rhysd/committia.vim'

	Plug 'gisphm/vim-gitignore'

	Plug 'rhysd/clever-f.vim'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'cometsong/CommentFrame.vim'

	Plug 'ap/vim-css-color'

" Plugins that have configfiles in ~/.config/nvim/plugins.d/
" Config files will be loaded after lua .init
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
	Plug 'nvim-treesitter/playground'
	Plug 'vigoux/treesitter-context.nvim'

	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-lua/diagnostic-nvim'
	Plug 'steelsojka/completion-buffers'
	Plug 'ncm2/float-preview.nvim'

	Plug 'Olical/conjure'

	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'kyazdani42/nvim-web-devicons'

	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

	Plug 'kyazdani42/nvim-tree.lua', { 'on': 'LuaTreeToggle' }


	call plug#end()
