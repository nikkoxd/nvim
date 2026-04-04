return {
  {
    'bullets-vim/bullets.vim',
    lazy = false,
    keys = {
      { "<leader>x", "<Plug>(bullets-toggle-checkbox)", desc = "Bullets" },
    }
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      relative_to_current_file = true,
    },
    keys = {
      -- suggested keymap
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,

    dependencies = { "saghen/blink.cmp" },

    opts = {
      markdown = {
        list_items = {
          shift_width = 2,
        },
      },
    },
  },
}
