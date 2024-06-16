return {
  "supermaven-inc/supermaven-nvim",

  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        clear_suggestion = "<leader>sc",
        accept_word = "<leader>sa",
      }
    })
  end
}
