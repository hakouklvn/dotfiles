require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.formatting.gofmt,
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.astyle,
    require("null-ls").builtins.formatting.lua_formtat,
    require("null-ls").builtins.formatting.clang_format,
    require("null-ls").builtins.formatting.cmake_format,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.completion.spell,
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
