Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'ncm2/float-preview.nvim'

let g:indicator_errors = " "
let g:indicator_warnings = " "
let g:indicator_infos = " "
let g:indicator_hints = "ﯧ "

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
nnoremap <leader>ae :Clap loclist<CR>
nnoremap <leader>al <cmd>lua require'diagnostic.util'.show_line_diagnostics()<CR>

augroup SwitchSource
	au!
	au FileType c,cpp,h,hpp nnoremap <buffer> <leader>am :ClangdSwitchSourceHeader<CR>
augroup END

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

inoremap <silent> <expr> <C-Space> completion#trigger_completion()

let g:float_preview#docked = 0
function! DisableExtras()
	call nvim_win_set_option(g:float_preview#win, 'number', v:false)
	call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
	call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
endfunction

autocmd User FloatPreviewWinOpen call DisableExtras()
