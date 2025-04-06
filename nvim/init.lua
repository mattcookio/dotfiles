vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

-- Explicitly load keymaps (and potentially other config modules)
require('config.keymaps')
