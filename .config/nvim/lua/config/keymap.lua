vim.g.mapleader = " "

-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- exit insert mode
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

map('n', 'K', ':lua vim.lsp.buf.hover()<cr>')
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
map('n', '<leader>op', ':NvimTreeToggle<cr>')
