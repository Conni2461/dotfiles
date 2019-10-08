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

	Plug 'junegunn/fzf.vim'
	Plug 'liuchengxu/vim-clap'

	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'RRethy/vim-illuminate'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'dense-analysis/ale'
	Plug 'SevereOverfl0w/deoplete-github'

	Plug 'rhysd/vim-grammarous'

	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'maximbaz/lightline-ale'

	Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	call plug#end()

" Some Basics
	let mapleader = " "

	imap jk <Esc>

	set bg=light
	set mouse=a
	set nohlsearch
	set smartcase
	set clipboard=unnamedplus
	set noshowmode
	set showtabline=0
	set scrolloff=2

	set nocompatible
	set cmdheight=2
	set updatetime=300
	set shortmess+=c
	set signcolumn=yes

	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set cursorline

	command! Vimrc :vs $MYVIMRC

" Nvim specifics
	" Shows realtime changes with :s/
	set inccommand=nosplit

" Sandwich! :w!! to save with sudo
	ca w!! w !sudo tee >/dev/null "%"

" History
	set history=10000
	set undofile
	set undodir=~/.local/share/nvim/undo
	set undolevels=1000
	set undoreload=10000
	set backupdir=~/.local/share/nvim/backup/
	set directory=~/.local/share/nvim/backup/

" Buffer Setup
	"set hidden
	nnoremap <leader>n  :enew<CR>
	nnoremap <leader>h  :bprevious<CR>
	nnoremap <leader>l  :bnext<CR>
	nnoremap <leader>bq :bd<CR>
	nnoremap <leader>bl :ls<CR>

" Tabs and spaces
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
	set listchars=tab:\¦\ " Required comment
	set list
	let s:defaultList=1
	nnoremap <leader>r :%retab!<CR>

	function ToggleListchars()
		if s:defaultList
			set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
			let s:defaultList=0
		else
			set listchars=tab:\¦\ " Required comment
			let s:defaultList=1
		endif
	endfunction
	nnoremap <leader>m :call ToggleListchars()<CR>

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
	nnoremap s "_d

" Tab jumping
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
	command! MakeTags !ctags -R .

" Disable automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spellcheck set to <leader>e for English and <leader>d for German
	nmap <leader>e :setlocal spell! spelllang=en_us<CR>
	nmap <leader>d :setlocal spell! spelllang=de_de<CR>

" Splits open at the bottom and right
	set splitbelow splitright

" Shortcuts split navigation:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Compile document, be it groff/LaTeX/markdown/etc.
	nmap <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	nmap <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
	let g:vimwiki_list = [{'path': '~/docs/shared/vimwiki/'}]
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.h set filetype=c

" Enable Goyo by default for mutt writing
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* :call lightline#init()
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespaces on save
	autocmd BufWritePre * %s/\s\+$//e

" Post Save Commands
	autocmd BufWritePost * silent! execute "!notify-send 'File <afile> saved'" | redraw!
	autocmd BufWritePost * silent! execute "!syncfile %:p" | redraw!

" lightline configuration
	set laststatus=2

	let g:lightline#bufferline#filename_modifier = ':t'
	let g:lightline#bufferline#read_only=''
	let g:lightline#bufferline#show_number=1

	let g:lightline#ale#indicator_checking = "\uf110"
	let g:lightline#ale#indicator_warnings = "\uf071"
	let g:lightline#ale#indicator_errors = "\uf05e"
	let g:lightline#ale#indicator_ok = "\uf00c"

	let g:lightline = {
		\'active': {
			\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers']],
			\'right': [['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
		\},
		\'component_expand': {
			\'linter_checking': 'lightline#ale#checking',
			\'linter_warnings': 'lightline#ale#warnings',
			\'linter_errors': 'lightline#ale#errors',
			\'linter_ok': 'lightline#ale#ok',
			\'buffers': 'lightline#bufferline#buffers',
		\},
		\'component_type': {
			\'linter_checking': 'left',
			\'linter_warnings': 'warning',
			\'linter_errors': 'error',
			\'linter_ok': 'left',
			\'buffers': 'tabsel',
		\},
		\'component_function': {
			\'gitbranch': 'fugitive#head',
		\}
	\}

" ALE
	let g:ale_linters = {
	\   'c': ['clangd'],
	\   'cpp': ['clangd'],
	\   'python': ['pylint'],
	\   'sh': ['shellcheck'],
	\   'tex': ['lacheck'],
	\   'vim': ['vint'],
	\}

	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_insert_leave = 0
	let g:ale_lint_on_enter = 0

	let g:ale_open_list = 0

	function ToggleErrors()
		if g:ale_open_list
			let g:ale_open_list = 0
			lclose
		else
			let g:ale_open_list = 1
			ALELint
			wincmd j
		endif
	endfunction
	nmap <leader>s :call ToggleErrors()<CR>

" Enable deoplete by default
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#enable_refresh_always = 1
	let g:deoplete#sources = {}
	call deoplete#custom#option('sources', {
	\ '_': ['ale'],
	\})

" Deoplete setup for github extension
	let g:deoplete#sources.gitcommit=['github']
	let g:deoplete#keyword_patterns = {}
	let g:deoplete#keyword_patterns.gitcommit = '[^ \t]+'
	call deoplete#custom#var('omni', 'input_patterns', {'github': '[^ \t]+'})

" LanguageTool
	let g:grammarous#use_vim_spelllang = 1
	let g:grammarous#languagetool_cmd = 'languagetool'

	nmap <leader>ls :GrammarousCheck<CR>
	nmap <leader>lo <Plug>(grammarous-open-info-window)<CR>
	nmap <leader>lc <Plug>(grammarous-close-info-window)<CR>
	nmap <leader>ll <Plug>(grammarous-move-to-next-error)<CR>
	nmap <leader>lh <Plug>(grammarous-move-to-previous-error)<CR>

" Tagbar
	nmap <leader>o :TagbarToggle<CR>

" fuzzy search
	nmap <leader>q :GFiles<CR>
	nmap <leader>Q :Files<CR>

	nmap <leader>B :Buffers<CR>
	nmap <leader>H :History<CR>

	nmap <leader>t :Btags<CR>
	nmap <leader>T :Tags<CR>

	nmap <leader>' :Marks<CR>

" Limelight setup
	let g:limelight_conceal_ctermfg=240

" Goyo plugin makes text more readable when writing
	function! s:goyo_enter()
		Limelight
		set bg=light
		call ApplyColors()
		set linebreak
		set nocursorline
		set nolist
	endfunction

	function! s:goyo_leave()
		Limelight!
		set bg=light
		call ApplyColors()
		set nolinebreak
		set cursorline
		set list
	endfunction

	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()

	nmap <leader>f :Goyo<CR>

" Undotree shortcut
	nnoremap <leader>u :UndotreeToggle<CR>

" Snippets
	runtime snippets/latex.vim
	runtime snippets/bib.vim
	runtime snippets/markdown.vim
	runtime snippets/c.vim
