return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.nvim" },
	opts = {
		options = {
			theme = "gruvbox-material",
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
							and vim.bo.filetype ~= "codediff-explorer"
					end,
				},
				{
					-- name of the item under the cursor in the snacks explorer, with its file/folder icon
					function()
						local e = require("snacks").picker.get({ source = "explorer" })[1]
						local item = e and e:current()
						if not (item and item.file) then
							return ""
						end
						local name = vim.fn.fnamemodify(item.file, ":t")
						return name
					end,
					icon = "\u{f0142}",
					cond = function()
						return vim.bo.filetype == "snacks_picker_list"
					end,
				},
				{
					-- name of the item under the cursor in the codediff explorer
					function()
						local explorer = require("codediff.ui.lifecycle").get_panel_view(vim.api.nvim_get_current_tabpage())
						local node = explorer and explorer.tree and explorer.tree:get_node()
						local data = node and node.data
						if not data then
							return ""
						end
						if data.type == "directory" then
							return data.name or ""
						end
						return data.path and vim.fn.fnamemodify(data.path, ":t") or ""
					end,
					icon = "\u{f0142}",
					cond = function()
						return vim.bo.filetype == "codediff-explorer"
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
					color = "DiagnosticWarn",
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
