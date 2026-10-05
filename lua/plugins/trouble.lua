return {
	"folke/trouble.nvim",
	dependencies = "nvim-mini/mini.nvim",
	---@type trouble.Config
	opts = {
		keys = {
			["<tab>"] = "jump",
			["<cr>"] = "jump_close",
		},
	},
	keys = {
		{
			"<leader>p",
			function()
				require("trouble").open({ mode = "diagnostics", focus = true })
			end,
			desc = "Open Project Diagnostics",
		},
		{
			"<leader>x",
			function()
				require("trouble").open({ mode = "diagnostics", focus = true, filter = { buf = 0 } })
			end,
			desc = "Open Buffer Diagnostics",
		},
	},
}
