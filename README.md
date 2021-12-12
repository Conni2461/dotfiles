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
[![Scc Code Badge](https://sloc.xyz/github/conni2461/dotfiles?category=code)](https://github.com/conni2461/dotfiles)

## Introduction

The current dotfiles refer to a system with [dwm](https://github.com/conni2461/dwm) and [st](https://github.com/conni2461/st). The remaining i3 configurations have been removed and are only accessible via the hash <code><a href="https://github.com/Conni2461/dotfiles/tree/a5978268a8b37fce1549b6658446bee8372d7442">a597826</a></code>.

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

Dotfiles provide [clipmenu](https://github.com/cdown/clipmenu) which requires [dmenu](https://tools.suckless.org/dmenu/), [xsel](http://www.vergenet.net/~conrad/software/xsel/) and [clipnotify](https://github.com/cdown/clipnotify).
All credits goes to the creator of that scripts.

Most of the scripts are written for POSIX compliant shells. All scripts with `/bin/sh` are programmed and tested with [dash](http://gondor.apana.org.au/~herbert/dash/) and are not garanteed to run with [bash](https://www.gnu.org/software/bash/bash.html). How to configure and use dash, can be found [here](https://wiki.archlinux.org/index.php/Dash).

Some scripts in the bin folder require [dmenu](https://tools.suckless.org/dmenu/), [skim](https://github.com/lotabout/skim), [ag](https://github.com/ggreer/the_silver_searcher), [fd](https://github.com/sharkdp/fd) and [ripgrep](https://github.com/BurntSushi/ripgrep).
Also [twitch-notify](bin/croncmds/twitch-notify.py) and [github-notify](bin/croncmds/github-notify.py) require [python-notify2](https://pypi.org/project/notify2/).

## Zsh

Zsh is configured similar to bash and offers [syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) when installed.
If you ran into problems check the path of both extensions. It is possible that it has to be changed for your system.

## Vim

- [Neovim](https://github.com/neovim/neovim/) >= 0.5 required. (Probobly nightly build)
- [pyneovim](https://github.com/neovim/pynvim) (Python client for Neovim)

When neovim is started for the first time, vim-plug is downloaded and `:PlugInstall` is executed.
To update plugins use `:PlugUpdate` and to upgrade vim-plug run `:PlugUpgrade`.
All further commands can be found on [here](https://github.com/junegunn/vim-plug).

A full list of used plugins:

| Plugin                                                                                     | Description                                                                                     |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- |
| [gruvbox](https://github.com/morhetz/gruvbox)                                              | gruvbox colorscheme                                                                             |
| [signature](https://github.com/kshenoy/vim-signature)                                      | Plugin to toggle, display and navigate marks                                                    |
| [git-messenger](https://github.com/rhysd/git-messenger.vim)                                | Show git messages with `<leader>gm`. Using nvim-floating-window                                 |
| [gitignore highlighting](https://github.com/gisphm/vim-gitignore)                          | gitignore highlighting support                                                                  |
| [comment.nvim](https://github.com/numToStr/comment.nvim)                                   | comment stuff out with `gcc` to comment out line and `gc` in visual mode                        |
| [scriptease.vim](https://github.com/tpope/vim-scriptease)                                  | Vim plugin for making Vim plugins. Loads `:messages` into quickfix list                         |
| [tabular](https://github.com/godlygeek/tabular)                                            | Helps with aligning text                                                                        |
| [devicons](https://github.com/kyazdani42/nvim-web-devicons)                                | lua `fork` of vim-web-devicons for neovim                                                       |
| [sql](https://github.com/tami5/sql.nvim)                                                   | sqlite3 bindings written in lua                                                                 |
| [startify](https://github.com/mhinz/vim-startify)                                          | The fancy start screen for Vim with session support                                             |
| [plenary](https://github.com/nvim-lua/plenary.nvim)                                        | All the lua functions I don't want to write twice.                                              |
| [telescope](https://github.com/nvim-telescope/telescope.nvim)                              | Find, Filter, Preview, Pick. Fuzzyfinder written in Lua, with providers for treesitter and lsp  |
| [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)        | Native fzf sorter for telescope                                                                 |
| [telescope-symbols](https://github.com/nvim-telescope/telescope-symbols.nvim)              | symbol data for telescope                                                                       |
| [telescope-frecency](https://github.com/nvim-telescope/telescope-frecency.nvim)            | Smart MRU for telescope                                                                         |
| [telescope-smart-history](https://github.com/nvim-telescope/telescope-smart-history.nvim)  | Smart history replacement for the telescope builtin history                                     |
| [telescope-ui-select](https://github.com/nvim-telescope/telescope-ui-select.nvim)          | telescope ui select hook                                                                        |
| [octo](https://github.com/pwntester/octo.nvim)                                             | Github integration in neovim. With telescope integration                                        |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)                                     | Git signs written in pure lua                                                                   |
| [notify](https://github.com/rcarriga/nvim-notify)                                          | neovim notification system                                                                      |
| [goyo](https://github.com/junegunn/goyo.vim)                                               | Distraction-free writing in Vim                                                                 |
| [vimwiki](https://github.com/vimwiki/vimwiki)                                              | Personal Wiki for Vim                                                                           |
| [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                           | Currently used for Syntax highlighting and incremental selection.                               |
| [treesitter-refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)         | Adds Refactor module to Treesitter. Highlight definition, smart rename and more.                |
| [treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)   | Adds Textobjects based on treesitter                                                            |
| [treesitter playground](https://github.com/nvim-treesitter/playground)                     | Treesitter playground integrated into Neovim. Interactive Debugging tool for Treesitter         |
| [treesitter-lua](https://github.com/tjdevries/tree-sitter-lua)                             | Treesitter lua grammar                                                                          |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                 | Providing config for built-in lsp                                                               |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                            | Completion engine                                                                               |
| [nvim-cmp-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                                    | Lsp source for completion engine                                                                |
| [nvim-cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                   | Buffer source for completion engine                                                             |
| [nvim-cmp-path](https://github.com/hrsh7th/cmp-path)                                       | Path source for completion engine                                                               |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                             | Snippets plugin                                                                                 |
| [cmp-luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                                 | Snippets source for completion plugin                                                           |
| [lsp extensions](https://github.com/tjdevries/lsp_extensions.nvim)                         | Adds more lsp stuff. Example: Inlay hints                                                       |
| [lightbulb](https://github.com/kosayoda/nvim-lightbulb)                                    | Show lightbulb when there is a code action at the current line                                  |
| [dap](https://github.com/mfussenegger/nvim-dap)                                            | Debug Adapter Protocol client implementation for Neovim                                         |
| [dap virtual text](https://github.com/theHamsta/nvim-dap-virtual-text)                     | Displayes virtual text coming from dap using treesitter                                         |
| [nvim lua debug](https://github.com/jbyuki/one-small-step-for-vimkind)                     | Debug lua neovim code in neovim                                                                 |
| [colorizer](https://github.com/norcalli/nvim-colorizer.lua)                                | Adds color to hexcodes                                                                          |

Some plugins require additional packages installed:

- telescope requires [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) to work best.
- Already preconfigured LSP Server. Install one or more of the listed Servers and you are good to go for the specific language (setup can be verified with `:checkhealth`):
  - [als](https://github.com/AdaCore/ada_language_server) for ada.
  - [bashls](https://github.com/bash-lsp/bash-language-server) for bash and posix compliant shells.
  - [clangd](https://clangd.llvm.org/) for c/c++. [ccls](https://github.com/MaskRay/ccls) is currently disabled because clangd offers option to switch between header and source file.
  - [cmake](https://github.com/regen100/cmake-language-server) for cmake
  - [cssls](https://github.com/vscode-langservers/vscode-css-languageserver-bin) for css files
  - [diagnosticls](https://github.com/iamcco/diagnostic-languageserver) to get linter data. Currently configured with shellcheck.
  - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs) for dockerfiles
  - [elixirls](https://github.com/elixir-lsp/elixir-ls) for Elixir
  - [flow](https://github.com/facebook/flow) for JavaScript
  - [fortls](https://github.com/hansec/fortran-language-server) for Fortran
  - [gopls](https://github.com/golang/tools/tree/master/gopls) for golang
  - [html](https://github.com/vscode-langservers/vscode-html-languageserver-bin) for html
  - [jsonls](https://github.com/vscode-langservers/vscode-json-languageserver) for json
  - [kotlin_language_server](https://github.com/fwcd/kotlin-language-server) for kotlin
  - [metals](https://scalameta.org/metals/) for scala
  - Using [pyls_ms](https://github.com/Microsoft/python-language-server) if installed and [pyls](https://github.com/palantir/python-language-server) as fallback for python
  - [R_language_server](https://github.com/REditorSupport/languageserver) for R
  - Using [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer) if installed and [rls](https://github.com/rust-lang/rls) as fallback for rust
  - [solargraph](https://solargraph.org/) for ruby
  - [sumneko lua](https://github.com/sumneko/lua-language-server) for lua
  - [sqlls](https://github.com/joe-re/sql-language-server) for sql
  - [texlab](https://github.com/latex-lsp/texlab) for latex
  - [tsserver](https://github.com/theia-ide/typescript-language-server) for TypeScript
  - [vimls](https://github.com/iamcco/vim-language-server) for vimlang
  - additional language server can be configured [here](.config/nvim/lua/module/lsp.lua). Take a look at [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
