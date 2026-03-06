return {
  {
    'bullets-vim/bullets.vim'
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "OXY2DEV/markview.nvim",
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
