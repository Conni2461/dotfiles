" Snippets
" Snippet navigation
	inoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l
	xnoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l
	nnoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l

" Load Snippets
	for f in split(glob('~/.config/nvim/snippets.d/*.vim'), '\n')
		exe 'source' f
	endfor
