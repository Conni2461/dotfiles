RELOAD = require('plenary.reload').reload_module

require('module/treesitter')
require('module/lsp')
require('module/telescope')
require('module/snippets')
require('module/dap')

-- Might move into own module
require'colorizer'.setup()
