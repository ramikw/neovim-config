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
		-- In diff windows fall back to Vim's native ]c/[c. codediff.nvim sets its own
		-- buffer-local ]c/[c in its diff tab, which take precedence over these.
		{
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			desc = "Git Next Hunk",
		},
		{
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
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
