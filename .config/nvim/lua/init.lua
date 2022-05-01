RELOAD = require("plenary.reload").reload_module
RTELE = function()
  RELOAD "module.telescope"
  RELOAD "telescope"
end

P = function(...)
  print(vim.inspect(...))
end

require "module.general"

require "module.startify"
require "module.comment"
require "module.treesitter"
require "module.lsp"
require "module.telescope"
require "module.newsnip"
require "module.dap"

require("module.simpleline").init()
require("module.gtest").setup()

require("colorizer").setup()
require("gitsigns").setup()

vim.notify = require "notify"
