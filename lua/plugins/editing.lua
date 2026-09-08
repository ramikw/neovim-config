-- Text editing helpers

return {
	{
		"windwp/nvim-ts-autotag",
		---@module "nvim-ts-autotag"
		---@type nvim-ts-autotag.PluginSetup
		opts = {},
	},
	{
		"nmac427/guess-indent.nvim",
		lazy = false,
		config = function()
			vim.opt.tabstop = 4
			vim.opt.softtabstop = 4
			vim.opt.shiftwidth = 4
			vim.opt.expandtab = true
			require("guess-indent").setup({})
		end,
	},
}
