local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
pylint_init_hook="\"import pylint_venv; pylint_venv.inithook(quiet=True)\""
null_ls.setup({
    debug = true,
    sources = {
        -- add sources for formatting here. Ex: prettier
        formatting.black,
        diagnostics.pylint.with({
            args = { "$FILENAME", "-f", "json" },
            extra_args = { "--errors-only", "--init-hook", pylint_init_hook},
            diagnostics_postprocess = function(diagnostic)
                diagnostic.code = diagnostic.message_id
            end,
        }),
        formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
        formatting.clang_format.with({ args = { "-style", "file" } }),
        null_ls.builtins.formatting.gofmt,
        diagnostics.revive
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
