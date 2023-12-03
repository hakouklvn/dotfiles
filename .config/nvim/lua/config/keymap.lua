vim.g.mapleader = " "

-- Insert mode
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'kj', '<ESC>')
vim.keymap.set('i', '<C-E>', '<ESC>A')
vim.keymap.set('i', '<C-A>', '<ESC>I')

-- Normal mode
vim.keymap.set('n', '<leader>op', ':NvimTreeToggle<cr>')
vim.keymap.set("n", "<leader>gg", ":Neogit<cr>")
vim.keymap.set("n", "<leader>bk", ":bdelete<cr>")
vim.keymap.set("n", "<leader>bs", ":w<cr>")
vim.keymap.set("n", "gt", ":bNext<cr>")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Visual mode
vim.keymap.set("v", 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set("v", 'J', ":m '>+1<CR>gv=gv")

-- greatest map ever
vim.keymap.set("x", 'p', "\"_dP")
