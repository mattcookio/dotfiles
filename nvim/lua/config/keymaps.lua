----------------------------------------
-- Git Operations (g)
----------------------------------------

-- Open lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true, desc = "Lazygit" })

----------------------------------------
-- Editor Operations (e)
----------------------------------------

-- Quick save and quit Neovim entirely
vim.keymap.set('n', '<leader>wq', '<cmd>wqall<cr>', { desc = "Save and Quit Neovim" })

-- Force quit Neovim entirely without saving
vim.keymap.set('n', '<leader>q', '<cmd>qall!<cr>', { desc = "Force Quit Neovim" })

-- Save file
vim.keymap.set('n', '<leader>w', function()
  vim.cmd('w')
  vim.notify('File saved!', vim.log.levels.INFO)
end, { desc = "Save File" })

-- Create standard splits (non-buff.nvim versions)
vim.keymap.set('n', '_', function()
  vim.cmd('split')    -- Create horizontal split
  vim.cmd('wincmd j') -- Move to the new split
  vim.cmd('enew')     -- Create empty buffer
end, { desc = 'Horizontal split with empty buffer' })

vim.keymap.set('n', '|', function()
  vim.cmd('vsplit')   -- Create vertical split
  vim.cmd('wincmd l') -- Move to the new split
  vim.cmd('enew')     -- Create empty buffer
end, { desc = 'Vertical split with empty buffer' })

-- Close all splits except current (like ba for buffers)
vim.keymap.set('n', '<leader>so', function()
  vim.cmd('only')
end, { desc = 'Close All Other Splits' })

----------------------------------------
-- Buffer and Split Management
----------------------------------------

-- Basic buffer navigation with Alt/Option keys
vim.keymap.set('n', '˙', '<cmd>bprevious!<CR>', { noremap = true, silent = true }) -- Mac Option-h
vim.keymap.set('n', '¬', '<cmd>bnext!<CR>', { noremap = true, silent = true }) -- Mac Option-l
vim.keymap.set('n', '<A-h>', '<cmd>bprevious!<CR>', { noremap = true, silent = true }) -- Windows/Linux Alt-h
vim.keymap.set('n', '<A-l>', '<cmd>bnext!<CR>', { noremap = true, silent = true }) -- Windows/Linux Alt-l

-- Split navigation with Cmd+Ctrl/Super+Ctrl
vim.keymap.set('n', '<D-C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<D-C-l>', '<C-w>l', { desc = 'Move to right split' })
vim.keymap.set('n', '<D-C-k>', '<C-w>k', { desc = 'Move to upper split' })
vim.keymap.set('n', '<D-C-j>', '<C-w>j', { desc = 'Move to lower split' })


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

------------------------------------
-- Appearance Operations (a) -------
------------------------------------

-- Toggle both Goyo and Twilight together
vim.keymap.set("n", "<leader>az", function()
  vim.cmd("Goyo")
  vim.cmd("Twilight")
end, { desc = "Toggle Goyo and Twilight" })

-- Toggle line numbers
vim.keymap.set("n", "<leader>an", function()
  if vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
  else
    vim.o.number = true
    vim.o.relativenumber = true
  end
end, { desc = "Toggle Line Numbers" })

----------------------------------------
-- Misc.
----------------------------------------

vim.keymap.set("v", "<Tab>", ">gv")   -- Tab to indent in visual mode
vim.keymap.set("v", "<S-Tab>", "<gv") -- Shift-Tab to unindent in visual mode
