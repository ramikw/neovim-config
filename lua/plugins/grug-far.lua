return {
	"MagicDuck/grug-far.nvim",
	opts = {
		showCompactInputs = true,
		windowCreationCommand = "botright 50vsplit",
	},
	keys = {
		{
			"<leader>f",
			mode = { "n", "v" },
			function()
				require("grug-far").open()
			end,
			desc = "Open search",
		},
	},
}
