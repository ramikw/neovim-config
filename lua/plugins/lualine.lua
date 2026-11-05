return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.nvim" },
	opts = {
		options = {
			globalstatus = true,
			component_separators = "",
			section_separators = { left = "", right = "" },
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
						return vim.bo.filetype ~= "snacks_terminal" and vim.bo.filetype ~= "snacks_picker_list"
					end,
				},
				{
					-- full path of the item under the cursor in the snacks explorer
					function()
						local e = require("snacks").picker.get({ source = "explorer" })[1]
						local item = e and e:current()
						return item and item.file and vim.fn.fnamemodify(item.file, ":~:.") or ""
					end,
					icon = "󰙅",
					cond = function()
						return vim.bo.filetype == "snacks_picker_list"
					end,
				},
			},
			lualine_x = {
				{
					function()
						return "󰑋 Recording @" .. vim.fn.reg_recording()
					end,
					cond = function()
						return vim.fn.reg_recording() ~= ""
					end,
					color = { fg = "#ff9e64" },
				},
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
