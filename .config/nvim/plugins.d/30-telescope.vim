nnoremap <Leader>w  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.git_files{ shorten_path = true }<CR>
nnoremap <Leader>q  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.find_files{ shorten_path = true }<CR>
nnoremap <Leader>gp <cmd>lua RELOAD('telescope'); require'telescope.builtin'.live_grep{ shorten_path = true }<CR>
nnoremap <Leader>gw <cmd>lua RELOAD('telescope'); require'telescope.builtin'.live_grep{ shorten_path = true, default_text = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>gs <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <leader>d  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <leader>t  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_workspace_symbols{ shorten_path = true }<CR>
nnoremap <leader>ae <cmd>lua RELOAD('telescope'); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RELOAD('telescope'); require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true }<CR>

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
