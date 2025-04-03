----------------------------------------
-- Git Operations (g)
----------------------------------------

-- Open lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true, desc = "Lazygit" })

----------------------------------------
-- Editor Operations (e)
----------------------------------------

-- Quick save and quit
vim.keymap.set('n', '<leader>wq', '<cmd>wq<cr>', { desc = "Save and Quit" })

-- Force quit without saving
vim.keymap.set('n', '<leader>q', '<cmd>q!<cr>', { desc = "Force Quit" })

-- Save file
vim.keymap.set('n', '<leader>w', function()
  vim.cmd('w')
  vim.notify('File saved!', vim.log.levels.INFO)
end, { desc = "Save File" })

----------------------------------------
-- Lazy Operations (l)
----------------------------------------

-- Sync
vim.keymap.set('n', '<leader>ls', ':Lazy sync<CR>', { noremap = true, silent = true, desc = "Lazy Sync" })

-- Reload configuration
vim.keymap.set('n', '<leader>lr', function()
  -- Source all lua files in config
  for _, file in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. '/lua/**/*.lua', false, true)) do
    dofile(file)
  end
  -- Source init.lua
  dofile(vim.fn.stdpath('config') .. '/init.lua')
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end, { desc = '[R]eload [C]onfiguration' })

