return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require('auto-session')
    
    -- Helper function to check if path is under either ~/Code or ~/code
    local function is_under_code_dir(path)
      local code_dirs = {
        vim.fn.expand('~/Code/'),
        vim.fn.expand('~/code/')
      }
      
      for _, code_dir in ipairs(code_dirs) do
        if string.sub(path, 1, #code_dir) == code_dir then
          local remaining_path = string.sub(path, #code_dir + 1)
          -- Count slashes to determine directory depth
          local slash_count = 0
          for _ in string.gmatch(remaining_path, "/") do
            slash_count = slash_count + 1
          end
          if slash_count == 0 then
            return true
          end
        end
      end
      return false
    end
    
    auto_session.setup({
      log_level = 'error',
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.expand('~/.config/nvim/sessions/'),
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      -- Only create sessions for first level directories under ~/Code or ~/code
      auto_session_create_enabled = function()
        return is_under_code_dir(vim.fn.getcwd())
      end,
    })
  end,
} 
