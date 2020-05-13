Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

set laststatus=2

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#read_only=''
let g:lightline#bufferline#show_number=1

let g:indicator_errors = "\uf05e "
let g:indicator_warnings = "\uf071 "
let g:indicator_infos = "\uf129 "

let g:lightline = {
	\'active': {
		\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers'], ['method']],
		\'right': [['linter_errors', 'linter_warnings', 'linter_infos'], ['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype']]
	\},
	\'component_expand': {
		\'linter_errors': 'GetErrors',
		\'linter_warnings': 'GetWarnings',
		\'linter_infos': 'GetInformations',
		\'buffers': 'lightline#bufferline#buffers',
	\},
	\'component_type': {
		\'linter_errors': 'error',
		\'linter_warnings': 'warning',
		\'linter_infos': 'right',
		\'buffers': 'tabsel',
	\},
	\'component_function': {
		\'gitbranch': 'fugitive#head',
		\'method': 'NearestMethodOrFunction',
		\'filetype': 'MyFiletype',
		\'fileformat': 'MyFileformat',
	\}
\}

au User LspDiagnosticsChanged call lightline#update()
au User ClapOnExit call lightline#update()

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! GetErrors()
	let l:all_errors = luaeval("vim.lsp.util.buf_diagnostics_count(\"Error\")")
	return l:all_errors == 0 ? '' : printf(g:indicator_errors . '%d', all_errors)
endfunction

function! GetWarnings()
	let l:all_warn = luaeval("vim.lsp.util.buf_diagnostics_count(\"Warning\")")
	return l:all_warn == 0 ? '' : printf(g:indicator_warnings . '%d', all_warn)
endfunction

function! GetInformations()
	let l:all_info = luaeval("vim.lsp.util.buf_diagnostics_count(\"Information\")")
	return l:all_info == 0 ? '' : printf(g:indicator_infos . '%d', all_info)
endfunction
