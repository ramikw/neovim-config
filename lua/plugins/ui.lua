-- Visual/UI enhancements

return {
	-- BufReadPre so both are loaded before the first buffer's FileType/BufEnter
	{ "brenoprata10/nvim-highlight-colors", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPre", "BufNewFile" } },
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
		---@module "outline"
		---@type outline.SetupOpts
		opts = {
			outline_window = { show_cursorline = true },
		},
	},
}
