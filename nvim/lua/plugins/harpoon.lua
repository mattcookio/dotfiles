return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()

    -- Setup Telescope extension
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- Basic keymaps
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
      { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end,
      { desc = "Harpoon remove file" })
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end,
      { desc = "Harpoon clear files" })
    vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end,
      { desc = "Harpoon telescope menu" })

    -- Navigate to files (just leader + number)
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
      { desc = "Harpoon to file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
      { desc = "Harpoon to file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
      { desc = "Harpoon to file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
      { desc = "Harpoon to file 4" })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end,
      { desc = "Harpoon to file 5" })
    vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end,
      { desc = "Harpoon to file 6" })
    vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end,
      { desc = "Harpoon to file 7" })
    vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end,
      { desc = "Harpoon to file 8" })
    vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end,
      { desc = "Harpoon to file 9" })

    -- Navigate through files
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
      { desc = "Harpoon prev file" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
      { desc = "Harpoon next file" })
  end,
}
