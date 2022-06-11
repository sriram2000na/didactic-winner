local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

null_ls.setup({
    sources = {
        -- add sources for formatting here. Ex: prettier
        formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
        formatting.clang_format.with({ args = { "-style", "file" } }),
    }
})
