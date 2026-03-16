return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "base16",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "", right = "" } },
			},
			lualine_b = {
				{ "branch", icon = "󰘬", padding = { left = 2, right = 1 } },
			},
      lualine_y = {
				{ "progress", padding = { left = 1, right = 2 } },
      },
			lualine_z = {
				{ "location", separator = { left = "", right = "" } },
			},
		},
	},
}
