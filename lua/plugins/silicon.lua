return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  opts = {
    disable_defaults = true,
    font = "MesloLGS Nerd Font Mono",
    theme = "gruvbox-dark",
    background = nil,
    pad_horiz = 0,
    pad_vert = 0,
    no_round_corner = true,
    no_window_controls = true,
    language = function()
      return vim.bo.filetype
    end,
    to_clipboard = true
  }
}
