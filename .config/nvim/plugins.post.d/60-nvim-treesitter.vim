luafile ~/.config/nvim/plugins.post.d/60-nvim-treesitter.lua

" Enabling folding with treesitter even some files need some time to open up.
" This usually only occures with some large c files (most 1000 line c files from
" neovim open in a split second but dwm source code needs roughly 5s). This is
" maybe linked to files which include a lot of struct definition in the same
" file like dwm or st source code.
"
" This will hopfully be fixed soon.
set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
