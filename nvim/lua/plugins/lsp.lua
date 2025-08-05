-- plugins/lsp.lu-- plugins/lsp.lu-- plugins/lsp.l-- plugins/lsp.lua
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
        signs = true,
      })

      -- Setup Mason first
      require("mason").setup()

      -- Get capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, 'blink.cmp')
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Setup mason-lspconfig with automatic installation
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        -- Automatically install LSPs to stdpath for neovim
        automatic_installation = true,
        ensure_installed = {}, -- Let it auto-detect based on filetypes
      })

      -- Define server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { 
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }

      -- Setup each server
      local lspconfig = require("lspconfig")
      
      -- Get all available servers from mason-lspconfig
      local installed_servers = mason_lspconfig.get_installed_servers()
      
      -- Setup function for servers
      local function setup_server(server_name)
        local server_opts = {
          capabilities = capabilities,
        }
        
        -- Merge custom settings if they exist
        if servers[server_name] then
          server_opts = vim.tbl_deep_extend("force", server_opts, servers[server_name])
        end
        
        lspconfig[server_name].setup(server_opts)
      end

      -- Setup all installed servers
      for _, server_name in ipairs(installed_servers) do
        setup_server(server_name)
      end

      -- Auto-setup servers when they are installed
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        callback = function()
          for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
            setup_server(server_name)
          end
        end,
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

