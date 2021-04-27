let g:indicator_errors = "\uf05e "
let g:indicator_warnings = "\uf071 "
let g:indicator_infos = "\uf7fc "
let g:indicator_hints = "\ufbe6 "

hi LspDiagnosticsDefaultError guifg=Red guibg=#282a2e
hi LspDiagnosticsDefaultWarning guifg=Orange guibg=#282a2e
hi LspDiagnosticsDefaultInformation guifg=LightBlue guibg=#282a2e
hi LspDiagnosticsDefaultHint guifg=LightGrey guibg=#282a2e

call sign_define("LspDiagnosticsSignError", {
			\ "text" : g:indicator_errors,
			\ "texthl" : "LspDiagnosticsDefaultError"})
call sign_define("LspDiagnosticsSignWarning", {
			\ "text" : g:indicator_warnings,
			\ "texthl" : "LspDiagnosticsDefaultWarning"})
call sign_define("LspDiagnosticsSignInformation", {
			\ "text" : g:indicator_infos,
			\ "texthl" : "LspDiagnosticsDefaultInformation"})
call sign_define("LspDiagnosticsSignHint", {
			\ "text" : g:indicator_hints,
			\ "texthl" : "LspDiagnosticsDefaultHint"})

nnoremap <leader>af :w! \| !formatf <c-r>%<CR> \| :e <CR>

nnoremap <leader>ad <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>at <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>ai <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>ah <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>as <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <leader>ar <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <leader>ac <cmd>lua vim.lsp.buf.document_symbol()<CR>

nnoremap <leader>an <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>ap <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

augroup SwitchSource
	au!
	au FileType c,cpp,h,hpp nnoremap <buffer> <leader>am :ClangdSwitchSourceHeader<CR>
augroup END

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set pumblend=10

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
