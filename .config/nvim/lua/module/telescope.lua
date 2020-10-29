require('telescope').setup {
  defaults = {
    layout_strategy = "flex",
    winblend = 5,
    color_devicons = false,
    generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
  }
}
