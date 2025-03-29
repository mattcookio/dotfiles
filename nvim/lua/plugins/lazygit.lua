return {
  {
    "kdheepak/lazygit.nvim",
    -- optional: for floating window support
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- optional: custom lazygit config
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
    end,
  }
}
