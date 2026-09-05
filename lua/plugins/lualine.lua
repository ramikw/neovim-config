return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.nvim" },
	opts = {
		options = {
			globalstatus = true,
			component_separators = '',
			section_separators = { left = '', right = '' },
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
					shorting_target = 25,
					symbols = {
						modified = "",
						readonly = "",
					},
					cond = function()
						return vim.bo.filetype ~= "snacks_terminal"
					end,
				},
			},
			lualine_x = {
				"diagnostics",
				"overseer",
			},
			lualine_y = {
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
