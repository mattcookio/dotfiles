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

-- Go to next buffer
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })

-- Go to previous buffer
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true })

-- Close current buffer
vim.keymap.set('n', '<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype == 'terminal' then
    vim.cmd('q')
  else
    vim.cmd('bd')
  end
end, { desc = "Close Buffer" })

-- Close all other buffers
vim.keymap.set('n', '<leader>bo', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype == 'terminal' then
    vim.cmd('q')
  else
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end, { desc = "Close Other Buffers" })

-- Close all buffers
vim.keymap.set('n', '<leader>ba', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype == 'terminal' then
    vim.cmd('q')
  else
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end, { desc = "Close All Buffers" })

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

