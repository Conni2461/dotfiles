nnoremap <Leader>w  <cmd>lua RTELE(); require'telescope.builtin'.git_files{ }<CR>
nnoremap <Leader>q  <cmd>lua RTELE(); require'telescope.builtin'.find_files{ }<CR>
nnoremap <Leader>gp <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w", search = '' }<CR>
nnoremap <Leader>gw <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w" }<CR>
nnoremap <Leader>gs <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ shorten_path = true, search = vim.fn.input("Grep For >") }<CR>
nnoremap <Leader>ar <cmd>lua RTELE(); require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <leader>ac <cmd>lua RTELE(); require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <leader>aw <cmd>lua RTELE(); require'telescope.builtin'.lsp_workspace_symbols({ query = vim.fn.input("Query >"), shorten_path = true })<CR>
nnoremap <leader>aa <cmd>lua RTELE(); require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown())<cr>
nnoremap <leader>tp <cmd>lua RTELE(); require'telescope.builtin'.tags{ shorten_path = true }<CR>
nnoremap <leader>td <cmd>lua RTELE(); require'telescope.builtin'.current_buffer_tags{}<CR>
nnoremap <leader>ae <cmd>lua RTELE(); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RTELE(); require'telescope.builtin'.buffers{ show_all_buffers = true, shorten_path = true, sort_lastused = true }<CR>
nnoremap <leader>bs <cmd>lua RTELE(); require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false })<CR>
nnoremap <leader>lb <cmd>lua require'module/telescope'.load_bib{}<CR>
