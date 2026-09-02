-- Visual/UI enhancements

return {
	{ "brenoprata10/nvim-highlight-colors", opts = {} },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{
				"<leader>u",
				function()
					require("outline").toggle()
				end,
				desc = "Toggle outline",
			},
		},
		opts = {
			outline_window = { show_cursorline = true },
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = "markdown",
		---@module "render-markdown"
		---@type render.md.UserConfig
		opts = {
			completions = { lsp = { enabled = true } },
		},
	},
}
