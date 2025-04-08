return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()

      -- Setup mini.sessions *before* mini.starter
      require('mini.sessions').setup({
        -- Use parent of config dir (~/.config/sessions)
        directory = vim.fn.fnamemodify(vim.fn.stdpath("config"), ':h') .. "/sessions",
        autoread = false, -- Disable autoread
        autowrite = true,
      })

      vim.keymap.set('n', '<leader>sn', function()
        local cwd = vim.fn.getcwd()
        local name = vim.fn.fnamemodify(cwd, ':t')
        if name == '' or name == '/' then
          name = vim.fn.input('Session name: ')
        end
        if name ~= '' then -- Ensure name is not empty after potential input cancellation
          require('mini.sessions').write(name)
          vim.notify("Wrote session: " .. name, vim.log.levels.INFO)
        else
          vim.notify("Session write cancelled.", vim.log.levels.WARN)
        end
      end, { noremap = true, silent = true, desc = "Session: New/Write CWD or Prompt" })

      local starter = require('mini.starter')
      -- Basic starter setup with default sections
      starter.setup({
        items = {
          starter.sections.sessions(),
          starter.sections.recent_files(),
          starter.sections.builtin_actions(),
        },
        -- Removed custom header, footer, query_updaters, and content_hooks
      })

      require('mini.surround').setup()
      -- mini.sessions setup moved above
      require('mini.tabline').setup()
      require('mini.files').setup({
        mappings = {
          go_in_plus = '<CR>',
        },
      })
      require('mini.bracketed').setup()
      -- require('mini.animate').setup()
      require('mini.statusline').setup()
      require('mini.indentscope').setup({
        draw = {
          animation = function() return 0 end,
        }
      })
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
      require('mini.diff').setup()
      require('mini.git').setup()
      require('mini.icons').setup()
      local jump = require('mini.jump')
      jump.setup({
        mappings = {
          forward = 'f',
          backward = 'F',
          forward_till = 't',
          backward_till = 'T',
          repeat_jump = ';', -- Keep standard Vim behavior
        },
      })

      vim.keymap.set('n', '<leader>fe', function()
        require('mini.files').open()
      end, { desc = 'Open File Explorer' })
    end,
  },
}
