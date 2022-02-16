local function wrapper(cpcommand)
	vim.cmd("w")
	vim.cmd("FloatermKill cpterm")
	cpcommand = cpcommand .. vim.fn.expand("%") .. " && exit"
	vim.cmd("lcd %:p:h")
	tosend = { "source ~/Desktop/pgrm/cp/compile.sh", cpcommand }
	vim.cmd("FloatermNew --name=cpterm --wintype=split --position=botright --height=0.4 --silent --autoclose=0")
	for i = 1, #tosend do
		vim.cmd(string.format("FloatermSend %s", tosend[i]))
	end
	vim.cmd("FloatermToggle")
end
function compileRun()
	wrapper("compr ")
end
