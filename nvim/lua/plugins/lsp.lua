-- plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      -- Configure diagnostic appearance and behavior
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = {
          source = "if_many",
          prefix = "●",
          spacing = 4
        },
        signs = {
          active = true,
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
          texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
          },
        },
      })

      -- Setup Mason and automatic LSP installation
      require("mason").setup()

      -- Use blink.cmp's LSP capabilities
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Setup automatic LSP configuration
      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- Global mappings for diagnostics
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

      -- LSP keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  }
}
