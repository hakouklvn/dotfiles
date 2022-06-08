local null_ls = require("null-ls");
local formatting = null_ls.builtins.formatting;
local diagnostics = null_ls.builtins.diagnostics;

null_ls.setup({
  sources = {
    formatting.stylua,
    formatting.black,
    formatting.prettier,
    formatting.gofmt,
    formatting.shfmt,
    formatting.astyle,
    -- formatting.lua_formtat,
    formatting.clang_format,
    formatting.cmake_format,
    formatting.isort,
    diagnostics.eslint,
    null_ls.builtins.completion.spell,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
          augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
        ]])
    end
  end,
})
