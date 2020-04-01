Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
Plug 'SevereOverfl0w/deoplete-github'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#sources = {}
" Stop deoplete from opening a split
set completeopt-=preview

let g:deoplete#sources.gitcommit=['github']
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '[^ \t]+'
