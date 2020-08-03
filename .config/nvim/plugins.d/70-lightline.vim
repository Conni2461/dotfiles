Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'kyazdani42/nvim-web-devicons'

set laststatus=2

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#read_only=''
let g:lightline#bufferline#show_number=1

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

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
au User ClapOnExit call lightline#update()
au BufEnter call lightline#update()
au BufLeave call lightline#update()
au BufDelete call lightline#update()
au BufWritePost,TextChanged,TextChangedI * call lightline#update()

function! GitStatus() abort
	let [a,m,r] = GitGutterGetHunkSummary()
	let l:output = ""
	let l:output .= a == 0 ? "" : printf("%s%d ", g:gitgutter_sign_added, a)
	let l:output .= m == 0 ? "" : printf("%s%d ", g:gitgutter_sign_modified, m)
	let l:output .= r == 0 ? "" : printf("%s%d ", g:gitgutter_sign_removed, r)

	let l:output = trim(l:output)

	return l:output
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
