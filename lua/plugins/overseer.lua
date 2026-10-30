return {
	"stevearc/overseer.nvim",
	---@type overseer.SetupOpts
	opts = {
		dap = false,
		task_list = {
			keymaps = {
				-- Defaults shadow the global <C-j>/<C-k> window navigation, trapping you in the task list
				["<C-k>"] = false,
				["<C-j>"] = false,
			},
		},
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
