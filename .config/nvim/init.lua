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

require "module.lsp"
require "module.telescope"

require("module.simpleline").init()
