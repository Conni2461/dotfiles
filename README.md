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
- [Zsh](#Zsh)
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

## Zsh

If you wanna use zsh, [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) is required to be installed.
If you don't want to use this features remove the last two lines of the [zshrc](.zshrc).
If you ran into problems check the path of both extensions. It is possible that it has to be changed for your system.

## Vim

- Neovim >= 0.5 required. (Probobly nightly build)
- pyneovim (Python client for Neovim)

When neovim is started for the first time, vim-plug is downloaded and `:PlugInstall` is executed.
To update plugins use `:PlugUpdate` and to upgrade vim-plug run `:PlugUpgrade`.
All further commands can be found on [vim-plugs github page](https://github.com/junegunn/vim-plug).

A full list of used plugins:

| Plugin                                                                       | Description                                                                                                                                                                                               |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [signature](https://github.com/kshenoy/vim-signature)                        | Plugin to toggle, display and navigate marks                                                                                                                                                              |
| [misc](https://github.com/xolox/vim-misc)                                    | Miscellaneous auto-load Vim scripts required for vim-session                                                                                                                                              |
| [session](https://github.com/xolox/vim-session)                              | Extended session management for Vim (:mksession on steroids)                                                                                                                                              |
| [lastplace](https://github.com/farmergreg/vim-lastplace)                     | Intelligently reopen files at your last edit position                                                                                                                                                     |
| [scrolling](https://github.com/psliwka/vim-smoothie)                         | Smoth scrolling with `Ctrl-d` / `Ctrl-u` / `Ctrl-f` / `Ctrl-b`                                                                                                                                            |
| [animate](https://github.com/camspiers/animate.vim)                          | Vim animation api                                                                                                                                                                                         |
| [fugitive](https://github.com/tpope/vim-fugitive)                            | Git Wrapper                                                                                                                                                                                               |
| [rhubarb](https://github.com/tpope/vim-rhubarb)                              | GitHub extension for fugitive                                                                                                                                                                             |
| [gitgutter](https://github.com/airblade/vim-gitgutter)                       | A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.                                                                                                |
| [git-messenger](https://github.com/rhysd/git-messenger.vim)                  | Show git messages with `<leader>gm`. Using nvim-floating-window                                                                                                                                           |
| [gitignore highlight](https://github.com/gisphm/vim-gitignore)               | gitignore highlighting support                                                                                                                                                                            |
| [better syntax highlighting](https://github.com/sheerun/vim-polyglot)        | Better Vim syntax highlighting multiple languages                                                                                                                                                         |
| [CurtineIncSw](https://github.com/ericcurtin/CurtineIncSw.vim)               | Toggle between header and sorce files with `<leader>m`                                                                                                                                                    |
| [Clap](https://github.com/liuchengxu/vim-clap)                               | Modern generic interactive finder and dispatcher for Vim and NeoVim. Using nvim-floating-window. Shortcuts for files, buffer, grep, tags and marks. See [keybindings](.config/nvim/plugins.d/40-clap.vim) |
| [goyo](https://github.com/junegunn/goyo.vim)                                 | Distraction-free writing in Vim                                                                                                                                                                           |
| [limelight](https://github.com/junegunn/limelight.vim)                       | All the world's indeed a stage and we are merely players                                                                                                                                                  |
| [vimwiki](https://github.com/vimwiki/vimwiki)                                | Personal Wiki for Vim                                                                                                                                                                                     |
| [clever-f](https://github.com/rhysd/clever-f.vim)                            | Changes behavior of f/F and t/T                                                                                                                                                                           |
| [commentary](https://github.com/tpope/vim-commentary)                        | comment stuff out with `gcc` to comment out line and `gc` in visual mode                                                                                                                                  |
| [surround](https://github.com/tpope/vim-surround)                            | quoting/parenthesizing made simple                                                                                                                                                                        |
| [CommentFrame](https://github.com/cometsong/CommentFrame.vim)                | Add comment frames. Use <leader>fcS for c/c++ and <leader>fch or <leader>fcH for bash                                                                                                                     |
| [illuminate](https://github.com/RRethy/vim-illuminate)                       | automatically highlighting other uses of the word under the cursor                                                                                                                                        |
| [nvim-lsp](https://github.com/neovim/nvim-lsp)                               | Providing config for built-in lsp                                                                                                                                                                         |
| [completion](https://github.com/haorenW1025/completion-nvim)                 | Adds completion for nvim-lsp                                                                                                                                                                              |
| [diagnostic](https://github.com/haorenW1025/diagnostic-nvim)                 | Changes default nvim-lsp diagnostics behavior                                                                                                                                                             |
| [lightline](https://github.com/itchyny/lightline.vim)                        | A light and configurable statusline/tabline plugin                                                                                                                                                        |
| [lightline bufferline](https://github.com/mengelbrecht/lightline-bufferline) | A lightweight plugin to display the list of buffers in the lightline vim plugin                                                                                                                           |
| [vista](https://github.com/liuchengxu/vista.vim)                             | Viewer & Finder for LSP symbols and tags. Also this plugin is used in `Clap` for Tag finding.                                                                                                             |
| [undotree](https://github.com/mbbill/undotree)                               | The undo history visualizer for VIM                                                                                                                                                                       |
| [nerdtree](https://github.com/preservim/nerdtree)                            | A tree explorer plugin for vim.                                                                                                                                                                           |
| [devicons](https://github.com/ryanoasis/vim-devicons)                        | Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more                                                                           |
| [css-color](https://github.com/ap/vim-css-color)                             | Adds color to hexcodes                                                                                                                                                                                    |

Some plugins require additional packages installed:

- Vim-Clap requires [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) to work best. It is also required to have a nightly [rust-lang](https://github.com/rust-lang/rust) toolchain configured (use rustup and run `rustup default nightly`). If you don't want to use rust, you can checkout an early vim-clap version.
- Vista requires [ctags](https://ctags.io/)
- Already preonfigured LSP Server. Install one or more of the listed Servers and you are good to go for the specific language (setup can be verified with `:checkhealth`):
  - [als](https://github.com/AdaCore/ada_language_server) for ada
  - [bash-language-server](https://github.com/bash-lsp/bash-language-server) for bash and posix compliant shells
  - Using [ccls](https://github.com/MaskRay/ccls) if installed and [clangd](https://clangd.llvm.org/) as fallback for c/c++
  - [cssls](https://github.com/vscode-langservers/vscode-css-languageserver-bin) for css files
  - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs) for dockerfiles
  - [flow](https://github.com/facebook/flow) for JavaScript
  - [fortls](https://github.com/hansec/fortran-language-server) for Fortran
  - [gopls](https://github.com/golang/tools/tree/master/gopls) for golang
  - [html](https://github.com/vscode-langservers/vscode-html-languageserver-bin) for html
  - [jsonls](https://github.com/vscode-langservers/vscode-json-languageserver) for json
  - [metals](https://scalameta.org/metals/) for scala
  - Using [microsoft-python-language-server](https://github.com/Microsoft/python-language-server) if installed and [python-language-server](https://github.com/palantir/python-language-server) as fallback for python
  - Using [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer) if installed and [rls](https://github.com/rust-lang/rls) as fallback for rust
  - [solargraph](https://solargraph.org/) for ruby
  - [sumneko lua](https://github.com/sumneko/lua-language-server) for lua
  - [texlab](https://github.com/latex-lsp/texlab) for latex
  - [tsserver](https://github.com/theia-ide/typescript-language-server) for TypeScript
  - [vimls](https://github.com/iamcco/vim-language-server) for vimlang
  - additional linters can be configured [here](.config/nvim/plugins.post.d/70-nvim-lsp.vim). Take a look at [nvim-lsp](https://github.com/neovim/nvim-lsp).
