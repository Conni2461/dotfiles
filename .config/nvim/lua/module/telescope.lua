local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local Job = require('plenary.job')

local conf = require('telescope.config').values

-- local transform_mod = require('telescope.actions.mt').transform_mod

-- -- or create your custom action
-- local my_cool_custom_action = transform_mod({
--   x = function(prompt_bufnr)
--     print(prompt_bufnr)
--   end,
-- })

-- local new_maker = function(filepath, bufnr, opts)
--   filepath = vim.fn.expand(filepath)
--   Job:new({
--     command = 'file',
--     args = { '--mime-type', '-b', filepath },
--     on_exit = function(j)
--       local mime_type = vim.split(j:result()[1], '/')[1]
--       if mime_type == "text" then
--         previewers.buffer_previewer_maker(filepath, bufnr, opts)
--       else
--         vim.schedule(function()
--           vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
--         end)
--       end
--     end
--   }):sync()
-- end

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    -- prompt_position = "top",
    -- sorting_strategy = 'ascending',
    -- buffer_previewer_maker = new_maker,
    winblend = 0,
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
        mirror = false,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
        mirror = true,
      }
    },
    mappings = {
      i = {
        -- ["<C-s>"] = actions.cycle_previewers_next,
        -- ["<C-a>"] = actions.cycle_previewers_prev,

        -- ["<C-n>"] = actions.cycle_history_next,
        -- ["<C-p>"] = actions.cycle_history_prev,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, -- + my_cool_custom_action.x,
        ["<a-q>"] = false,
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = { 'tags', 'src/parser.c' },
    color_devicons = true,
    -- dynamic_preview_title = false,
    -- history_handler = require('telescope.actions.history').get_smart_history,
    -- history_location = '~/.local/share/nvim/databases/telescope_history.sqlite3',
    -- history_limit = 100,
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

telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('octo')

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

M.my_fd = function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require'telescope.builtin'.find_files(opts)
end

return M
