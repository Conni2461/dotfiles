set laststatus=2

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#read_only=''
let g:lightline#bufferline#show_number=0

" TODO move signify into own file
let g:signify_line_highlight         = 0
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_change            = '~'

let g:lightline = {
	\'active': {
		\'left': [['mode', 'paste' ], ['gitbranch', 'gitstatus', 'readonly', 'buffers']],
		\'right': [['linter_errors', 'linter_warnings', 'linter_infos', 'linter_hints'], ['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype']]
	\},
	\'inactive': {
		\'left': [['filename']],
		\'right': [[]]
	\},
	\'component_expand': {
		\'linter_errors': 'GetErrors',
		\'linter_warnings': 'GetWarnings',
		\'linter_infos': 'GetInformations',
		\'linter_hints': 'GetHints',
		\'buffers': 'lightline#bufferline#buffers'
	\},
	\'component_type': {
		\'linter_errors': 'error',
		\'linter_warnings': 'warning',
		\'linter_infos': 'right',
		\'linter_hints': 'right',
		\'buffers': 'tabsel'
	\},
	\'component_function': {
		\'gitstatus': 'GitStatus',
		\'gitbranch': 'fugitive#head',
		\'filetype': 'MyFiletype'
	\}
\}

au User LspDiagnosticsChanged call lightline#update()
au BufEnter,BufLeave,BufDelete call lightline#update()
au BufWritePost,TextChanged,TextChangedI * call lightline#update()

function! GitStatus() abort
	let stats = sy#repo#get_stats()
	let symbols = ['+', '~', '-']
	let statline = ''

	for i in range(3)
		if stats[i] > 0
			let statline .= printf('%s%s ', symbols[i], stats[i])
		endif
	endfor

	if !empty(statline)
		let statline = printf('[%s]', statline[:-2])
	endif

	return statline
endfunction

function! MyFiletype()
	let l:tmp_icon = luaeval("require'nvim-web-devicons'.get_icon(_, vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'filetype'))")
	let l:icon = l:tmp_icon == "null" ? "" : ' ' . l:tmp_icon
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . l:icon  : 'no ft') : ''
endfunction

function! GetErrors()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_errors = luaeval("vim.lsp.util.buf_diagnostics_count([[Error]])")
		return l:all_errors == 0 ? '' : printf('%s%d', g:indicator_errors, all_errors)
	endif
	return ''
endfunction

function! GetWarnings()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_warns = luaeval("vim.lsp.util.buf_diagnostics_count([[Warning]])")
		return l:all_warns == 0 ? '' : printf('%s%d', g:indicator_warnings, all_warns)
	endif
	return ''
endfunction

function! GetInformations()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_infos = luaeval("vim.lsp.util.buf_diagnostics_count([[Information]])")
		return l:all_infos == 0 ? '' : printf('%s%d', g:indicator_infos, all_infos)
	endif
	return ''
endfunction

function! GetHints()
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		let l:all_hints = luaeval("vim.lsp.util.buf_diagnostics_count([[Hint]])")
		return l:all_hints == 0 ? '' : printf('%d', g:indicator_hints, all_hints)
	endif
	return ''
endfunction
