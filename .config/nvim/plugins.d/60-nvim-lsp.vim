let g:indicator_errors = "\uf05e "
let g:indicator_warnings = "\uf071 "
let g:indicator_infos = "\uf7fc "
let g:indicator_hints = "\ufbe6 "

hi DiagnosticError guifg=Red guibg=#282a2e
hi DiagnosticWarning guifg=Orange guibg=#282a2e
hi DiagnosticInformation guifg=LightBlue guibg=#282a2e
hi DiagnosticHint guifg=LightGrey guibg=#282a2e

call sign_define("DiagnosticSignError", {
  \ "text" : g:indicator_errors,
  \ "texthl" : "DiagnosticError"})
call sign_define("DiagnosticSignWarning", {
  \ "text" : g:indicator_warnings,
  \ "texthl" : "DiagnosticWarning"})
call sign_define("DiagnosticSignInformation", {
  \ "text" : g:indicator_infos,
  \ "texthl" : "DiagnosticInformation"})
call sign_define("DiagnosticSignHint", {
 \ "text" : g:indicator_hints,
 \ "texthl" : "DiagnosticHint"})

nnoremap <leader>af :w! \| !formatf <c-r>%<CR> \| :e <CR> \| :LuaSnipUnlinkCurrent <CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set pumblend=10
