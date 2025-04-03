return {
  {
    "folke/flash.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "<leader><leader>", function()
        require("flash").jump()
      end)

      -- Link to existing theme highlights
      vim.api.nvim_set_hl(0, 'FlashMatch', { link = 'Comment' })       -- dimmer, like comments
      vim.api.nvim_set_hl(0, 'FlashLabel', { link = 'Search' })        -- prominent, like search results
    end,
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
      highlight = {
        matches = true,
        priority = 999,
      },
    },
  }
}
