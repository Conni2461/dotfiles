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

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set pumblend=10
