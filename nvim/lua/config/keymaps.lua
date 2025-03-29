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
  MiniPick.builtin.files({
    tool = 'git' -- Use git for better performance
  })
end, {
  desc = "Find Files",
  silent = true
})

-- Find buffers
vim.keymap.set("n", "<leader>fb", function()
  MiniPick.builtin.buffers({
    include_current = true,
    include_unlisted = false
  })
end, {
  desc = "Find Buffers",
  silent = true
})

-- Find help
vim.keymap.set("n", "<leader>fh", function()
  MiniPick.builtin.help({
    default_split = "horizontal"
  })
end, {
  desc = "Find Help",
  silent = true
})

-- Live grep limited to current directory
vim.keymap.set("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live({
    tool = 'rg',
    args = { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
    cwd = vim.fn.getcwd() -- Limit to current directory
  })
end, {
  desc = "Live Grep (Current Directory)",
  silent = true
})


-- Resume last picker
vim.keymap.set("n", "<leader>fr", function()
  MiniPick.builtin.resume()
end, {
  desc = "Resume Last Picker",
  silent = true
})

----------------------------------------
-- Git Operations (g)
----------------------------------------

-- Open lazygit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true, desc = "Lazygit" })

----------------------------------------
-- Harpoon-like Operations (h)
----------------------------------------

-- Add current file to visits
vim.keymap.set('n', '<leader>ha', function()
  require('mini.visits').add_path()
  vim.notify('Added file to visits', vim.log.levels.INFO)
end, { desc = "Add file to visits" })

-- Remove current file from visits
vim.keymap.set('n', '<leader>hd', function()
  require('mini.visits').remove_path()
  vim.notify('Removed file from visits', vim.log.levels.INFO)
end, { desc = "Remove file from visits" })

-- Show visits
vim.keymap.set('n', '<leader>hh', function()
  require('mini.visits').select_path()
end, { desc = "Show visits" })

-- Go to next visit
vim.keymap.set('n', '<leader>hn', function()
  require('mini.visits').iterate_paths('forward')
end, { desc = "Next visit" })

-- Go to previous visit
vim.keymap.set('n', '<leader>hp', function()
  require('mini.visits').iterate_paths('backward')
end, { desc = "Previous visit" })

-- Clear all visits
vim.keymap.set('n', '<leader>hc', function()
  require('mini.visits').set_index({})
  require('mini.visits').write_index()
  vim.notify('Cleared all visits', vim.log.levels.INFO)
end, { desc = "Clear visits" })

-- Quick navigation to specific visits
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    local paths = require('mini.visits').list_paths()
    if paths[i] then
      vim.cmd.edit(paths[i])
    end
  end, { desc = "Go to visit " .. i })
end
