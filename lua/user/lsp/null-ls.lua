local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        -- add sources for formatting here. Ex: prettier
        --[[ formatting.black, ]]
        formatting.autopep8,
        diagnostics.pylint.with({
            extra_args = { "--errors-only" },
            diagnostics_postprocess = function(diagnostic)
                diagnostic.code = diagnostic.message_id
            end,
        }),
        formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
        formatting.clang_format.with({ args = { "-style", "file" } }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
