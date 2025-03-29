----------------------------------------
-- File/Find Operations (f)
----------------------------------------

-- Open file explorer
vim.keymap.set("n", "<leader>fe", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, {
  desc = "Explorer (mini.files)",
  silent = true
})

-- Open file picker
vim.keymap.set("n", "<leader>ff", function()
  MiniPick.builtin.files({ source = { cwd = vim.fn.getcwd() } })
end, {
  desc = "Find Files",
  silent = true
})

----------------------------------------
-- Git Operations (g)
----------------------------------------

-- Open lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true, desc = "Lazygit" })
