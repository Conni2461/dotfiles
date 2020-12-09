local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

local conf = require('telescope.config').values

require('telescope').setup {
  defaults = {
    layout_strategy = "flex",
    scroll_strategy = 'descending',
    winblend = 5,
    color_devicons = false,
    set_env = { ['COLORTERM'] = 'truecolor', LESS = '-SMR' },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('dap')

local M = {}

M.load_bib = function(opts)
  opts = opts or {}
  local handle = io.popen("loadbib -l")
  local results = vim.split(handle:read("*a"), '\n')
  handle:close()

  pickers.new(opts, {
    prompt_title = 'Load bib',
    finder = finders.new_table {
      results = results,
      entry_maker = function(line)
        return {
          ordinal = line,
          display = line,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local read_bib = function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        local bib = vim.split(selection.display, ':')[1]
        vim.cmd('read !loadbib -g ' .. bib)
        vim.cmd [[stopinsert]]
      end

      map('n', '<CR>', read_bib)
      map('i', '<CR>', read_bib)

      return true
    end
  }):find()
end

M.grep_input_string = function(opts)
  local input_string = vim.fn.input("Enter string: ")

  require'telescope.builtin'.grep_string{
    shorten_path = true,
    default_text = input_string
  }
end

M.show_diagnostics = function()
  vim.lsp.diagnostic.set_loclist({open_loclist = false})
  require'telescope.builtin'.loclist{}
end

return M
