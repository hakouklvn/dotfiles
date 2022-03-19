local wk = require("which-key")

local mappings = {
  q = {":wq<cr>", "Save & Quit"},
  w = {":w<cr>", "Save"},
  c = {":bdelete<cr>", "Close"},
}

local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
