-- With feedback message
vim.keymap.set('n', '<leader>cd', function()
    vim.cmd.lcd(vim.fn.expand('%:p:h'))
    vim.notify('Changed directory to: ' .. vim.fn.getcwd())
end, { desc = "Change directory to current file" })

vim.keymap.set("n", "<leader>fe", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, {
    desc = "Open mini.files",
    silent = true
})

vim.keymap.set("n", "<leader>ff", function()
    MiniPick.builtin.files({ source = { cwd = vim.fn.getcwd() } })
end, {
    desc = "Open file picker",
    silent = true
})

local jump = require('mini.jump2d')

-- Two character search
vim.keymap.set("n", "<leader><leader>", function()
    jump.start()
end, { desc = "Jump2D" })
