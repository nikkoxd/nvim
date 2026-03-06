return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "OutlineOpen", "Outline" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    outline_window = {
      position = "left",
      width = 30,
      show_numbers = true,
      show_relative_numbers = true,
    }
  },
}
