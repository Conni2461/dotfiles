local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

local conf = require('telescope.config').values

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    -- sorting_strategy = 'ascending',
    winblend = 5,
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    color_devicons = true,
    -- set_env = { ['COLORTERM'] = 'truecolor', LESS = '-SMR' },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  },
  extensions = {
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*", "*.foo"},
      workspaces = {
        ["conf"]    = "/home/conni/.config",
        ["nvim"]    = "/home/conni/.config/nvim/plugged",
        ["data"]    = "/home/conni/.local/share",
        ["project"] = "/home/conni/repos",
      }
    }
  }
}

telescope.load_extension('fzy_native')
telescope.load_extension('dap')
telescope.load_extension('frecency')
telescope.load_extension('bibtex')

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
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        local bib = vim.split(selection.display, ':')[1]
        vim.cmd('read !loadbib -g ' .. bib)
      end)

      return true
    end
  }):find()
end

M.show_diagnostics = function()
  vim.lsp.diagnostic.set_loclist({open_loclist = false})
  require'telescope.builtin'.loclist{}
end

return M
