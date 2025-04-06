vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

-- Any additional configuration files can be loaded here,
-- for example keymaps which doesn't export anything, just executes
-- some commands/keymaps
require('config.keymaps')
