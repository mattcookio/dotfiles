return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.files').setup()
      require('mini.animate').setup()
      require('mini.statusline').setup()
      require('mini.indentscope').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
      require('mini.pick').setup()
      require('mini.icons').setup()
      require('mini.diff').setup()
      require('mini.git').setup()
      require('mini.jump').setup()
      require('mini.visits').setup()
      require('mini.trailspace').setup()
      require('mini.starter').setup()
    end,
  },
}
