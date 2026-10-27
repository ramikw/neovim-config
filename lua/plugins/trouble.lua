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
			"<leader>xx",
			function()
				require("trouble").toggle({ mode = "diagnostics", focus = true })
			end,
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			function()
				require("trouble").toggle({ mode = "diagnostics", focus = true, filter = { buf = 0 } })
			end,
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			function()
				require("trouble").toggle({ mode = "symbols", focus = true })
			end,
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			function()
				require("trouble").toggle({ mode = "lsp", focus = true, win = { position = "right" } })
			end,
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			function()
				require("trouble").toggle({ mode = "loclist" })
			end,
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			function()
				require("trouble").toggle({ mode = "qflist" })
			end,
			desc = "Quickfix List (Trouble)",
		},
	},
}
