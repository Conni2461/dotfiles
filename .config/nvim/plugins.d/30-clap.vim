Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" lua RELOAD = require('plenary.reload').reload_module

nnoremap <Leader>q  <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.fd{ shorten_path = true }<CR>
nnoremap <Leader>w  <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.git_files{ shorten_path = true }<CR>
nnoremap <Leader>gp <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>gw <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.lsp_references{}<CR>
nnoremap <leader>ae <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>t  <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.lsp_workspace_symbols{}<CR>
nnoremap <leader>bg <cmd>lua require('plenary.reload').reload_module('telescope'); require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true }<CR>

" function! s:ReadBib(...)
"     let l:input = join(a:000)
"     let l:command = "echo '" . l:input . "' | cut -d':' -f 1"
"     let l:file = system(l:command)

"     execute 'read !loadbib -g' l:file
" endfunction

" command! -nargs=* ReadBib call s:ReadBib(<f-args>)

" Own Clap provider
" let g:clap_provider_load_bib = {
"     \ 'source': 'loadbib -l',
"     \ 'sink': 'ReadBib',
"     \ }

" nnoremap <leader>xb :Clap load_bib<CR>
