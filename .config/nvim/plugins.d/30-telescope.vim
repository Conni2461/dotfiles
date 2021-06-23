nnoremap <Leader>w  <cmd>lua RTELE(); require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>q  <cmd>lua RTELE(); require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>gp <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ word_match = "-w", search = '' }<CR>
nnoremap <Leader>gw <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ word_match = "-w" }<CR>
nnoremap <Leader>gs <cmd>lua RTELE(); require'telescope.builtin'.grep_string{ search = vim.fn.input("Grep For >") }<CR>
nnoremap <leader>tp <cmd>lua RTELE(); require'telescope.builtin'.tags{}<CR>
nnoremap <leader>td <cmd>lua RTELE(); require'telescope.builtin'.current_buffer_tags{}<CR>
nnoremap <leader>ae <cmd>lua RTELE(); require'telescope.builtin'.loclist{}<CR>
nnoremap <leader>bg <cmd>lua RTELE(); require'telescope.builtin'.buffers{}<CR>
nnoremap <leader>bs <cmd>lua RTELE(); require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
