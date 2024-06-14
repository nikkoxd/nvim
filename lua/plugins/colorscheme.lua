return {
  "ramojus/mellifluous.nvim",

  config = function()
    require("mellifluous").setup({
      transparent_background = {
        enabled = true
      },
    })

    vim.cmd("colorscheme mellifluous")
  end
}
