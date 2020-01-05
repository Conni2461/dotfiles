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
	Plug 'junegunn/gv.vim'

	Plug 'gisphm/vim-gitignore'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'ericcurtin/CurtineIncSw.vim'

	Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }

	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'RRethy/vim-illuminate'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'dense-analysis/ale'
	Plug 'SevereOverfl0w/deoplete-github'

	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'maximbaz/lightline-ale'

	Plug 'liuchengxu/vista.vim'
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	call plug#end()

" Some Basics
	let mapleader = ' '

	imap jk <Esc>

	set background=light
	set mouse=a
	set hlsearch
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

	set colorcolumn=80

	set conceallevel=0

	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set cursorline

	command! Vimrc :vs $MYVIMRC
	augroup reload
		au!
		au BufWritePost $MYVIMRC source $MYVIMRC
	augroup END

	nnoremap <leader>r :source $MYVIMRC<CR> \| normal zR

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
	nnoremap <leader>bn :enew<CR>
	nnoremap <leader>bh :bprevious<CR>
	nnoremap <leader>bl :bnext<CR>
	nnoremap <leader>bq :bd<CR>
	" <leader>bg opens Clap buffers

" Tabs and spaces
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
	set listchars=tab:\¦\ " Required comment
	set list
	let s:defaultList=1
	nnoremap <leader>vr :%retab!<CR>

	function ToggleListchars()
		if s:defaultList
			set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
			let s:defaultList=0
		else
			set listchars=tab:\¦\ " Required comment
			let s:defaultList=1
		endif
	endfunction
	nnoremap <leader>vh :call ToggleListchars()<CR>

	augroup SplitsSize
		au!
		au VimResized * execute "normal! \<c-w>="
	augroup END

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
		hi ColorColumn  cterm=none ctermfg=none ctermbg=237

		" Fix hlsearch coloring
		hi Search ctermfg=234 cterm=bold

		" Split Delimiter
		hi VertSplit cterm=none

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

		" Fix tooltip and Clap
		hi Pmenu ctermfg=255 ctermbg=238

		" Fix Git Gutter
		hi GitGutterAdd    ctermfg=2
		hi GitGutterChange ctermfg=3
		hi GitGutterDelete ctermfg=1
	endfunction
	call ApplyColors()

" Folding setup
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
	" source: gist.github.com/sjl/3360978
	function! MyFoldText()
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
		return line . '…' . repeat(' ',fillcharcount) . foldedlinecount . '…' . ' '
	endfunction
	set foldtext=MyFoldText()
	nnoremap <s-tab> za

" Disable ex mode
	map q: <Nop>
	nnoremap Q <Nop>

" Disbale recording
	map q <Nop>

" Exit insert, dd line, enter insert
	inoremap <C-d> <esc>ddi

" Split Lines (Merge line by default with J)
	nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>

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
	nnoremap <C-Up> :m .-2<CR>
	nnoremap <C-Down> :m  .+1<CR>

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
	augroup commenting
		au!
		au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	augroup END

" Spellcheck
	nnoremap <leader>se :setlocal spell! spelllang=en_us<CR>
	nnoremap <leader>sd :setlocal spell! spelllang=de_de<CR>
	nnoremap <leader>sf :setlocal spell! spelllang=en_us,de_de<CR>

" Splits open at the bottom and right
	set splitbelow splitright

" Shortcuts split navigation:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Compile document, be it groff/LaTeX/markdown/etc.
	nnoremap <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	nnoremap <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
	augroup files
		au!
		au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
		au BufRead,BufNewFile *.tex set filetype=tex
		au BufRead,BufNewFile *.h set filetype=c
	augroup END

" Enable Goyo by default for mutt writing
	" Goyo's width will be the line limit in mutt.
	augroup mutt
		au!
		au BufRead,BufNewFile /tmp/neomutt* Vista!
		au BufRead,BufNewFile /tmp/neomutt* :call lightline#init()
		au BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
		au BufRead,BufNewFile /tmp/neomutt* Goyo
	augroup END


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
			\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers'], ['method']],
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
			\'method': 'NearestMethodOrFunction',
		\}
	\}


