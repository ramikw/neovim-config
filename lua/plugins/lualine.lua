return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.nvim" },
	opts = {
		options = {
			component_separators = "",
			disabled_filetypes = {
				"",
				"DiffviewFiles",
				"Outline",
				"OverseerList",
				"snacks_picker_list",
				"snacks_picker_input",
				"neotest-summary",
				"snacks_dashboard",
				"grug-far",
			},
		},
		sections = {
			lualine_a = {
				"mode",
			},
			lualine_b = {
				"branch",
			},
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = {
				"diagnostics",
			},
			lualine_y = {
				"overseer",
				"filetype",
			},
			lualine_z = {
				"location",
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
	},
}
