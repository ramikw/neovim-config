return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{
			"<leader>g",
			function()
				vim.cmd.CodeDiff()
			end,
			desc = "Toggle Diff View",
		},
	},
	opts = {
		diff = {
			layout = "side-by-side",
		},
		explorer = {
			width = 30,
			view_mode = "tree",
		},
	},
}