" ALE
	let g:ale_linters = {
	\   'c': ['cquery'],
	\   'cpp': ['cquery'],
	\   'python': ['pyls'],
	\   'sh': ['shellcheck'],
	\   'tex': ['lacheck'],
	\   'vim': ['vint'],
	\}

	let g:ale_fixers = {
	\   '*': ['remove_trailing_lines', 'trim_whitespace'],
	\}

	function FixBuffer()
		let b:ale_fixers = { 'c': ['clang-format'], 'cpp': ['clang-format'] }
		ALEFix
		let b:ale_fixers = {}
	endfunction

	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_insert_leave = 1
	let g:ale_lint_on_enter = 1
	let g:ale_fix_on_save = 1

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
	nnoremap <leader>ae :call ToggleErrors()<CR>
	nnoremap <leader>af :call FixBuffer()<CR>

	nnoremap <leader>ad :ALEGoToDefinition<CR>
	nnoremap <leader>at :ALEGoToTypeDefinition<CR>
	nnoremap <leader>ar :ALEFindReferences<CR>
	nnoremap <leader>ah :ALEHover<CR>
	nnoremap <leader>as :ALESymbolSearch<CR>

	augroup DISABLE
		au!
		au BufRead,BufNewFile *.md ALEDisableBuffer
	augroup END

" CurtineIncSw
	nnoremap <leader>m :call CurtineIncSw()<CR>

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

" Vista
	nnoremap <leader>o :Vista!!<CR>
	let g:vista_default_executive = 'ctags'

	function! NearestMethodOrFunction() abort
		return get(b:, 'vista_nearest_method_or_function', '')
	endfunction

	augroup vista
		au!
		au VimEnter * call vista#RunForNearestMethodOrFunction()
	augroup END

" Clap search
	nnoremap <leader>q  :Clap files<CR>
	nnoremap <leader>bg :Clap buffers<CR>
	nnoremap <leader>g  :Clap grep<CR>
	nnoremap <leader>t  :Clap tags<CR>
	nnoremap <leader>'  :Clap marks<CR>

	function! s:ReadBib(...)
		let l:input = join(a:000)
		let l:command = "echo '" . l:input . "' | cut -d':' -f 1"
		let l:file = system(l:command)

		execute 'read !loadbib -g' l:file
	endfunction

	command! -nargs=* ReadBib call s:ReadBib(<f-args>)

	" Own Clap provider
	let g:clap_provider_quick_open = {
		\ 'source': ['~/.aliasrc', '~/.functionrc', '~/.bashrc', '~/.profile', '~/.gitconfig', '~/.config/nvim/init.vim', '~/.tmux.conf'],
		\ 'sink': 'e',
		\ }

	let g:clap_provider_load_bib = {
		\ 'source': 'loadbib -l',
		\ 'sink': 'ReadBib',
		\ }

	nnoremap <leader>xo  :Clap quick_open<CR>
	nnoremap <leader>xb  :Clap load_bib<CR>

" Limelight setup
	let g:limelight_conceal_ctermfg=240

" Goyo plugin makes text more readable when writing
	function! ToggleGoyo()
		Vista!
		Goyo
	endfunction

	function! s:goyo_enter()
		Limelight
		set background=light
		call ApplyColors()
		set linebreak
		set nocursorline
		set nolist
	endfunction

	function! s:goyo_leave()
		Limelight!
		set background=light
		call ApplyColors()
		set nolinebreak
		set cursorline
		set list
	endfunction

	au! User GoyoEnter nested call <SID>goyo_enter()
	au! User GoyoLeave nested call <SID>goyo_leave()

	nnoremap <leader>f :call ToggleGoyo()<CR>

" Vimwiki setup
	let g:vimwiki_list = [{'path': '~/Nextcloud/docs/vimwiki/'}]
	let g:vimwiki_conceallevel=0

" Undotree shortcut
	nnoremap <leader>u :UndotreeToggle<CR>


" Snippets
" Snippet navigation
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	nnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l

" Load Snippets
	runtime snippets/latex.vim
	runtime snippets/bib.vim
	runtime snippets/markdown.vim
	runtime snippets/c.vim
