vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

-- moves between panes 
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

-- press ii to exit from insert mode
map('i', 'ii', '<Esc>', {noremap = true, silent = false})

-- open/close sidebar
map('n', '<C-b>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- add tab or remove tabs
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

-- open telescope
map('n', '<C-p>', ':Telescope find_files<CR>', {noremap = true, silent = true})
map('n', '<C-f>', ':Telescope live_grep<CR>', {noremap = true, silent = true})
