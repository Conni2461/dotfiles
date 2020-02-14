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

[![license](https://img.shields.io/github/license/conni2461/dotfiles.svg?style=flat-square)](https://github.com/conni2461/dotfiles/blob/master/LICENSE)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/ef9d3503d02343ac8f6d1c0a7eb25d66)](https://app.codacy.com/app/Conni2461/dotfiles?utm_source=github.com&utm_medium=referral&utm_content=Conni2461/dotfiles&utm_campaign=Badge_Grade_Dashboard)

## Introduction

## Table of Contents

- [Install](#Install)
- [Use](#Use)
- [Bash](#Bash)
- [Vim](#Vim)

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

Dotfiles provide [clipmenu](https://github.com/cdown/clipmenu) which requires dmenu, xsel and clipnotify.
Also a spotify commandline handler script [sp](https://gist.github.com/wandernauta/6800547).
All credits goes to the creator of those scripts.

Some scripts in the bin folder require `dmenu`, `skim`, `the_silver_searcher`, `fd` and `ripgrep`.
Also twitch-notify requires `python-notify2`.

## Vim

To install all VimPlugins open nvim and run: `:PlugInstall`
All further commands can be found on [vim-plugs github page](https://github.com/junegunn/vim-plug).

A full list of used plugins:

| Plugin                                                                       | Description                                                                                                                                                                                                                          |
| ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [signature](https://github.com/kshenoy/vim-signature)                        | Plugin to toggle, display and navigate marks                                                                                                                                                                                         |
| [motion](https://github.com/yuttie/comfortable-motion.vim)                   | Smoth scrolling with `Ctrl-d` / `Ctrl-u` / `Ctrl-f` / `Ctrl-b`                                                                                                                                                                       |
| [animate](https://github.com/camspiers/animate.vim)                          | Vim animation api                                                                                                                                                                                                                    |
| [fugitive](https://github.com/tpope/vim-fugitive)                            | Git Wrapper                                                                                                                                                                                                                          |
| [rhubarb](https://github.com/tpope/vim-rhubarb)                              | GitHub extension for fugitive                                                                                                                                                                                                        |
| [gitgutter](https://github.com/airblade/vim-gitgutter)                       | A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.                                                                                                                           |
| [git-messenger](https://github.com/rhysd/git-messenger.vim)                  | Show git messages with `<leader>gm`. Using nvim-floating-window                                                                                                                                                                      |
| [gitignore highlight](https://github.com/gisphm/vim-gitignore)               | gitignore highlighting support                                                                                                                                                                                                       |
| [i3 highlight](https://github.com/PotatoesMaster/i3-vim-syntax)              | i3 highlighting support                                                                                                                                                                                                              |
| [cpp highlight](https://github.com/octol/vim-cpp-enhanced-highlight)         | Additional Vim syntax highlighting for C++ (including C++11/14/17)                                                                                                                                                                   |
| [CurtineIncSw](https://github.com/ericcurtin/CurtineIncSw.vim)               | Toggle between header and sorce files with `<leader>m`                                                                                                                                                                               |
| [Clap](https://github.com/liuchengxu/vim-clap)                               | Modern generic interactive finder and dispatcher for Vim and NeoVim. Using nvim-floating-window. Shortcuts for files, buffer, grep, tags and marks. See https://github.com/Conni2461/dotfiles/blob/master/.config/nvim/init.vim#L410 |
| [goyo](https://github.com/junegunn/goyo.vim)                                 | Distraction-free writing in Vim                                                                                                                                                                                                      |
| [limelight](https://github.com/junegunn/limelight.vim)                       | All the world's indeed a stage and we are merely players                                                                                                                                                                             |
| [vimwiki](https://github.com/vimwiki/vimwiki)                                | Personal Wiki for Vim                                                                                                                                                                                                                |
| [commentary](https://github.com/tpope/vim-commentary)                        | comment stuff out with `gcc` to comment out line and `gc` in visual mode                                                                                                                                                             |
| [surround](https://github.com/tpope/vim-surround)                            | quoting/parenthesizing made simple                                                                                                                                                                                                   |
| [illuminate](https://github.com/RRethy/vim-illuminate)                       | automatically highlighting other uses of the word under the cursor                                                                                                                                                                   |
| [deoplete](https://github.com/Shougo/deoplete.nvim)                          | Dark powered asynchronous completion framework uses `ale` in my configuration                                                                                                                                                        |
| [ale](https://github.com/dense-analysis/ale)                                 | Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support                                                                                                                                        |
| [deoplete github plugin](https://github.com/SevereOverfl0w/deoplete-github)  | Deopletions for Github issues when using `git commit` on commandline and writing message in vim. Requires `deoplete`, `fugitive` and `rhubarb`. Also setup is required, take a look at their `README.md`                             |
| [lightline](https://github.com/itchyny/lightline.vim)                        | A light and configurable statusline/tabline plugin                                                                                                                                                                                   |
| [lightline bufferline](https://github.com/mengelbrecht/lightline-bufferline) | A lightweight plugin to display the list of buffers in the lightline vim plugin                                                                                                                                                      |
| [lightline ale](https://github.com/maximbaz/lightline-ale)                   | ALE indicator for the lightline vim plugin                                                                                                                                                                                           |
| [vista](https://github.com/liuchengxu/vista.vim)                             | Viewer & Finder for LSP symbols and tags. Also this plugin is used in `Clap` for Tag finding.                                                                                                                                        |
| [undotree](https://github.com/mbbill/undotree)                               | The undo history visualizer for VIM                                                                                                                                                                                                  |
| [nerdtree](https://github.com/preservim/nerdtree)                            | A tree explorer plugin for vim.                                                                                                                                                                                                      |
| [devicons](https://github.com/ryanoasis/vim-devicons)                        | Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more                                                                                                      |

Some plugins require additional packages installed:

- Vim-Clap requires [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) to work best
- Configured LSP Server for ALE are:
  - [cquery](https://github.com/cquery-project/cquery/) for c/c++
  - [python-language-server](https://github.com/palantir/python-language-server) for python with [flake8](http://flake8.pycqa.org/en/latest/)
  - [shellcheck](https://www.shellcheck.net/) for bash and posix compliant shells
  - [lacheck](https://ctan.org/pkg/lacheck?lang=de)(Part of texlive)  for latex
  - [vint](https://github.com/Kuniwak/vint) for vim
  - additional linters can be configured [here](https://github.com/Conni2461/dotfiles/blob/master/.config/nvim/init.vim#L330)
- Vista requires [ctags](https://ctags.io/)
