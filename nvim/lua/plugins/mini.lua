return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.files').setup({
        mappings = {
    go_in_plus  = '<CR>',
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
      require('mini.jump').setup()

      vim.keymap.set('n', '<leader>fe', function()
        require('mini.files').open()
        -- Set enter to open file from file Explorer
        --

      end, { desc = 'Open File Explorer' })
    end,
  },
}
