RELOAD = require('plenary.reload').reload_module

require('module/treesitter')
require('module/lsp')
require('module/telescope')
require('module/snippets')

-- Might move into own module
require'colorizer'.setup()
