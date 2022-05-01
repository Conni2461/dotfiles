vim.g.startify_lists = {
  { type = "files", header = { "   MRU" } },
  { type = "dir", header = { "   MRU " .. vim.fn.getcwd() } },
  { type = "sessions", header = { "   Sessions" } },
  { type = "bookmarks", header = { "   Bookmarks" } },
}

vim.g.startify_bookmarks = {
  "~/.zshrc",
  "~/.config/nvim/init.vim",
}

vim.g.startify_skiplist = {
  "COMMIT_EDITMSG",
}

vim.g.startify_custom_footer = {
  "",
  "   Vim is charityware. Please read ':help uganda'.",
  "",
}

vim.g.startify_session_dir = vim.fn.expand "~/.local/share/nvim/session"
vim.g.startify_session_autoload = "no"
vim.g.startify_change_to_dir = 0

vim.keymap.set("n", "<leader>so", ":SLoad<Space>", { noremap = true })
vim.keymap.set("n", "<leader>ss", ":SSave<Space>", { noremap = true })
vim.keymap.set("n", "<leader>sd", ":SDelete<CR>", { noremap = true })
vim.keymap.set("n", "<leader>sc", ":SClose<CR>", { noremap = true })
