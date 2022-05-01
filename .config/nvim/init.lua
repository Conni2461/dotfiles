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

require "module.treesitter"
require "module.lsp"
require "module.telescope"
require "module.newsnip"
require "module.dap"

require("module.simpleline").init()
-- require("module.gtest").setup()
