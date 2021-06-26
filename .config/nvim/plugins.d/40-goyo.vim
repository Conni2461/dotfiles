let g:goyo_width=120

function! s:goyo_enter()
  set linebreak
  set nocursorline
  set nolist
endfunction

function! s:goyo_leave()
  set nolinebreak
  set cursorline
  set list
  source $HOME/.config/nvim/colors.vim
endfunction

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()

" Enable Goyo by default for mutt writing
" Goyo's width will be the line limit in mutt.
augroup mutt
  au!
  au BufRead,BufNewFile /tmp/neomutt* :Goyo
augroup END
