return {
	"RRethy/base16-nvim",
	priority = 9999,
	lazy = false,
	config = function()
		require("colorscheme.matugen").setup()
		require("colorscheme.matugen").set_custom_hl_groups()
	end,
}
