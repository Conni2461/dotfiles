" Plugin
	call plug#begin('~/.config/nvim/plugged')
	Plug 'yuttie/comfortable-motion.vim'                            " Smooth Scrolling

	Plug 'tpope/vim-fugitive'                                       " A Git wrapper so awesome, it should be illegal
	Plug 'tpope/vim-rhubarb'                                        " Github extension for fugitive
	Plug 'airblade/vim-gitgutter'                                   " Shows git diff in 'gutter' (sign column)

	Plug 'gisphm/vim-gitignore'                                     " gitignore support
	Plug 'PotatoesMaster/i3-vim-syntax'                             " i3 support
	Plug 'godlygeek/tabular'                                        " Align plugin
	Plug 'plasticboy/vim-markdown'                                  " Markdown plugin

	Plug 'junegunn/fzf.vim'                                         " fuzzy findinding vim plugin

	Plug 'junegunn/goyo.vim'                                        " writing mode use <leader>f
	Plug 'junegunn/limelight.vim'                                   " focus mode
	Plug 'vimwiki/vimwiki'                                          " vimwiki
	Plug 'tpope/vim-commentary'                                     " Comment out line with gcc and in visual mode with gc
	Plug 'tpope/vim-surround'                                       " Surround words with anything
	Plug 'RRethy/vim-illuminate'                                    " Highlight same words

	Plug 'itchyny/lightline.vim'                                    " Statusline replacement
	Plug 'mengelbrecht/lightline-bufferline'

	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Folder
	Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }  " Show git status in NerdTree
	Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }       " Icons for NerdTree
	Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }              " Shows tags in right bar
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }              " Tree to show things to undo

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " Autocomplete
	Plug 'zchee/deoplete-clang'                                     " Autocomplete library for C/C++
	Plug 'SevereOverfl0w/deoplete-github'                           " Deoplete github extension

	Plug 'vim-syntastic/syntastic'                                  " Syntax checking
	call plug#end()

" Some Basics
	let mapleader = " "

	set bg=light
	set mouse=a
	set nohlsearch
	set clipboard=unnamedplus
	set noshowmode
	set showtabline=0

	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set cursorline

" History
	set history=10000
	set undofile
	set undodir=~/.local/share/nvim/undo
	set undolevels=1000
	set undoreload=10000
	set backupdir=~/.local/share/nvim/backup/
	set directory=~/.local/share/nvim/backup/

" Tabs and spaces
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
	set listchars=tab:\¦\ " Set default tab charlist to pipe with space at the end
	set list
	let s:defaultList=1
	nnoremap <leader>r :%retab!<CR>

	function ToggleListchars()
		if s:defaultList
			set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
			let s:defaultList=0
		else
			set listchars=tab:\|\ " Set default tab charlist to pipe with space at the end
			let s:defaultList=1
		endif
	endfunction
	nnoremap <leader>l :call ToggleListchars()<CR>

" Apply colors called at the beginning and when toggling goyo
	function ApplyColors()
		" Fix visual mode color
		hi Visual ctermfg=234 ctermbg=252 cterm=none

		" Tabs and Spaces colors
		hi Whitespace cterm=none ctermfg=241 ctermbg=none
		hi NonText    cterm=none ctermfg=241 ctermbg=none

		" Cursor Colors
		hi CursorColumn cterm=none ctermfg=none ctermbg=237
		hi CursorLine   cterm=none ctermfg=none ctermbg=237

		" Fix hlsearch coloring
		hi Search ctermfg=234 cterm=bold

		" Fix vim spellchecking
		hi SpellBad   ctermfg=234 cterm=bold
		hi SpellCap   ctermfg=234 cterm=bold
		hi SpellRare  ctermfg=234 cterm=bold
		hi SpellLocal ctermfg=234 cterm=bold

		" Fix vimdiff colors
		hi DiffAdd    ctermfg=234 cterm=bold
		hi DiffDelete ctermfg=234 cterm=bold
		hi DiffChange ctermfg=234 cterm=bold
		hi DiffText   ctermfg=234 cterm=bold

		" Fix folding color
		hi Folded ctermfg=234 cterm=bold
	endfunction
	call ApplyColors()

" Folding setup
	set foldenable
	set foldmethod=syntax
	set foldlevel=0
	autocmd BufRead * normal zR
	" source: gist.github.com/sjl/3360978
	function! MyFoldText() " {{{
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
		return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
	endfunction " }}}
	set foldtext=MyFoldText()

" Disable ex mode
	map q: <Nop>
	nnoremap Q <Nop>

