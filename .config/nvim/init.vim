" Plugin
	call plug#begin('~/.config/nvim/plugged')
	Plug 'mhinz/vim-startify'
	Plug 'tpope/vim-obsession'
	Plug 'kshenoy/vim-signature'

	Plug 'yuttie/comfortable-motion.vim'

	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'airblade/vim-gitgutter'
	Plug 'rhysd/git-messenger.vim'

	Plug 'ericcurtin/CurtineIncSw.vim'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'gisphm/vim-gitignore'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'godlygeek/tabular'
	Plug 'plasticboy/vim-markdown'

	Plug 'junegunn/fzf.vim'

	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'RRethy/vim-illuminate'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'

	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
	Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }
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
	nnoremap <leader>bq :bp <BAR> bd # <BAR> call lightline#update()<CR>
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
	nnoremap <leader>v :call ToggleListchars()<CR>

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

" Enable autocompletion:
	set wildmode=longest,list,full

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
	nmap <leader>b :setlocal spell! spelllang=en_us,de_de<CR>

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
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
	autocmd BufRead,BufNewFile /tmp/neomutt* :call ToggleGoyo()

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

	let g:coc_status_error_sign = "\uf071"
	let g:coc_status_warning_sign = "\uf05e"

	function! LightLineCocError()
		let s:error_sign = get(g:, 'coc_status_error_sign')
		let info = get(b:, 'coc_diagnostic_info', {})
		if empty(info)
			return ''
		endif
		let errmsgs = []
		if get(info, 'error', 0)
			call add(errmsgs, s:error_sign . info['error'])
		endif
		return trim(join(errmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
	endfunction

	function! LightLineCocWarn() abort
		let s:warning_sign = get(g:, 'coc_status_warning_sign')
		let info = get(b:, 'coc_diagnostic_info', {})
		if empty(info)
			return ''
		endif
		let warnmsgs = []
		if get(info, 'warning', 0)
			call add(warnmsgs, s:warning_sign . info['warning'])
		endif
		return trim(join(warnmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
	endfunction

autocmd User CocDiagnosticChange call lightline#update()

	let g:lightline = {
		\'active': {
			\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers']],
			\'right': [['lineinfo', 'cocerror', 'cocwarn'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
		\},
		\'component_expand': {
			\'buffers': 'lightline#bufferline#buffers',
			\'cocerror': 'LightLineCocError',
			\'cocwarn': 'LightLineCocWarn',
		\},
		\'component_type': {
			\'buffers': 'tabsel',
		\},
		\'component_function': {
			\'gitbranch': 'fugitive#head',
		\}
	\}

	au User CocDiagnosticChange call lightline#update()

" Coc Setup
	let g:coc_global_extensions =['coc-json', 'coc-python', 'coc-highlight', 'coc-git', 'coc-texlab']
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	inoremap <silent><expr> <c-space> coc#refresh()
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)

	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

" Nerdtree plugin map
	nmap <leader>t :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tagbar
	nmap <leader>o :TagbarToggle<CR>

" fuzzy search
	nmap <leader>q :FZF<CR>

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
	nmap <leader>f :call ToggleGoyo()<CR>

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
