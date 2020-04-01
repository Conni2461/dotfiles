Plug 'liuchengxu/vista.vim'

nnoremap <leader>o :Vista!!<CR>
let g:vista_default_executive = 'ctags'

function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

augroup vista
	au!
	au VimEnter * call vista#RunForNearestMethodOrFunction()
augroup END
