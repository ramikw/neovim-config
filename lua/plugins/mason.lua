return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			local packages = {
				"angularls", -- Angular
				"bashls", -- Bash
				"bicep", -- Bicep
				"clangd", -- C/CPP
				"cssls", -- CSS
				"docker_compose_language_service", -- Docker compose
				"dockerls", -- Docker
				"emmet_ls", -- Emmet
				"eslint", -- Eslint
				"html", -- HTML
				"jdtls", -- Java
				"jsonls", -- JSON
				"powershell_es", -- PowerShell
				"protols", -- Protocol buffer
				"pylsp", -- Python
				"sqlls", -- SQL
				"texlab", -- Latex
				"ts_ls", -- Typescript
				"vimls", -- Vim
			}

			require("mason-lspconfig").setup({
				ensure_installed = packages,
				automatic_installation = false,
			})

			vim.diagnostic.config({
				virtual_text = {
					severity = vim.diagnostic.severity.ERROR,
				},
				signs = false,
				update_in_insert = false,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"bibtex-tidy",
					"codelldb",
					"debugpy",
					"firefox-debug-adapter",
					"js-debug-adapter",
					"netcoredbg",
				},
			})
		end,
	},
}
