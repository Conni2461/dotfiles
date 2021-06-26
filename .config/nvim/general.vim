" Some Basics
imap jk <Esc>

set mouse=a
set hlsearch
set smartcase
set clipboard=unnamedplus
set noshowmode
set showtabline=1
set scrolloff=2

set cmdheight=1
set updatetime=300
set signcolumn=yes

set colorcolumn=80

set conceallevel=0

filetype plugin indent on
syntax on
set encoding=utf-8
set number relativenumber
set cursorline

" Remove Trailing Whitespaces
function! TrimTrailingLines()
  let lastLine = line('$')
  let lastNonblankLine = prevnonblank(lastLine)
  if lastLine > 0 && lastNonblankLine != lastLine
    silent! execute lastNonblankLine + 1 . ',$delete _'
  endif
endfunction
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
augroup remove
  au!
  au BufWritePre * call TrimWhitespace()
  au BufWritePre * call TrimTrailingLines()
augroup END

" Nvim specifics
" Shows realtime changes with :s/
set inccommand=split

" Sandwich! :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"

" History
" set noswapfile
set history=10000
set undofile
set undodir=~/.local/share/nvim/undo
set undolevels=1000
set undoreload=10000
set backupdir=~/.local/share/nvim/backup/
set directory=~/.local/share/nvim/backup/

" Buffer Setup
set hidden
nnoremap <leader>bn :enew<CR>
nnoremap <leader>bv :vnew<CR>
nnoremap <leader>bx :new<CR>
nnoremap <leader>bh :bprevious<CR>
nnoremap <leader>bl :bnext<CR>
nnoremap <leader>bq :bd<CR>

" Tabs and spaces
set tabstop=4
set shiftwidth=4
set noexpandtab
set listchars=tab:\¦\ " Required comment
set list
nnoremap <leader>vr :%retab!<CR>

" Folding setup
set foldenable
set foldmethod=indent
set foldlevelstart=99
" See https://github.com/nvim-treesitter/nvim-treesitter/pull/390#issuecomment-709666989
function! GetSpaces(foldLevel)
  if &expandtab == 1
    " Indenting with spaces
    let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
    return str
  elseif &expandtab == 0
    " Indenting with tabs
    return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
  endif
endfunction

function! MyFoldText()
  let startLineText = getline(v:foldstart)
  let endLineText = trim(getline(v:foldend))
  let indentation = GetSpaces(foldlevel("."))
  let spaces = repeat(" ", 200)

  let str = indentation . startLineText . "..." . endLineText . spaces

  return str
endfunction
set foldtext=MyFoldText()
nnoremap <s-tab> za

" Split Lines
nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>

" Navigate Display Lines
nnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
xnoremap <silent><expr> k       v:count == 0 ? 'gk' : 'k'
xnoremap <silent><expr> j       v:count == 0 ? 'gj' : 'j'
nnoremap <silent><expr> <Up>    v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr> <Down>  v:count == 0 ? 'gj' : 'j'
nnoremap H 0
nnoremap L $
nnoremap <silent><expr> G &wrap ? "G$g0" : "G"
nnoremap <silent><expr> 0 &wrap ? "g0" : "0"
nnoremap <silent><expr> $ &wrap ? "g$" : "$"

"" Vmap for maintain Visual Mode after shifting > and <
xnoremap < <gv
xnoremap > >gv

" Bubble single lines
nnoremap <C-Up>   :m .-2<CR>
nnoremap <C-Down> :m  .+1<CR>

" Bubble multiple lines
xnoremap <silent> <C-Up>   @='"zxk"zP`[V`]'<CR>
xnoremap <silent> <C-Down> @='"zx"zp`[V`]'<CR>

" Disable automatic commenting on newline:
augroup commenting
  au!
  au FileType * setlocal formatoptions-=cro
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
function! s:run_term(cmd, cwd) abort
  belowright 10new
  setlocal buftype=nofile winfixheight norelativenumber nonumber bufhidden=wipe

  let bufnr = bufnr('')

  function! s:OnExit(status) closure abort
    if a:status == 0
      execute 'silent! bd! '.bufnr
      lua require("module/simpleline").update()
    endif
  endfunction

  if has('nvim')
    call termopen(a:cmd, {
      \ 'cwd': a:cwd,
      \ 'on_exit': {job, status -> s:OnExit(status)},
    \})
  else
    let cmd = a:cmd
    call term_start(cmd, {
      \ 'curwin': 1,
      \ 'cwd': a:cwd,
      \ 'exit_cb': {job, status -> s:OnExit(status)},
    \})
  endif

  normal! G
  startinsert
endfunction

function! s:compile_code() abort
  silent! write
  call s:run_term(printf('compiler %s', expand('%:p')), getcwd())
endfunction

function! s:lint_code() abort
  silent! write
  call s:run_term(printf('lintf %s %s', expand('%:p'), &ft), getcwd())
endfunction

nnoremap <leader>c :call <SID>compile_code()<CR>
nnoremap <leader>al :call <SID>lint_code()<CR>

" Execute this file
function! s:save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif
  return
endfunction
nnoremap <leader>x :call <SID>save_and_exec()<CR>

" Open corresponding .pdf/.html or preview
nnoremap <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
augroup files
  au!
  au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  au BufRead,BufNewFile *.tex set filetype=tex
  au BufRead,BufNewFile *.h set filetype=c
augroup END

" Terminal mode changes
tnoremap <Esc> <C-\><C-n>
augroup terminalmode
  au!
  au TermOpen * setlocal nonumber norelativenumber
augroup END

function! s:split_term() abort
  botright split term://$SHELL
  setlocal norelativenumber nonumber
  startinsert
endfunction
command! T call s:split_term()

" cpp stuff
function! s:CppMan()
  let old_isk = &iskeyword
  setl iskeyword+=:
  let str = expand("<cword>")
  let &l:iskeyword = old_isk
  execute 'Man ' . str
endfunction
command! CppMan :call s:CppMan()
augroup customcppman
  au!
  au FileType c,cpp,h,hpp nnoremap <buffer>K :CppMan<CR>
augroup END

nnoremap <silent> <leader>osx :lua require("module/openb").smart_search("cppref")<CR>
nnoremap <silent> <leader>osq :lua require("module/openb").smart_search("qt")<CR>
