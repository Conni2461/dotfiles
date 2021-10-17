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

vim.ui.select = function(items, opts, on_choice)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  pickers.new({}, {
    prompt_title = opts.prompt,
    finder = finders.new_table {
      results = items,
      entry_maker = function(e)
        return {
          value = e,
          display = opts.format_item(e),
          ordinal = opts.format_item(e),
        }
      end,
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry().value
        on_choice(selection)
      end)
      return true
    end,
    sorter = conf.generic_sorter({}),
  }):find()
end
