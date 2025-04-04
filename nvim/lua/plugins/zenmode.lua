return {
  {
    "junegunn/goyo.vim",
    config = function()
      vim.g.goyo_width = 120
      vim.g.goyo_linenr = 1
      vim.g.goyo_margin_top = 4
      vim.g.goyo_margin_bottom = 4

      -- Store the original settings when entering Goyo
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GoyoEnter',
        callback = function()
          -- Preserve the existing number settings
          local number_setting = vim.opt.number:get()
          local relative_number_setting = vim.opt.relativenumber:get()

          -- Restore them after Goyo sets its own
          vim.schedule(function()
            vim.opt.number = number_setting
            vim.opt.relativenumber = relative_number_setting
          end)
        end
      })
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
    end,
  },
}
