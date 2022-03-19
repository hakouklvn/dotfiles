require"lsp-format".setup {
  typescript = { tab_width = 4 },
  yaml = { tab_width = 2 },
  html = { tab_width = 2 },
  css = { tab_width = 2 },
  python = { tab_width = 4 },
  java = { tab_width = 2 },
}

local prettier = {
    formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
    formatStdin = true,
}

require"lspconfig".efm.setup {
    on_attach = require "lsp-format".on_attach,
    init_options = { documentFormatting = true },
    settings = {
        languages = {
            typescript = { prettier },
            yaml = { prettier },
            html = { prettier },
            css = { prettier },
            python = { prettier },
            java = { prettier },
        },
    },
}


vim.cmd [[cabbrev w execute "lua vim.lsp.buf.formatting_seq_sync()" <bar> w]]

