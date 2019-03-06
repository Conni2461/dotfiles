" Plugin
	call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-fugitive'		" A Git wrapper so awesome, it should be illegal
	Plug 'scrooloose/syntastic'		" Syntax checking hacks for vim
	Plug 'junegunn/goyo.vim'		" writing mode use <leader>f
	Plug '/usr/bin/fzf'			" adding installed fzf package
	Plug 'junegunn/fzf.vim'			" fzf vim plugin
	Plug 'vimwiki/vimwiki'			" vimwiki
	Plug 'tpope/vim-commentary'		" Comment out line with gcc and in visual mode with gc
	Plug 'itchyny/lightline.vim'		" Statusline replacement
	Plug 'scrooloose/nerdtree'		" Folder
	Plug 'editorconfig/editorconfig-vim'	" Editorconfig
	Plug 'gisphm/vim-gitignore'		" gitignore support
	Plug 'terryma/vim-multiple-cursors'	" Multiple cursor support
	Plug 'Valloric/YouCompleteMe'		" Codecompletion for c
	call plug#end()

" Some Basics
	let mapleader = " "

	set bg=light
	set mouse=a
	set nohlsearch
	set clipboard=unnamedplus

	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

" Disable ex mode
	map q: <Nop>
	nnoremap Q <Nop>

" Copy paste with primary clipboard
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable autocompletion:
	set wildmode=longest,list,full

" Disable automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nerdtree plugin map
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF plugin: fuzzy search
	map <leader>q :Files<CR>

" Goyo plugin makes text more readable when writing:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

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

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespaces on save
	autocmd BufWritePre * %s/\s\+$//e

" Post Save Commands
	autocmd BufWritePost * silent! execute "!notify-send 'File <afile> saved'" | redraw!
	autocmd BufWritePost * silent! execute "!syncfile %:p" | redraw!
	autocmd BufWritePost ~/.dmenu.config.h,~/.dwm.config.h,~/.st.config.h,~/.surf.config.h !sucklessbuild %:p

" lightline configuration
	set laststatus=2
	let g:lightline = {
	\     'active': {
	\         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
	\         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
	\     }
	\ }

" Snippets
""LATEX
	" Word count:
	autocmd FileType tex map <leader><leader>o :w !detex \| wc -w<CR>
	" Code snippets
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

