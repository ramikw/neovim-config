return {
	"danymat/neogen",
	cmd = "Neogen",
	keys = {
		{
			"<leader>cn",
			function()
				require("neogen").generate()
			end,
			desc = "Generate Annotations (Neogen)",
		},
	},
	opts = {
		-- blink.cmp uses the builtin vim.snippet engine
		snippet_engine = "nvim",
		languages = {
			cs = { template = { annotation_convention = "xmldoc" } },
		},
	},
}
