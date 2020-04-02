" Some Basics
	imap jk <Esc>

	set background=light
	set mouse=a
	set hlsearch
	set smartcase
	set clipboard=unnamedplus
	set noshowmode
	set showtabline=0
	set scrolloff=2

	set cmdheight=1
	set updatetime=300
	set shortmess+=c
	set signcolumn=yes

	set colorcolumn=80

	set conceallevel=0

	filetype plugin indent on
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

" Remove Trailing Whitespaces
	function! TrimTrailingLines()
		let lastLine = line('$')
		let lastNonblankLine = prevnonblank(lastLine)
		if lastLine > 0 && lastNonblankLine != lastLine
			silent! execute lastNonblankLine + 1 . ',$delete _'
		endif
	endfunction
	augroup remove
		au!
		au BufWritePre * %s/\s\+$//e
		au BufWritePre * call TrimTrailingLines()
	augroup END

" Nvim specifics
	" Shows realtime changes with :s/
	if has('nvim')
		set inccommand=nosplit
	endif

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

	function! ToggleListchars()
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

"" Vmap for maintain Visual Mode after shifting > and <
	vmap < <gv
	vmap > >gv

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
	nnoremap <leader>le :setlocal spell! spelllang=en_us<CR>
	nnoremap <leader>ld :setlocal spell! spelllang=de_de<CR>
	nnoremap <leader>lf :setlocal spell! spelllang=en_us,de_de<CR>

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
