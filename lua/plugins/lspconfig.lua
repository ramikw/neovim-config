return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/schemastore.nvim",

			-- nvim-ufo
			"kevinhwang91/nvim-ufo",
			"kevinhwang91/promise-async",
		},
		lazy = false,
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities(),
				{
					textDocument = {
						foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
						completion = {
							completionItem = { snippetSupport = true },
						},
					},
				}
			)
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Folding

			vim.opt.foldcolumn = "0"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true

			-- LSP

			-- Servers themselves are enabled by mason-lspconfig's automatic_enable
			-- once their mason package is installed.

			vim.lsp.config("eslint", {
				root_markers = { ".eslintrc.json" },
				settings = {
					-- useFlatConfig = false,
				},
			})

			vim.lsp.config("sqls", {
				filetypes = { "sql" },
				root_dir = function(_)
					return vim.loop.cwd()
				end,
			})

			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								enabled = true,
							},
						},
					},
				},
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("bicep", {
				cmd = { vim.fn.expand("$MASON/packages/bicep-lsp/bicep-lsp.cmd") },
			})

			vim.lsp.config("roslyn", {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
					},
				},
			})

			require("ufo").setup()
		end,
		keys = {
			-- LSP keys

			{ "gd", require("custom-functions").go_to_definition, desc = "Go To Definition" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go To Implementation" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go To Declaration" },
			{ "<C-h>", vim.lsp.buf.hover, desc = "Mouse Hover" },
			{
				"<F2>",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename",
			},

			-- Folds keys

			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
		},
	},
}
