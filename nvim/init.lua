vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/config")) do
    if file:match("%.lua$") then
        local module = "config." .. file:gsub("%.lua$", "")
        local ok, config = pcall(require, module)
        if ok then
            if type(config) == "function" then
                config()
            elseif type(config) == "table" then
                for _, autocmd in ipairs(config) do
                    vim.api.nvim_create_autocmd(autocmd[1], autocmd)
                end
            end
        end
    end
end


vim.o.background = "dark"     -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.opt.number = true         -- Show current line number
vim.opt.relativenumber = true -- Show relative line numbers
