RELOAD = require('plenary.reload').reload_module
RTELE = function()
  RELOAD('module/telescope')
  RELOAD('telescope')
end

P = function(...) print(vim.inspect(...)) end

require('module/treesitter')
require('module/lsp')
require('module/telescope')
require('module/snippets')
require('module/dap')
require('module/signs')

-- Might move into own module
require'colorizer'.setup()
