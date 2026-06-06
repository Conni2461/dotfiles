local ts = require "nvim-treesitter"

ts.setup()

ts.install {
  "bash",
  "bibtex",
  "c",
  "c_sharp",
  "clojure",
  "cmake",
  "comment",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "doxygen",
  "fennel",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "glimmer",
  "go",
  "gomod",
  "gosum",
  "graphql",
  "hcl",
  "html",
  "htmldjango",
  "http",
  "ini",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "julia",
  "kotlin",
  "latex",
  "make",
  "nginx",
  "nix",
  "php",
  "prisma",
  "proto",
  "python",
  "ql",
  "query",
  "r",
  "regex",
  "requirements",
  "ruby",
  "rust",
  "sql",
  "ssh_config",
  "strace",
  "svelte",
  "terraform",
  "toml",
  "tsx",
  "twig",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
  "zig",
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldenable = false

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
