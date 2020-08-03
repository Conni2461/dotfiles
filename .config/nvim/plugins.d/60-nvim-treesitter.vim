Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Workaround to fix highlighting when an internal nvim error occures. Currently
" this can result into a red/red highlighting, usally when a parsing error
" occures. This link disables this additional error highlighting and will be
" removed if neovim's treesitter api handles this incident in a much better way.
" Ref: https://github.com/nvim-treesitter/nvim-treesitter/issues/78
" Ref: https://github.com/neovim/neovim/pull/12502
" Ref: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/doc/nvim-treesitter.txt#L173
highlight link TSError Normal
