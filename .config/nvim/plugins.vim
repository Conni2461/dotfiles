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

	Plug 'yuttie/comfortable-motion.vim'

	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'airblade/vim-gitgutter'
	Plug 'rhysd/git-messenger.vim'

	Plug 'gisphm/vim-gitignore'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'octol/vim-cpp-enhanced-highlight'

	Plug 'rhysd/clever-f.vim'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'cometsong/CommentFrame.vim'
	Plug 'RRethy/vim-illuminate'

	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'ap/vim-css-color'

" Plugins that are neater in their own file
	for f in split(glob('~/.config/nvim/plugins.d/*.vim'), '\n')
		exe 'source' f
	endfor
	call plug#end()

" Evaluate post load plugin code (calling plugin functions etc)
	for f in split(glob('~/.config/nvim/plugins.post.d/*.vim'), '\n')
		exe 'source' f
	endfor
