Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

set laststatus=2

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#read_only=''
let g:lightline#bufferline#show_number=1

let g:lightline = {
	\'active': {
		\'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'buffers']],
		\'right': [['linter_errors', 'linter_warnings', 'linter_infos', 'linter_hints'], ['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype']]
	\},
	\'component_expand': {
		\'linter_errors': 'GetErrors',
		\'linter_warnings': 'GetWarnings',
		\'linter_infos': 'GetInformations',
		\'linter_hints': 'GetHints',
		\'buffers': 'lightline#bufferline#buffers',
	\},
	\'component_type': {
		\'linter_errors': 'error',
		\'linter_warnings': 'warning',
		\'linter_infos': 'right',
		\'linter_hints': 'right',
		\'buffers': 'tabsel',
	\},
	\'component_function': {
		\'gitbranch': 'fugitive#head',
		\'filetype': 'MyFiletype',
		\'fileformat': 'MyFileformat',
	\}
\}

au User LspDiagnosticsChanged call lightline#update()
au User ClapOnExit call lightline#update()
au BufEnter call lightline#update()
au BufLeave call lightline#update()
au BufDelete call lightline#update()
au BufWritePost,TextChanged,TextChangedI * call lightline#update()

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! GetErrors()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_errors = luaeval("vim.lsp.util.buf_diagnostics_count([[Error]])")
		return l:all_errors == 0 ? '' : printf(g:indicator_errors . '%d', all_errors)
	endif
	return ''
endfunction

function! GetWarnings()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_warns = luaeval("vim.lsp.util.buf_diagnostics_count([[Warning]])")
		return l:all_warns == 0 ? '' : printf(g:indicator_warnings . '%d', all_warns)
	endif
	return ''
endfunction

function! GetInformations()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_infos = luaeval("vim.lsp.util.buf_diagnostics_count([[Information]])")
		return l:all_infos == 0 ? '' : printf(g:indicator_infos . '%d', all_infos)
	endif
	return ''
endfunction

function! GetHints()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_hints = luaeval("vim.lsp.util.buf_diagnostics_count([[Hint]])")
		return l:all_hints == 0 ? '' : printf(g:indicator_hints . '%d', all_hints)
	endif
	return ''
endfunction
