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

-- Create splits
vim.keymap.set('n', '_', function()
    vim.cmd('split')      -- Create horizontal split
    vim.cmd('wincmd j')   -- Move to the new split
    vim.cmd('enew')       -- Create empty buffer
end, { desc = 'Horizontal split with empty buffer' })

vim.keymap.set('n', '|', function()
    vim.cmd('vsplit')     -- Create vertical split
    vim.cmd('wincmd l')   -- Move to the new split
    vim.cmd('enew')       -- Create empty buffer
end, { desc = 'Vertical split with empty buffer' })

-- Close current split (like bd for buffers)
vim.keymap.set('n', '<leader>sd', '<C-w>c', { desc = 'Delete Split' })

-- Close all splits except current (like ba for buffers)
vim.keymap.set('n', '<leader>so', function()
    vim.cmd('only')
end, { desc = 'Close All Other Splits' })

-- Merge current split with left split
vim.keymap.set('n', '<leader>sh', function()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.cmd('wincmd h')  -- Move to left window
    if vim.api.nvim_get_current_win() ~= current_buf then  -- Check if we actually moved
        local target_win = vim.api.nvim_get_current_win()
        vim.cmd('wincmd l')  -- Move back
        vim.api.nvim_win_set_buf(target_win, current_buf)  -- Set left window's buffer
        vim.cmd('close')  -- Close current window
    end
end, { desc = 'Merge Split Left' })

-- Merge current split with right split
vim.keymap.set('n', '<leader>sl', function()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.cmd('wincmd l')  -- Move to right window
    if vim.api.nvim_get_current_win() ~= current_buf then  -- Check if we actually moved
        local target_win = vim.api.nvim_get_current_win()
        vim.cmd('wincmd h')  -- Move back
        vim.api.nvim_win_set_buf(target_win, current_buf)  -- Set right window's buffer
        vim.cmd('close')  -- Close current window
    end
end, { desc = 'Merge Split Right' })


-- Navigation mappings
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower split' })

-- Buffer navigation that works on both Mac (Option) and Windows/Linux (Alt)
vim.keymap.set('n', '˙', '<cmd>bprevious!<CR>', { noremap = true, silent = true }) -- Mac Option-h
vim.keymap.set('n', '¬', '<cmd>bnext!<CR>', { noremap = true, silent = true }) -- Mac Option-l
vim.keymap.set('n', '<A-h>', '<cmd>bprevious!<CR>', { noremap = true, silent = true }) -- Windows/Linux Alt-h
vim.keymap.set('n', '<A-l>', '<cmd>bnext!<CR>', { noremap = true, silent = true }) -- Windows/Linux Alt-l

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
