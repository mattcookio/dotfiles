return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require('auto-session')
    
    auto_session.setup({
      log_level = 'error',
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.expand('~/Code/'),
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      -- Only create sessions for first level directories under ~/Code
      auto_session_create_enabled = function()
        local cwd = vim.fn.getcwd()
        local code_dir = vim.fn.expand('~/Code/')
        -- Check if current directory is directly under ~/Code
        if string.sub(cwd, 1, #code_dir) == code_dir then
          local remaining_path = string.sub(cwd, #code_dir + 1)
          -- Count slashes to determine directory depth
          local slash_count = 0
          for _ in string.gmatch(remaining_path, "/") do
            slash_count = slash_count + 1
          end
          return slash_count == 0
        end
        return false
      end,
    })
  end,
} 
