	     _       _    __ _ _
	  __| | ___ | |_ / _(_) | ___  ___
	 / _` |/ _ \| __| |_| | |/ _ \/ __|
	| (_| | (_) | |_|  _| | |  __/\__ \
	 \__,_|\___/ \__|_| |_|_|\___||___/

	   ____                        _ ____  _  _    __   _
	  / __ \  ___ ___  _ __  _ __ (_)___ \| || |  / /_ / |
	 / / _` |/ __/ _ \| '_ \| '_ \| | __) | || |_| '_ \| |
	| | (_| | (_| (_) | | | | | | | |/ __/|__   _| (_) | |
	 \ \__,_|\___\___/|_| |_|_| |_|_|_____|  |_|  \___/|_|
	  \____/

[![license](https://img.shields.io/github/license/conni2461/dotfiles.svg?style=flat-square)]()
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/ef9d3503d02343ac8f6d1c0a7eb25d66)](https://app.codacy.com/app/Conni2461/dotfiles?utm_source=github.com&utm_medium=referral&utm_content=Conni2461/dotfiles&utm_campaign=Badge_Grade_Dashboard)

## Introduction

## Table of Contents

-   [Install](#Install)
-   [Use](#Use)
-   [Bash](#Bash)
-   [Vim](#Vim)

## Install

```sh
# Move to your home folder
cd
# Create a alias to work with the git bare repository. Don't close the bash session or you have to run this command again.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Ignore the .cfg folder. This makes sure that you don't create weird recursion problems
echo ".cfg" >> .gitignore
# Close the repository
git clone --bare https://github.com/conni2461/dotfiles.git $HOME/.cfg
# Get the files
config checkout
```

Now files like `.bashrc` and `.gitconfig` are untracked. Either remove or move elsewhere.

```sh
config checkout
# Change git setup to only show tracked Files
config config --local status.showUntrackedFiles no
```

## Use

```sh
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

[Git bare article](https://www.atlassian.com/git/tutorials/dotfiles)

## Bash

Dotfiles also provide [clipmenu](https://github.com/cdown/clipmenu) which requires dmenu, xsel and clipnotify.

## Vim

To install all VimPlugins open nvim and run: `:PlugInstall`
All further commands can be found on [vim-plugs github page](https://github.com/junegunn/vim-plug).

Vim plugins require nodejs and npm for coc.nvim.
Also ccls and bash-language-server.

A full list of used plugins:

-   [startify](https://github.com/mhinz/vim-startify)
-   [obsession](https://github.com/tpope/vim-obsession)
-   [signature](https://github.com/kshenoy/vim-signature)
-   [motion](https://github.com/yuttie/comfortable-motion.vim)
-   [fugitive](https://github.com/tpope/vim-fugitive)
-   [rhubarb](https://github.com/tpope/vim-rhubarb)
-   [gitgutter](https://github.com/airblade/vim-gitgutter)
-   [git-messenger](https://github.com/rhysd/git-messenger.vim)
-   [Curtine Inc Sw](https://github.com/ericcurtin/CurtineIncSw.vim)
-   [Cpp highlight](https://github.com/octol/vim-cpp-enhanced-highlight)
-   [Gitignore highlight](https://github.com/gisphm/vim-gitignore)
-   [i3 highlight](https://github.com/PotatoesMaster/i3-vim-syntax)
-   [tabular support](https://github.com/godlygeek/tabular)
-   [enhanced markdown support](https://github.com/plasticboy/vim-markdown)
-   [fzf](https://github.com/junegunn/fzf.vim)
-   [goyo](https://github.com/junegunn/goyo.vim)
-   [limelight](https://github.com/junegunn/limelight.vim)
-   [vimwiki](https://github.com/vimwiki/vimwiki)
-   [commentary](https://github.com/tpope/vim-commentary)
-   [surround](https://github.com/tpope/vim-surround)
-   [illuminate](https://github.com/RRethy/vim-illuminate)
-   [coc](https://github.com/neoclide/coc.nvim)
-   [lightline](https://github.com/itchyny/lightline.vim)
-   [lightline bufferline](https://github.com/mengelbrecht/lightline-bufferline)
-   [nnn](https://github.com/mcchrish/nnn.vim)
-   [tagbar](https://github.com/majutsushi/tagbar)
-   [undotree](https://github.com/mbbill/undotree)
-   [silicon](https://github.com/segeljakt/vim-silicon)
