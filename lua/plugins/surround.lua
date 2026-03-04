return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>s", "<Plug>(nvim-surround-visual)", mode = "x" },
    { "gS", "<Plug>(nvim-surround-visual-line )", mode = "x" },
  },
}
