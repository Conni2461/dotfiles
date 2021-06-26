set nocompatible

let mapleader = ','

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/colors.vim

" Load plugins config files
for f in split(glob('~/.config/nvim/plugins.d/*.vim'), '\n')
  exe 'source' f
endfor

luafile ~/.config/nvim/lua/init.lua
