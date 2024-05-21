require('lint').linters_by_ft = {
    go = {"revive"}

}

local revive = require('lint').linters.revive
project_dir = vim.fs.dirname(vim.fs.find({".revive.toml"}, { upward = true })[1])
revive.args = {
    "-config",
    project_dir.."/.revive.toml",
    vim.fn.expand("%")
}

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
