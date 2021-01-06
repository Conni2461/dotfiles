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
		\'left': [['mode', 'paste' ], ['gitbranch', 'gitstatus', 'readonly', 'filename']],
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
	\},
	\'component_type': {
		\'linter_errors': 'error',
		\'linter_warnings': 'warning',
		\'linter_infos': 'right',
		\'linter_hints': 'right',
	\},
	\'component_function': {
		\'gitstatus': 'GitStatus',
		\'gitbranch': 'fugitive#head',
		\'filetype': 'MyFiletype'
	\}
\}

au User LspDiagnosticsChanged call lightline#update()

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
	let l:filename = expand('%:t') == "" ? "_" : expand('%:t')
	let l:fileextension = expand('%:e') == "" ? "_" : expand('%:e')
	let l:cmd = printf("require'nvim-web-devicons'.get_icon(\"%s\", \"%s\")", l:filename, l:fileextension)
	let l:icon = luaeval(l:cmd)
	let l:icon = l:icon == "null" ? "" : " " . l:icon
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . l:icon  : 'no ft') : ''
endfunction

function! GetErrors()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:all_errors = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), 'Error')")
		return l:all_errors == 0 ? '' : printf('%s%d', g:indicator_errors, all_errors)
	endif
	return ''
endfunction

function! GetWarnings()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:all_warns = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), 'Warning')")
		return l:all_warns == 0 ? '' : printf('%s%d', g:indicator_warnings, all_warns)
	endif
	return ''
endfunction

function! GetInformations()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:all_infos = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), 'Information')")
		return l:all_infos == 0 ? '' : printf('%s%d', g:indicator_infos, all_infos)
	endif
	return ''
endfunction

function! GetHints()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:all_hints = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), 'Hint')")
		return l:all_hints == 0 ? '' : printf('%d', g:indicator_hints, all_hints)
	endif
	return ''
endfunction
