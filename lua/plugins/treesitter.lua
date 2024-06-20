return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "gdscript",
        "godot_resource",
        "gdshader",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "typescript",
        "astro"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
