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

require("module.simpleline").init()

-- Might move into own module
require("colorizer").setup()
require("shade").setup({
  overlay_opacity = 75,
  opacity_step = 1,
  keys = {
    toggle = '<Leader>ll',
  }
})

require('symbols-outline').setup{
  highlight_hovered_item = true,
  show_guides = true,
}
