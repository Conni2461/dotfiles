local telescope = require "telescope"
local actions = require "telescope.actions"
local actions_layout = require "telescope.actions.layout"

telescope.setup {
  defaults = {
    multi_icon = "",
    layout_strategy = "flex",
    scroll_strategy = "cycle",
    selection_strategy = "reset",
    winblend = 0,
    layout_config = {
      vertical = {
        mirror = true,
      },
      center = {
        mirror = true,
      },
    },
    hl_result_eol = false,
    preview = {
      msg_bg_fillchar = " ",
    },
    cache = false,
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,

        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
        ["<C-h>"] = actions_layout.toggle_preview,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<a-q>"] = false,
        ["<c-c>"] = function()
          vim.cmd [[stopinsert]]
        end,
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = { "src/parser.c" },
    dynamic_preview_title = true,
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
      previewer = false,
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      },
    },
    man_pages = { sections = { "2", "3" } },
    lsp_references = { path_display = { "shorten" } },
    lsp_document_symbols = { path_display = { "hidden" } },
    lsp_workspace_symbols = { path_display = { "shorten" } },
    lsp_code_actions = { theme = "dropdown" },
    current_buffer_fuzzy_find = { theme = "dropdown" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
    frecency = {
      persistent_filter = false,
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*", "*.foo" },
      workspaces = {
        ["conf"] = "/home/conni/.config",
        ["nvim"] = "/home/conni/.config/nvim/plugged",
        ["data"] = "/home/conni/.local/share",
        ["project"] = "/home/conni/repos",
      },
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "ui-select"
-- telescope.load_extension "smart_history"
-- telescope.load_extension "frecency"

vim.keymap.set("n", "<leader>w", R("telescope.builtin").git_files, { noremap = true })
vim.keymap.set("n", "<leader>q", R("telescope.builtin").find_files, { noremap = true })
vim.keymap.set("n", "<leader>gp", R("telescope.builtin").live_grep, { noremap = true })
vim.keymap.set("n", "<leader>gw", function()
  R("telescope.builtin").grep_string { word_match = "-w" }
end, { noremap = true })
vim.keymap.set("n", "<leader>gs", function()
  R("telescope.builtin").grep_string { search = vim.fn.input "Grep For >" }
end, { noremap = true })
vim.keymap.set("n", "<leader>bg", R("telescope.builtin").buffers, { noremap = true })
vim.keymap.set("n", "<leader>bs", R("telescope.builtin").current_buffer_fuzzy_find, { noremap = true })
