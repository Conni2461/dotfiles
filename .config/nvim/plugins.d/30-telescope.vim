nnoremap <Leader>w  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.git_files{ shorten_path = true }<CR>
nnoremap <Leader>q  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.find_files{ shorten_path = true }<CR>
nnoremap <Leader>gp <cmd>lua RELOAD('telescope'); require'telescope.builtin'.live_grep{ shorten_path = true }<CR>
nnoremap <Leader>gw <cmd>lua RELOAD('telescope'); require'telescope.builtin'.live_grep{ shorten_path = true, default_text = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>gs <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <leader>d  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <leader>t  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_workspace_symbols{ shorten_path = true }<CR>
nnoremap <leader>ae <cmd>lua RELOAD('telescope'); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RELOAD('telescope'); require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true }<CR>
nnoremap <leader>lb <cmd>lua require'module/telescope'.load_bib{}<CR>
