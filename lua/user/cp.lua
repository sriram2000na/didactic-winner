function base(term, torun, input, normal)
  vim.cmd('lcd %:p:h')
  local file = vim.fn.expand('%')
  vim.cmd('FloatermNew --name=cpterm --wintype=split --position=botright --height=0.4 --silent')
  if input ~= nil then input = string.format(' %s', input) else input = '' end
  local runs = string.format('%s %s', torun, file) .. input .. ' && exit'
  print(runs, file)

  local tosend = {
    'source ~/Desktop/pgrm/cp/compile.sh',
    runs,
  }
  for i=1,#tosend do
    vim.cmd(string.format('FloatermSend %s', tosend[i]))
  end
  if term then
    vim.cmd('FloatermToggle')
  end
  if normal then
    vim.cmd('stopinsert')
  end
end

function takeinput(succ, fail)
  -- <CR> is considered success => succ will be called 
  -- <Esc> is considered failure => fail will be called 
  vim.cmd('lcd %:p:h')
  local buf = vim.api.nvim_create_buf(false, true)
  local ui = vim.api.nvim_list_uis()[1]
  local width, height = 80, 30
  local opts = {
    relative = 'editor',
    width = 80,
    height = 30,
    col = (ui.width / 2) - (width / 2),
    row = (ui.height / 2) - (height / 2),
  }
  vim.api.nvim_open_win(buf, true, opts)
  vim.cmd('silent !rm in')
  vim.cmd('silent !touch in')
  vim.cmd('edit in')


  local onsucc = ':wq<CR>'
  if succ ~= nil then
    onsucc = onsucc .. string.format(':lua %s()<CR>', succ)
  end

  local onfail = ':q!<CR>'
  if fail ~= nil then
    onfail = onfail .. string.format(':lua %s()<CR>', fail)
  end

  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', onsucc, { noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', onfail, { noremap = true })
end

function prepare()
  base(false, 'prep')
end

function compile()
  base(true, 'comp')
end

function compileRun()
  vim.cmd('w')
  base(true, 'compr')
end

function compileSubmit()
  base(true, 'comps')
end

function compileSubmitRun()
  base(true, 'compsr')
end

function onlyRun()
  base(true, 'runc')
end

function runcin()
  base(true, 'runcin', 'in', true)
end

function full()
  takeinput('runcin')
end
