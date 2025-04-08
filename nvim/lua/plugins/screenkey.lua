return {
    "NStefan002/screenkey.nvim",
    config = function()
      local height = vim.api.nvim_win_get_height(0)
      local width = vim.api.nvim_win_get_width(0)
        require("screenkey").setup({
            win_opts = {
                border = "none",
                title = "",
                row = height - 1,
               col = width - 2
            }
        })
    end,
}

