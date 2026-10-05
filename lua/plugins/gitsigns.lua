return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	keys = {
		{
			"<leader>hp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Git Preview Hunk",
		},
		{
			"<leader>hs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "Git Stage Hunk",
		},
		{
			"]h",
			function()
				require("gitsigns").nav_hunk("next")
			end,
			desc = "Git Next Hunk",
		},
		{
			"[h",
			function()
				require("gitsigns").nav_hunk("prev")
			end,
			desc = "Git Previous Hunk",
		},
		{
			"<leader>hb",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>hr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "Git Reset Hunk",
		},
	},
}
