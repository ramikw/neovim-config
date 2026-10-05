return {
	"stevearc/overseer.nvim",
	---@type overseer.SetupOpts
	opts = {
		dap = false,
	},
	keys = {
		{
			"<leader>ot",
			function()
				require("overseer").toggle()
			end,
			desc = "Toggle Overseer",
		},
		{
			"<leader>or",
			function()
				require("overseer").run_task({})
			end,
			desc = "Run Overseer Task",
		},
	},
}
