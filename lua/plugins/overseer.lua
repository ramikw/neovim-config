return {
	"stevearc/overseer.nvim",
	---@type overseer.SetupOpts
	opts = {
		dap = false,
	},
	keys = {
		{
			"<leader>v",
			function()
				require("overseer").toggle()
			end,
			desc = "Toggle Overseer",
		},
		{
			"<leader>b",
			function()
				require("overseer").run_task({})
			end,
			desc = "Run Overseer Task",
		},
	},
}
