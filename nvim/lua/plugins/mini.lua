return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.ai').setup()
            require('mini.surround').setup()
            require('mini.bracketed').setup()
            require('mini.files').setup()
            require('mini.bracketed').setup()
            require('mini.animate').setup()
            require('mini.statusline').setup()
            require('mini.indentscope').setup()
            require('mini.comment').setup()
            require('mini.pairs').setup()
            require('mini.comment').setup()
            require('mini.pick').setup()
            require('mini.icons').setup()
            require('mini.jump').setup()
	    require('mini.sessions').setup()
	    require('mini.starter').setup()
            require('mini.jump2d').setup({
                view = {
                    dim = true
                }
            })
        end,
    },
}
