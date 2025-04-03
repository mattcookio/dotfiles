return {
  {
    "junegunn/goyo.vim",
    event = "VeryLazy",
    config = function()
      vim.g.goyo_width = 120
      vim.g.goyo_linenr = 0
      vim.g.goyo_margin_top = 0
      vim.g.goyo_margin_bottom = 0
    end,
  },
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          inactive = true,
        },
        context = 10,
        treesitter = true,
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
      })

      -- Toggle both Goyo and Twilight
      vim.keymap.set("n", "<leader>z", function()
        vim.cmd("Goyo")
        vim.cmd("Twilight")
      end)
    end,
  },
}

 