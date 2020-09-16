function! OpenAnimatedLazygit() abort
	new term://lazygit
	setlocal norelativenumber nonumber
	startinsert

	wincmd J | resize 1
	call animate#window_percent_height(0.66)
endfunction
command! Lazygit :call OpenAnimatedLazygit()

function! HorizontalSplit() abort
	sp
	let width = winwidth(0)
	let height = winheight(0)
	resize 1
	call animate#window_absolute(width, height)
endfunction

function! VerticalSplit() abort
	vsp
	let width = winwidth(0)
	let height = winheight(0)
	vertical resize 1
	call animate#window_absolute(width, height)
endfunction

command! HorizontalSplit :call HorizontalSplit()
command! VerticalSplit :call VerticalSplit()
cnoreabbrev <expr> sp getcmdtype() == ":" && getcmdline() == 'sp' ? 'HorizontalSplit' : 'sp'
cnoreabbrev <expr> vsp getcmdtype() == ":" && getcmdline() == 'vsp' ? 'VerticalSplit' : 'vsp'

function! s:split_term() abort
	botright split term://$SHELL
	setlocal norelativenumber nonumber
	startinsert

	let width = winwidth(0)
	let height = 10
	resize 1
	call animate#window_absolute(width, height)
endfunction
command! T call s:split_term()
