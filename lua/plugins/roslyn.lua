return {
	{
		"seblyng/roslyn.nvim",
		ft = { "cs", "razor" },
		dependencies = {
			"mason-org/mason.nvim",
			-- Shared vim.lsp.config("*") capabilities must be set before roslyn attaches
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
}
