local startify = require "alpha.themes.startify"

startify.file_icons.provider = "devicons"

startify.section.top_buttons.val = {
  startify.button("e", "New file", "<cmd>ene <CR>"),
  startify.button("z", "~/.zshrc", "<cmd>e ~/.zshrc <CR>"),
  startify.button("c", "init.lua", "<cmd>e ~/.config/nvim/init.lua <CR>"),
}

startify.mru_sections = { "mru_cwd", "mru" }

startify.section.footer.val = {
  { type = "padding", val = 1 },
  { type = "text", val = '   Vim is charityware. Please read ":help uganda".', opts = { hl = "Comment" } },
}

require("alpha").setup(startify.config)
