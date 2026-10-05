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

			-- Code lens (off by default; run the one on the current line with grx)

			vim.lsp.codelens.enable(true)

			-- Folding

			vim.opt.foldcolumn = "0"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true

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
			-- LSP keys (Neovim 0.12 defaults, redefined here so every key has a description;
			-- navigation keys use Snacks pickers so multiple results can be browsed)

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
			{ "grn", vim.lsp.buf.rename, desc = "Rename" },
			{ "gra", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "Code Actions" },
			{ "grx", vim.lsp.codelens.run, desc = "Run Code Lens" },
			{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
			{ "<C-s>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },

			-- Diagnostic keys (also Neovim defaults)

			{
				"]d",
				function()
					vim.diagnostic.jump({ count = 1 })
				end,
				desc = "Next Diagnostic",
			},
			{
				"[d",
				function()
					vim.diagnostic.jump({ count = -1 })
				end,
				desc = "Previous Diagnostic",
			},
			{
				"]D",
				function()
					vim.diagnostic.jump({ count = math.huge, wrap = false })
				end,
				desc = "Last Diagnostic",
			},
			{
				"[D",
				function()
					vim.diagnostic.jump({ count = -math.huge, wrap = false })
				end,
				desc = "First Diagnostic",
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
			{ "<C-w>d", vim.diagnostic.open_float, desc = "Show Diagnostic Under Cursor" },

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
