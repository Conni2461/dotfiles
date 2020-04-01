Plug 'camspiers/animate.vim'

function! OpenAnimatedHtop() abort
	" Open a htop in terminal
	new term://htop
	" Send window to bottom and start with small height
	wincmd J | resize 1
	" Animate height to 66%
	call animate#window_percent_height(0.66)
endfunction
command! Htop :call OpenAnimatedHtop()

function! OpenAnimatedLazygit() abort
	" Open a lazygit in terminal
	new term://lazygit
	" Send window to bottom and start with small height
	wincmd J | resize 1
	" Animate height to 66%
	call animate#window_percent_height(0.66)
endfunction

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

command! Lazygit :call OpenAnimatedLazygit()
