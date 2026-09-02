return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {},
	keys = {
		{
			"gp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Git Preview Hunk",
		},
		{
			"gs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "Git Stage Hunk",
		},
		{
			"gn",
			function()
				require("gitsigns").nav_hunk("next")
			end,
			desc = "Git Next Hunk",
		},
		{
			"gN",
			function()
				require("gitsigns").nav_hunk("prev")
			end,
			desc = "Git Previous Hunk",
		},
		{
			"gl",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"grh",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "Git Rest Hunk",
		},
	},
}
