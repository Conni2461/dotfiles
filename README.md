# Linux Dotfiles

## How to clone as git bare

```
# Move to your home folder
cd
# Create a alias to work with the git bare repository. Don't close the bash session or you have to run this command again.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Ignore the .cfg folder. This makes sure that you don't create weird recursion problems
echo ".cfg" >> .gitignore
# Close the repository
git clone --bare https://github.com/conni2461/dotfiles.git
# Get the files
config checkout
```

Now files like `.bashrc` and `.gitconfig` are untracked. Either remove or move elsewhere.

```
config checkout
# Change git setup to only show tracked Files
config config --local status.showUntrackedFiles no
```

## Hom to work with git bare dotfiles

```
# Show status of dotfile repository
config status
# Add a file
config add .file
# Create a commit
config commit -m "Message"
# Push to the remote repository
config push
```

Also you should change the email and name in the `.gitconfig` as well as the remote adresse.

```
git remote set-url origin <url>
```

Git bare article https://www.atlassian.com/git/tutorials/dotfiles

## Vim Plugins

To install all VimPlugins open nvim and run: `:PlugInstall`
All further commands can be found on [vim-plugs github page](https://github.com/junegunn/vim-plug).

A full list of used plugins:

- https://github.com/mhinz/vim-startify
- https://github.com/tpope/vim-obsession
- https://github.com/kshenoy/vim-signature
- https://github.com/yuttie/comfortable-motion.vim
- https://github.com/tpope/vim-fugitive
- https://github.com/tpope/vim-rhubarb
- https://github.com/airblade/vim-gitgutter
- https://github.com/rhysd/git-messenger.vim
- https://github.com/vim-scripts/a.vim
- https://github.com/octol/vim-cpp-enhanced-highlight
- https://github.com/gisphm/vim-gitignore
- https://github.com/PotatoesMaster/i3-vim-syntax
- https://github.com/godlygeek/tabular
- https://github.com/plasticboy/vim-markdown
- https://github.com/junegunn/fzf.vim
- https://github.com/reedes/vim-wordy
- https://github.com/junegunn/goyo.vim
- https://github.com/junegunn/limelight.vim
- https://github.com/vimwiki/vimwiki
- https://github.com/tpope/vim-commentary
- https://github.com/tpope/vim-surround
- https://github.com/RRethy/vim-illuminate
- https://github.com/itchyny/lightline.vim
- https://github.com/mengelbrecht/lightline-bufferline
- https://github.com/maximbaz/lightline-ale'
- https://github.com/scrooloose/nerdtree
- https://github.com/Xuyuanp/nerdtree-git-plugin
- https://github.com/ryanoasis/vim-devicons
- https://github.com/majutsushi/tagbar
- https://github.com/mbbill/undotree
- https://github.com/Shougo/deoplete.nvim
- https://github.com/w0rp/ale
- https://github.com/SevereOverfl0w/deoplete-github


## Additional stuff

Dotfiles also provide [clipmenu](https://github.com/cdown/clipmenu) which requires dmenu, xsel and clipnotify.
