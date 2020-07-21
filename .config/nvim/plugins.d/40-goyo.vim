Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg=240

function! ToggleGoyo()
	Goyo
endfunction

function! s:goyo_enter()
	Limelight
	set background=light
	call ApplyColors()
	set linebreak
	set nocursorline
	set nolist
endfunction

function! s:goyo_leave()
	Limelight!
	set background=light
	call ApplyColors()
	set nolinebreak
	set cursorline
	set list
endfunction

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <leader>f :call ToggleGoyo()<CR>

" Enable Goyo by default for mutt writing
" Goyo's width will be the line limit in mutt.
augroup mutt
	au!
	au BufRead,BufNewFile /tmp/neomutt* :call lightline#init()
	au BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
	au BufRead,BufNewFile /tmp/neomutt* Goyo
augroup END
