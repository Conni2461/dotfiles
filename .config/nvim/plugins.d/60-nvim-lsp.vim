let g:indicator_errors = "\uf05e "
let g:indicator_warnings = "\uf071 "
let g:indicator_infos = "\uf7fc "
let g:indicator_hints = "\ufbe6 "

call sign_define("LspDiagnosticsErrorSign", {"text" : g:indicator_errors, "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : g:indicator_warnings, "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : g:indicator_infos, "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : g:indicator_hints, "texthl" : "LspDiagnosticsHint"})

let g:diagnostic_insert_delay = 1
let g:diagnostic_enable_underline = 0

nnoremap <leader>af :w! \| !formatf <c-r>%<CR> \| :e <CR>

nnoremap <leader>ad <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>at <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>ai <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>ah <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>as <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>ar <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>ac <cmd>lua vim.lsp.buf.document_symbol()<CR>

nnoremap <leader>an :NextDiagnosticCycle<CR>
nnoremap <leader>ap :PrevDiagnosticCycle<CR>

augroup SwitchSource
	au!
	au FileType c,cpp,h,hpp nnoremap <buffer> <leader>am :ClangdSwitchSourceHeader<CR>
augroup END

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Enable Snippet Support
let g:completion_enable_snippet = 'snippets.nvim'

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"

inoremap <silent> <C-Space> <cmd>lua require'completion'.triggerCompletion()<CR>
inoremap <tab> <cmd>lua require'completion'.smart_tab()<CR>
