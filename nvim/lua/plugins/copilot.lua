return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<Tab>', 'copilot#Accept("<Tab>")', { silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<C-w>', '<M-Right>', { silent = true })
      vim.api.nvim_set_keymap('i', '<C-b>', '<C-o>daw', { silent = true })
    end,
  },
}
