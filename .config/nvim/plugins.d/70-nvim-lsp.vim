Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'

let g:LspDiagnosticsErrorSign = '>>'
let g:LspDiagnosticsWarningSign = '--'
let g:LspDiagnosticsInformationSign = 'I'
let g:LspDiagnosticsHintSign = 'H'

let g:diagnostic_insert_delay = 1

nnoremap <leader>af :execute '!clang-format --style=file -i %'<CR>

nnoremap <leader>ad <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>at <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>ai <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>ah <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>as <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>ar <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>ac <cmd>lua vim.lsp.buf.document_symbol()<CR>

nnoremap <silent> ]d :NextDiagnostic<CR>
nnoremap <silent> [d :PrevDiagnostic<CR>
" Clap loclist
nnoremap <silent> <leader>do :OpenDiagnostic<CR>
nnoremap <leader>dl <cmd>lua require'diagnostic.util'.show_line_diagnostics()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:completion_enable_auto_paren = 1

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_chain_complete_list = {
            \ 'default' : {
            \   'default': [
            \       {'complete_items': ['lsp', 'snippet']},
            \       {'mode': '<c-p>'},
            \       {'mode': '<c-n>'}],
            \   'comment': [],
            \   'string' : [
            \       {'complete_items': ['path']}]
            \   }}
