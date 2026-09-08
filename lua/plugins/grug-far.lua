return {
	"MagicDuck/grug-far.nvim",
	---@type grug.far.OptionsOverride
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
