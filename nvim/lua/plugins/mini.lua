return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.starter').setup()
      require('mini.tabline').setup()
      require('mini.files').setup({
        mappings = {
          go_in_plus = '<CR>',
        },
      })
      require('mini.bracketed').setup()
      require('mini.animate').setup()
      require('mini.statusline').setup()
      require('mini.indentscope').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
      require('mini.icons').setup()
      require('mini.jump').setup({
        mappings = {
          forward = 'f',
          backward = 'F',
          forward_till = 't',
          backward_till = 'T',
          repeat_jump = ';',
        },
      })

      vim.keymap.set('n', '<leader>fe', function()
        require('mini.files').open()
      end, { desc = 'Open File Explorer' })
    end,
  },
}
