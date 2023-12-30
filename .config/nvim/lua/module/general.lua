-- Basic
vim.o.mouse = "a"
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false
vim.o.scrolloff = 2
vim.o.updatetime = 300

vim.wo.signcolumn = "yes"
vim.wo.colorcolumn = "80"
vim.wo.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.breakindent = true

vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.listchars = "tab:¦ "
vim.o.list = true

vim.wo.foldenable = true
vim.wo.foldmethod = "indent"
vim.o.foldlevelstart = 99

vim.o.inccommand = "split"

-- History
vim.o.history = 1000
vim.bo.undofile = true
vim.o.undodir = vim.fn.expand "~/.local/share/nvim/undo"
vim.o.undolevels = 100
vim.o.undoreload = 1000
vim.o.backupdir = vim.fn.expand "~/.local/share/nvim/backup/"
vim.o.directory = vim.fn.expand "~/.local/share/nvim/backup/"

vim.keymap.set("i", "jk", "<esc>", { silent = true })

vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.keymap.set("n", "G", "&wrap  ? 'G$g0' : 'G'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "0", "&wrap  ? 'g0' : '0'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "$", "&wrap  ? 'g$' : '$'", { noremap = true, expr = true, silent = true })

vim.keymap.set("n", "H", "0", { noremap = true, silent = true })
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })

vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "S",
  [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]],
  { noremap = true, silent = true }
)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("n", "<leader>k", ":m .-2<cr>==", { noremap = true })
vim.keymap.set("n", "<leader>j", ":m .+1<cr>==", { noremap = true })

vim.keymap.set("n", "<leader>le", ":setlocal spell! spelllang=en_us<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ld", ":setlocal spell! spelllang=de_de<CR>", { noremap = true })
vim.keymap.set("n", "<leader>lf", ":setlocal spell! spelllang=en_us,de_de<CR>", { noremap = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("n", "<leader>x", function()
  vim.cmd [[
    silent! write
    source %
  ]]
end, { noremap = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("i", ",", ",<c-g>u", { noremap = true })
vim.keymap.set("i", ".", ".<c-g>u", { noremap = true })
vim.keymap.set("i", "!", "!<c-g>u", { noremap = true })
vim.keymap.set("i", "?", "?<c-g>u", { noremap = true })

vim.keymap.set("n", "<leader>af", require("module.formatf").run, { noremap = true })

vim.filetype.add {
  extension = {
    tpp = "cpp",
  },
  filename = {
    SConstructGeneral = "python",
    SConscript = "python",
  },
}

local yank_group = vim.api.nvim_create_augroup("yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {}
  end,
  group = yank_group,
})

local commenting_group = vim.api.nvim_create_augroup("commenting", { clear = true })
vim.api.nvim_create_autocmd(
  "Filetype",
  { pattern = "*", command = "setlocal formatoptions-=cro", group = commenting_group }
)

local terminalmode_group = vim.api.nvim_create_augroup("terminalmode", { clear = true })
vim.api.nvim_create_autocmd(
  "TermOpen",
  { pattern = "*", command = "setlocal nonumber norelativenumber", group = terminalmode_group }
)

local trim = function(pattern)
  local save = vim.fn.winsaveview()
  vim.cmd(string.format("keepjumps keeppatterns silent! %s", pattern))
  vim.fn.winrestview(save)
end

local remove_group = vim.api.nvim_create_augroup("remove", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- trim trailing whitespaces
    trim [[%s/\s\+$//e]]
  end,
  group = remove_group,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- trim trailing lines
    trim [[%s/\($\n\s*\)\+\%$//]]
  end,
  group = remove_group,
})

-- User commands
vim.api.nvim_create_user_command("T", function()
  vim.cmd [[
    botright 15split term://$SHELL
    startinsert
  ]]
end, {})
