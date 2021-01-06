nnoremap <Leader>w  <cmd>lua RELOAD'telescope'; require'telescope.builtin'.git_files{ }<CR>
nnoremap <Leader>q  <cmd>lua RELOAD'telescope'; require'telescope.builtin'.find_files{ }<CR>
nnoremap <Leader>gp <cmd>lua RELOAD'telescope'; require'telescope.builtin'.live_grep{ shorten_path = true }<CR>
nnoremap <Leader>gw <cmd>lua RELOAD'telescope'; require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w" }<CR>
nnoremap <Leader>gs <cmd>lua RELOAD'telescope'; require'telescope.builtin'.grep_string{ search = vim.fn.input("Grep For >")}<CR>
nnoremap <Leader>ar <cmd>lua RELOAD'telescope'; require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <leader>ac <cmd>lua RELOAD'telescope'; require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <leader>aw <cmd>lua RELOAD'telescope'; require'telescope.builtin'.lsp_workspace_symbols{ shorten_path = true }<CR>
nnoremap <leader>tp <cmd>lua RELOAD'telescope'; require'telescope.builtin'.tags{ shorten_path = true }<CR>
nnoremap <leader>td <cmd>lua RELOAD'telescope'; require'telescope.builtin'.current_buffer_tags{}<CR>
nnoremap <leader>ae <cmd>lua RELOAD'telescope'; require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RELOAD'telescope'; require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true, sort_lastused = true }<CR>
nnoremap <leader>bs <cmd>lua RELOAD'telescope'; require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false })<CR>
nnoremap <leader>lb <cmd>lua require'module/telescope'.load_bib{}<CR>
