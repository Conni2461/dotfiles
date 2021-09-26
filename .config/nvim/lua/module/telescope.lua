local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    winblend = 0,
    layout_config = {
      vertical = {
        mirror = true,
      },
    },
    cache = false,
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,

        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, -- + my_cool_custom_action.x,
        ["<a-q>"] = false,
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = { 'build', 'tags', 'src/parser.c' },
    color_devicons = true,
    -- dynamic_preview_title = true,
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    file_browser = {
      theme = "dropdown",
      previewer = false,
    },
    git_files = {
      theme = "dropdown",
      previewer = false,
    },
    buffers = {
      sort_mru = true,
      theme = "dropdown",
      selection_strategy = "closest",
      previewer = false,
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      }
    },
    lsp_references = { path_display = { "shorten" } },
    lsp_document_symbols = { path_display = { "hidden" } },
    lsp_workspace_symbols = { path_display = { "shorten" } },
    lsp_code_actions = { theme = "dropdown" },
    current_buffer_fuzzy_find = { theme = "dropdown", previewer = false },
  },
  extensions = {
    frecency = {
      persistent_filter = false,
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

telescope.load_extension('smart_history')
telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('octo')
