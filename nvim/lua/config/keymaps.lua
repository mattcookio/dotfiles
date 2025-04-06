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

-- Load the pivot plugin (renamed from buff)
local pivot = require('pivot')

-- Smart split mappings (creates new split or merges if split exists in that direction)
vim.keymap.set('n', '<leader>sl', function() pivot.smart_split('l') end, { desc = 'Smart split right (or merge)' })
vim.keymap.set('n', '<leader>sh', function() pivot.smart_split('h') end, { desc = 'Smart split left (or merge)' })
vim.keymap.set('n', '<leader>sj', function() pivot.smart_split('j') end, { desc = 'Smart split down (or merge)' })
vim.keymap.set('n', '<leader>sk', function() pivot.smart_split('k') end, { desc = 'Smart split up (or merge)' })

-- Move buffer to adjacent splits
vim.keymap.set('n', '<leader>bh', function() pivot.move_buffer_to_split('h') end, { desc = '[B]uffer to Left Split' })
vim.keymap.set('n', '<leader>bl', function() pivot.move_buffer_to_split('l') end, { desc = '[B]uffer to Right Split' })
vim.keymap.set('n', '<leader>bj', function() pivot.move_buffer_to_split('j') end, { desc = '[B]uffer to Bottom Split' })
vim.keymap.set('n', '<leader>bk', function() pivot.move_buffer_to_split('k') end, { desc = '[B]uffer to Top Split' })

-- Buffer navigation (using pivot)
vim.keymap.set('n', '<C-h>', function() pivot.navigate_all_buffers('prev') end,
  { noremap = true, silent = true, desc = 'Previous buffer (not in other windows)' })
vim.keymap.set('n', '<C-l>', function() pivot.navigate_all_buffers('next') end,
  { noremap = true, silent = true, desc = 'Next buffer (not in other windows)' })

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

-- Buffer operations
vim.keymap.set('n', '<leader>bd', function() pivot.close_buffer() end, { desc = "[B]uffer [D]elete" })
vim.keymap.set('n', '<leader>sd', function() pivot.close_split() end, { desc = "[S]plit [D]elete" })
vim.keymap.set('n', '<leader>bo', function() pivot.close_other_buffers() end, { desc = "[O]ther [B]uffers" })
vim.keymap.set('n', '<leader>ba', function() pivot.close_all_buffers() end, { desc = "[A]ll [B]uffers" })

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

-- Toggle both Goyo and Twilight
vim.keymap.set("n", "<leader>z", function()
  vim.cmd("Goyo")
  vim.cmd("Twilight")
end)

-- Leader ag to toggle Goyo
vim.keymap.set("n", "<leader>ag", function()
  vim.cmd("Goyo")
end)

-- Leader at to toggle Twilight
vim.keymap.set("n", "<leader>at", function()
  vim.cmd("Twilight")
end)

-- leader an to toggle line numbers
vim.keymap.set("n", "<leader>an", function()
  if vim.wo.number then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end)

----------------------------------------
-- Misc.
----------------------------------------

vim.keymap.set("v", "<Tab>", ">gv")   -- Tab to indent in visual mode
vim.keymap.set("v", "<S-Tab>", "<gv") -- Shift-Tab to unindent in visual mode