" Disbale recording
	map q <Nop>

" Exit insert, dd line, enter insert
	inoremap <C-d> <esc>ddi

" Navigate Display Lines
	nnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
	nnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
	vnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
	vnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
	nnoremap <silent><expr> <Up>    v:count == 0 ? 'gk' : 'k'
	nnoremap <silent><expr> <Down>  v:count == 0 ? 'gj' : 'j'
	nnoremap H 0
	nnoremap L $

" Bubble single lines
	nmap <C-Up> :m .-2<CR>
	nmap <C-Down> :m  .+1<CR>

" Bubble multiple lines
	vnoremap <silent> <C-Up>  @='"zxk"zP`[V`]'<CR>
	vnoremap <silent> <C-Down>  @='"zx"zp`[V`]'<CR>

" Copy paste with primary clipboard
	vnoremap <C-c> "+y
	map <C-p> "+p

" Enable autocompletion:
	set wildmode=longest,list,full

" Tab jumping
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
	command! MakeTags !ctags -R .
	nmap <leader>g <C-]>

" Disable automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spellcheck set to <leader>e for English and <leader>d for German
	map <leader>e :setlocal spell! spelllang=en_us<CR>
	map <leader>d :setlocal spell! spelllang=de_de<CR>
	map <leader>b :setlocal spell! spelllang=en_us,de_de<CR>

" Splits open at the bottom and right
	set splitbelow splitright

" Shortcuts split navigation:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in open error window:
	let s:openErrors=0
	function ToggleErrors()
		if s:openErrors
			lclose
			let s:openErrors=0
		else
			Errors
			let s:openErrors=1
		endif
	endfunction
	map <leader>s :call ToggleErrors()<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
	let g:vimwiki_list = [{'path': '~/docs/shared/vimwiki/'}]
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.h set filetype=c

" Enable Goyo by default for mutt writing
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
	autocmd BufRead,BufNewFile /tmp/neomutt* :call ToggleGoyo()

" Automatically deletes all trailing whitespaces on save
	autocmd BufWritePre * %s/\s\+$//e

" Post Save Commands
	autocmd BufWritePost * silent! execute "!notify-send 'File <afile> saved'" | redraw!
	autocmd BufWritePost * silent! execute "!syncfile %:p" | redraw!

" lightline configuration
	set laststatus=2
	let g:lightline#bufferline#read_only=''
	let g:lightline#bufferline#show_number=1
	let g:lightline = {
		\'active': {
			\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers']],
			\'right': [['syntastic', 'lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
		\},
		\'component_expand': {
			\'syntastic': 'SyntasticStatuslineFlag',
			\'buffers': 'lightline#bufferline#buffers',
		\},
		\'component_type': {
			\'syntastic': 'error',
			\'buffers': 'tabsel',
		\},
		\'component_function': {
			\'gitbranch': 'fugitive#head',
		\}
	\}
	function! SyntasticCheckHook(errors)
		call lightline#update()
	endfunction
	autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Syntastic
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 0
	autocmd VimEnter * SyntasticCheck
	let g:syntastic_check_on_wq = 1

" Enable deoplete by default
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources = {}

" Required deoplete clang settings
	let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
	let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'

" Deoplete setup for github extension
	let g:deoplete#sources.gitcommit=['github']
	let g:deoplete#keyword_patterns = {}
	let g:deoplete#keyword_patterns.gitcommit = '[^ \t]+'
	call deoplete#custom#var('omni', 'input_patterns', {'github': '[^ \t]+'})

" Nerdtree plugin map
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tagbar
	nmap <leader>t :TagbarToggle<CR>

" fuzzy search
	map <leader>q :FZF<CR>

" Limelight setup
	let g:limelight_conceal_ctermfg=240

" Goyo plugin makes text more readable when writing
	function ToggleGoyo()
		if exists('#goyo')
			Goyo!
			Limelight!
			set bg=light
			call ApplyColors()
			set nolinebreak
			set cursorline
			set list
		else
			Goyo
			Limelight
			set bg=light
			call ApplyColors()
			set linebreak
			set nocursorline
			set nolist
		endif
	endfunction
	map <leader>f :call ToggleGoyo()<CR>

" Undotree shortcut
	nnoremap <leader>u :UndotreeToggle<CR>

" Tabular shortcuts
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:<CR>
	vmap <Leader>a: :Tabularize /:<CR>

" Snippets
	runtime snippets/latex.vim
	runtime snippets/bib.vim
	runtime snippets/markdown.vim
	runtime snippets/c.vim
