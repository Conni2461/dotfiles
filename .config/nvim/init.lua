-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require "module.plugins"

RELOAD = require("plenary.reload").reload_module
R = function(x)
  RELOAD(x)
  return require(x)
end

P = function(...)
  print(vim.inspect(...))
end

require "module.general"

vim.defer_fn(function()
  require "module.treesitter"
end, 0)
require "module.lsp"
require "module.telescope"
require "module.newsnip"
-- require "module.dap"

require("module.simpleline").init()
-- require("module.gtest").setup()
