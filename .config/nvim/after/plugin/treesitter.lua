local configs = require'nvim-treesitter.configs'

configs.setup {
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    }
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
