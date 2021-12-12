RELOAD = require('plenary.reload').reload_module
RTELE = function()
  RELOAD('module.telescope')
  RELOAD('telescope')
end

P = function(...) print(vim.inspect(...)) end

require('module.treesitter')
require('module.lsp')
require('module.telescope')
require('module.newsnip')
require('module.dap')

require("module.simpleline").init()
require("module.gtest").setup()

require("colorizer").setup()
require('gitsigns').setup()

vim.notify = require("notify")
vim.api.nvim_set_keymap("n", "<leader>af", ":lua require('module.formatf').run()<CR>", { noremap = true, })

require("Comment.ft").set("lua", { "--%s", "--[[%s]]" })
require("Comment").setup {
  ignore = nil,
  opleader = {
    line = "gc",
    block = "gb",
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  post_hook = nil,
}
