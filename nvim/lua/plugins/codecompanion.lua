return {
  {
    "OliMorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
          keymaps = {
            accept_change = {
              modes = { n = "<leader>cy" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "<leader>cn" },
              description = "Reject the suggested change",
            },
          },
        },
      },
      commands = {
        enabled = true,
      },
      display = {
        action_palette = {
          provider = "mini_pick",
          width = 95,
          height = 10,
          prompt = "Prompt ",
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
    },
  },
}
