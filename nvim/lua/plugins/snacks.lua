return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    terminal = {
      enabled = true,
      win = {
        position = "bottom",
        height = 0.4,
      },
    },
  },
  keys = {
    { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<leader>ts", function() Snacks.terminal(nil, { win = { position = "bottom" } }) end, desc = "Terminal Split (bottom)" },
    { "<leader>tv", function() Snacks.terminal(nil, { win = { position = "right", width = 0.5 } }) end, desc = "Terminal Vertical Split" },
    { "<leader>tf", function() Snacks.terminal(nil, { win = { position = "float" } }) end, desc = "Terminal Float" },
    { "<leader>tc", function() 
        if vim.b.snacks_terminal then
          vim.cmd("bdelete!")
        else
          vim.notify("No terminal in current buffer", vim.log.levels.WARN)
        end
      end, desc = "Close Terminal" },
  },
}