return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    -- Function to create a Telescope picker for mini.sessions
    local function telescope_mini_sessions()
      -- Use parent of config dir (~/.config/sessions)
      local sessions_dir = vim.fn.fnamemodify(vim.fn.stdpath("config"), ':h') .. "/sessions"
      local session_files = {}

      -- Ensure directory exists before scanning
      if vim.fn.isdirectory(sessions_dir) == 0 then
        vim.notify("Session directory does not exist: " .. sessions_dir, vim.log.levels.WARN)
        return
      end

      -- Use the new vim.fs.dir() API
      for name, type in vim.fs.dir(sessions_dir) do
        if type == "file" and name:match("%.vim$") then
          local session_name = name:gsub("%.vim$", "")
          table.insert(session_files, { display = session_name, value = session_name })
        end
      end

      require('telescope.pickers').new({}, {
        prompt_title = "Load Session",
        finder = require('telescope.finders').new_table({
          results = session_files,
          entry_maker = function(entry)
            return {
              value = entry.value,
              display = entry.display,
              ordinal = entry.display, -- for sorting
            }
          end
        }),
        sorter = require('telescope.config').values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map('i', '<CR>', function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              require('mini.sessions').read(selection.value)
            end
          end)
          map('n', '<CR>', function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              require('mini.sessions').read(selection.value)
            end
          end)
          -- Optional: Add mapping to delete session?
          -- map({'i', 'n'}, '<C-d>', function() ... end)
          return true
        end,
      }):find()
    end

    telescope.setup({
      defaults = {
        results_title = false,
        prompt_title = false,
        preview_title = false,
        sorting_strategy = "ascending",
      }
    })

    telescope.load_extension('fzf')


    -- Rest of your configuration remains the same...
    -- File pickers
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = '[F]ind [R]eferences' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = '[F]ind [S]ymbols' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
    vim.keymap.set('n', '<leader>fp', builtin.builtin, { desc = '[F]ind [P]ickers' })

    -- Git pickers
    vim.keymap.set('n', '<leader>fgc', builtin.git_commits, { desc = '[F]ind [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>fgb', builtin.git_branches, { desc = '[F]ind [G]it [B]ranches' })
    vim.keymap.set('n', '<leader>fbc', builtin.git_bcommits, { desc = '[F]ind [B]uffer Git [C]ommits' })

    -- LSP pickers
    vim.keymap.set('n', '<leader>fbs', builtin.lsp_document_symbols, { desc = '[F]ind [B]uffer [S]ymbols' })
    vim.keymap.set('n', '<leader>fws', builtin.lsp_workspace_symbols, { desc = '[F]ind [W]orkspace [S]ymbols' })
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = '[G]o to [D]efinition' })
    vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, { desc = '[G]o to Type [D]efinition' })

    -- Neovim configs
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({
        prompt_title = 'Neovim Configs',
        cwd = '~/.config/nvim/',
        hidden = true,
      })
    end, { desc = '[F]ind [N]eovim Configs' })

    -- Custom mini.sessions Telescope picker
    vim.keymap.set('n', '<leader>fs', telescope_mini_sessions, { desc = '[F]ind [S]essions' })
  end,
}
