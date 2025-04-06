return {
  {
    "junegunn/goyo.vim",
    config = function()
      vim.g.goyo_width = 120
      vim.g.goyo_margin_top = 4
      vim.g.goyo_margin_bottom = 4
    end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.5,
          color = { "Normal", "#ffffff" },
          inactive = true,
          term_bg = "#000000",
        },
        treesitter = true,
      })
    end,
  },
}
