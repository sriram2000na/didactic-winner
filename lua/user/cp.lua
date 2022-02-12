local Terminal = require("toggleterm.terminal").Terminal
function wrapper(cpcommand)
	vim.cmd("w")
	cpcommand = cpcommand .. vim.fn.expand("%")
	local term = Terminal:new({
		direction = "horizontal",
		size = 10,
		-- close_on
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			local tosend = {
				"source ~/Desktop/pgrm/cp/compile.sh",
				cpcommand,
			}
			-- print(vim.inspect(term))
			for i = 1, #tosend do
				vim.cmd(string.format('%sTermExec cmd="%s" go_back=0', term.id, tosend[i]))
			end
		end,
	})
	return term
end
function prepare()
	command = "prep "
	wrapper(command):toggle()
end

function compile()
	command = "comp "
	wrapper(command):toggle()
end

function compileRun()
	command = "compr "
	wrapper(command):toggle()
end

function compileSubmit()
	command = "comps "
	wrapper(command):toggle()
end

function compileSubmitRun()
	command = "compsr "
	wrapper(command):toggle()
end

function onlyRun()
	command = "runc "
	wrapper(command):toggle()
end

-- function runcin()
-- 	file = vim.fn.expand("%")
-- 	command = "runcin " .. file
-- 	wrapper(command):toggle()
-- end
--
-- function full()
-- 	file = vim.fn.expand("%")
-- 	command = "runcin " .. file
-- 	wrapper(command):toggle()
-- end
