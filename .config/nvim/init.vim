" Plugin
        call plug#begin('~/.config/nvim/plugged')
        Plug 'yuttie/comfortable-motion.vim'                                    " Smooth Scrolling

        Plug 'tpope/vim-fugitive'                                               " A Git wrapper so awesome, it should be illegal
        Plug 'tpope/vim-rhubarb'                                                " Github extension for fugitive
        Plug 'airblade/vim-gitgutter'                                           " Shows git diff in 'gutter' (sign column)

        Plug 'gisphm/vim-gitignore'                                             " gitignore support
        Plug 'PotatoesMaster/i3-vim-syntax'                                     " i3 support
        Plug 'godlygeek/tabular'                                                " Align plugin
        Plug 'plasticboy/vim-markdown'                                          " Markdown plugin

        Plug '/usr/bin/fzf'                                                     " adding installed fzf package
        Plug 'junegunn/fzf.vim'                                                 " fzf vim plugin

        Plug 'junegunn/goyo.vim'                                                " writing mode use <leader>f
        Plug 'vimwiki/vimwiki'                                                  " vimwiki
        Plug 'tpope/vim-commentary'                                             " Comment out line with gcc and in visual mode with gc
        Plug 'jiangmiao/auto-pairs'                                             " insert or delete brackets, parens, quotes in pair

        Plug 'itchyny/lightline.vim'                                            " Statusline replacement

        Plug 'scrooloose/nerdtree'                                              " Folder
        Plug 'Xuyuanp/nerdtree-git-plugin'                                      " Show git status in NerdTree
        Plug 'ryanoasis/vim-devicons'                                           " Icons for NerdTree
        Plug 'terryma/vim-multiple-cursors'                                     " Multiple cursor support

        Plug 'editorconfig/editorconfig-vim'                                    " Editorconfig
        Plug 'Chiel92/vim-autoformat'                                           " Format current file

        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }           " Autocomplete
        Plug 'zchee/deoplete-clang'                                             " Autocomplete library for C/C++
        Plug 'SevereOverfl0w/deoplete-github'                                   " Deoplete github extension

        Plug 'mbbill/undotree'                                                  " Tree to show things to undo
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
        set textwidth=80

" Tabs and spaces
        set expandtab
        set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
        nnoremap <leader>l :set list!<CR>

" Fix selecting(visual mode) color
        hi Visual     ctermfg=234 ctermbg=252 cterm=none

" Fix hlsearch coloring
        hi Search     ctermfg=234 cterm=bold

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
        hi Folded     ctermfg=234 cterm=bold

" Folding setup
        set nofoldenable
        " set foldmethod=indent
        " set foldlevel=1
        " set foldclose=all

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

" Check file in shellcheck:
        map <leader>s :!clear && shellcheck %<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
        map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
        map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
        let g:vimwiki_list = [{'path': '~/docs/shared/vimwiki/'}]
        autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
        autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writing
        " Goyo's width will be the line limit in mutt.
        autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
        autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
        autocmd BufRead,BufNewFile /tmp/newmutt* set bg=light
        autocmd BufRead,BufNewFile /tmp/newmutt* hi Visual ctermfg=234 ctermbg=252 cterm=none

" Automatically deletes all trailing whitespaces on save
        autocmd BufWritePre * %s/\s\+$//e
        autocmd BufWritePre * retab

" Post Save Commands
        autocmd BufWritePost * silent! execute "!notify-send 'File <afile> saved'" | redraw!
        autocmd BufWritePost * silent! execute "!syncfile %:p" | redraw!

" lightline configuration
        set laststatus=2
        let g:lightline = {
        \     'active': {
        \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
        \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
        \     }
        \ }

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
        map <leader>n :NERDTreeToggle<CR><CR>
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF plugin: fuzzy search
        map <leader>q :Files<CR>

" Goyo plugin makes text more readable when writing:
        map <leader>f :Goyo \| set bg=light \| hi Visual ctermfg=234 ctermbg=252 cterm=none \| set linebreak<CR>

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
