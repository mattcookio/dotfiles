return {
  {
    "folke/flash.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
        local gi = vim.go.ignorecase
        local gs = vim.go.smartcase
        vim.go.ignorecase = true
        vim.go.smartcase = false
        require("flash").jump({
          search = {
            mode = "fuzzy",
            forward = nil, -- nil means bidirectional
          },
        })
        vim.go.ignorecase = gi
        vim.go.smartcase = gs
      end, { desc = "Flash jump" })

      -- Link to existing theme highlights
      vim.api.nvim_set_hl(0, 'FlashMatch', { link = 'Comment' }) -- dimmer, like comments
      vim.api.nvim_set_hl(0, 'FlashLabel', { link = 'Search' })  -- prominent, like search results
    end,
    opts = {
      modes = {
        jump = {
          enabled = false
        },
        char = {
          enabled = false,
        },
      },
      search = {
        mode = "fuzzy",
        forward = nil,
        case_sensitive = false,
      },
      highlight = {
        matches = true,
        priority = 999,
      },
    },
  }
}
