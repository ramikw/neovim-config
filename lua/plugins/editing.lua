-- Text editing helpers

return {
	{ "windwp/nvim-ts-autotag", opts = {} },
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
