local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "x" },
			desc = "Format",
		},
	},
	init = function()
		-- gq uses conform (falls back to the LSP, then Vim's own formatting)
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cs = { "csharpier" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			javascript = prettier,
			javascriptreact = prettier,
			typescript = prettier,
			typescriptreact = prettier,
			vue = prettier,
			svelte = prettier,
			css = prettier,
			scss = prettier,
			html = prettier,
			htmlangular = prettier,
			json = prettier,
			jsonc = prettier,
			yaml = prettier,
			markdown = prettier,
		},
		default_format_opts = { lsp_format = "fallback" },
	},
}
