return {
  dir = '/Users/mc/code/pivot.nvim', -- Point to local development directory
  -- name = 'pivot.nvim',             -- Usually inferred by lazy.nvim
  config = function()
    require('pivot').setup()
  end,
}
