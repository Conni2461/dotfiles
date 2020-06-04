Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'
Plug 'steelsojka/completion-buffers'

call sign_define("LspDiagnosticsErrorSign", {"text" : "\uf05e", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "\uf071", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "\uf129", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

let g:diagnostic_insert_delay = 1

nnoremap <leader>af :silent exec '!clang-format --style=file -i %' \| e<CR>

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

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_chain_complete_list = {
	\'default' : {
		\'default': [
			\{'complete_items': ['lsp', 'buffers']},
			\{'complete_items': ['path'], 'triggered_only': ['./', '/']},
			\{'mode': '<c-p>'},
			\{'mode': '<c-n>'}],
		\'comment': []
	\}
\}

let g:completion_auto_change_source = 1
inoremap <silent> <expr> <C-Space> completion#trigger_completion()

let g:completion_customize_lsp_label = {
	\ "Method": "\uf794",
	\ "Function": "\uf794",
	\ "Variable": "\uf6a6",
	\ "Field": "\uf6a6",
	\ "Class": "\ufb44",
	\ "Struct": "\ufb44",
	\ "Interface": "\uf836",
	\ "Module": "\uf668",
	\ "Property": "\uf0ad",
	\ "Value": "\uf77a",
	\ "Enum": "\uf77a",
	\ "Operator": "\uf055",
	\ "Reference": "\uf838",
	\ "Keyword": "\uf80a",
	\ "Color": "\ue22b",
	\ "Unit": "\ue3ce",
	\ "Snippet": "\uf68e",
	\ "Text": "\uf52b",
	\ "Buffers": "\uf64d",
	\ "TypeParameter": "\uf635",
\}
