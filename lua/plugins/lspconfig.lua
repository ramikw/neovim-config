return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/schemastore.nvim",

			-- nvim-ufo
			"kevinhwang91/nvim-ufo",
			"kevinhwang91/promise-async",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Neovim merges its default capabilities in on its own. blink's are
			-- fetched explicitly so the ufo folding override merges with them
			-- (requiring blink.cmp here also loads it).
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities({
					textDocument = {
						-- nvim-ufo
						foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
					},
				}),
			})

			-- LSP

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("bicep", {
				cmd = {
					require("custom-functions").is_windows() and vim.fn.expand(
						"$MASON/packages/bicep-lsp/bicep-lsp.cmd"
					) or vim.fn.expand("$MASON/packages/bicep-lsp/bicep-lsp"),
				},
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

			-- Inlay hints

			vim.lsp.inlay_hint.enable(true)

			require("ufo").setup()
		end,
		keys = {
			{
				"gd",
				function()
					require("snacks").picker.lsp_definitions()
				end,
				desc = "Go To Definition",
			},
			{
				"grr",
				function()
					require("snacks").picker.lsp_references()
				end,
				desc = "Go To References",
			},
			{
				"gri",
				function()
					require("snacks").picker.lsp_implementations()
				end,
				desc = "Go To Implementation",
			},
			{
				"grt",
				function()
					require("snacks").picker.lsp_type_definitions()
				end,
				desc = "Go To Type Definition",
			},
			{
				"grc",
				function()
					require("snacks").picker.lsp_incoming_calls()
				end,
				desc = "Incoming Calls (callers)",
			},
			{
				"grC",
				function()
					require("snacks").picker.lsp_outgoing_calls()
				end,
				desc = "Outgoing Calls (callees)",
			},
			{
				"gO",
				function()
					require("snacks").picker.lsp_symbols()
				end,
				desc = "Document Symbols",
			},
			{
				"gW",
				function()
					require("snacks").picker.lsp_workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},
			{
				"]]",
				function()
					require("snacks").words.jump(1)
				end,
				desc = "Next Reference",
			},
			{
				"[[",
				function()
					require("snacks").words.jump(-1)
				end,
				desc = "Previous Reference",
			},
			{
				"]e",
				function()
					vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Next Error",
			},
			{
				"[e",
				function()
					vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Previous Error",
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
