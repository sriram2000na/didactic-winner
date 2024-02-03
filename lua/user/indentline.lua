local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	return
end

-- vim.g.indentLine_enabled = 1
-- vim.g.indent_blankline_char = "│"
-- vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_char = "▎"
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = true
-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {
-- 	"class",
-- 	"return",
-- 	"function",
-- 	"method",
-- 	"^if",
-- 	"^while",
-- 	"jsx_element",
-- 	"^for",
-- 	"^object",
-- 	"^table",
-- 	"block",
-- 	"arguments",
-- 	"if_statement",
-- 	"else_clause",
-- 	"jsx_element",
-- 	"jsx_self_closing_element",
-- 	"try_statement",
-- 	"catch_clause",
-- 	"import_statement",
-- 	"operation_type",
-- }

--
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"
config = {
            indent = { char = "▏" },
            exclude = {
                filetypes = { "NvimTree", "help", "startify", "dashboard", "packer", "neogitstatus", "Trouble" },
                buftypes = { "terminal" , "nofile"},
            },
            scope = { enabled = false, }
         }

-- indent_blankline.setup({
-- 	-- show_end_of_line = true,
-- 	-- space_char_blankline = " ",
-- 	show_current_context = true,
-- 	-- show_current_context_start = true,
-- 	-- char_highlight_list = {
-- 	--   "IndentBlanklineIndent1",
-- 	--   "IndentBlanklineIndent2",
-- 	--   "IndentBlanklineIndent3",
-- 	-- },
-- })
indent_blankline.setup(config)


local hooks = require "ibl.hooks"
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register( hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
