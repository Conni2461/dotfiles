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
require('module.signs')

require("module.simpleline").init()
require("module.gtest").setup()

-- Might move into own module
require("colorizer").setup()

vim.notify = require("notify")
vim.api.nvim_set_keymap("n", "<leader>af", ":lua require('module.formatf').run()<CR>", { noremap = true, })
