vim.api.nvim_create_autocmd("VimEnter", {
    command = 'if isdirectory(expand("%")) | cd % | endif'
})
