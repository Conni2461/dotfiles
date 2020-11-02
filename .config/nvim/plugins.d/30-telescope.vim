nnoremap <Leader>w  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.git_files{ shorten_path = true }<CR>
nnoremap <Leader>q  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.find_files{ shorten_path = true }<CR>
nnoremap <Leader>gp <cmd>lua RELOAD('telescope'); require'telescope.builtin'.live_grep{ shorten_path = true }<CR>
nnoremap <Leader>gw <cmd>lua RELOAD('telescope'); require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w" }<CR>
nnoremap <Leader>gs <cmd>lua RELOAD('telescope'); require'module/telescope'.grep_input_string{}<CR>
nnoremap <Leader>gr <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <leader>d  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <leader>t  <cmd>lua RELOAD('telescope'); require'telescope.builtin'.lsp_workspace_symbols{ shorten_path = true, ignore_filename = true }<CR>
nnoremap <leader>ae <cmd>lua RELOAD('telescope'); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RELOAD('telescope'); require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true }<CR>
nnoremap <leader>bs <cmd>lua RELOAD('telescope'); require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false })<CR>
nnoremap <leader>lb <cmd>lua require'module/telescope'.load_bib{}<CR>
