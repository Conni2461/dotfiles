local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    -- prompt_position = "top",
    -- sorting_strategy = 'ascending',
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

        -- ["<C-Down>"] = actions.cycle_history_next,
        -- ["<C-Up>"] = actions.cycle_history_prev,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, -- + my_cool_custom_action.x,
        ["<a-q>"] = false,
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = { 'build', 'tags', 'src/parser.c' },
    color_devicons = true,
    -- dynamic_preview_title = false,
    -- history_location = '~/.local/share/nvim/databases/telescope_history.sqlite3',
    -- history_limit = 25,
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    git_files = {
      theme = "dropdown",
      previewer = false,
    },
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      }
    },
    lsp_references = { shorten_path = true },
    lsp_document_symbols = { shorten_path = true },
    lsp_workspace_symbols = { shorten_path = true },
    lsp_code_actions = { theme = "dropdown" },
    current_buffer_fuzzy_find = { theme = "dropdown", previewer = false },
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

-- telescope.load_extension('smart_history')
telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('octo')
