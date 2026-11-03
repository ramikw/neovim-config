return {
	{
		"neovim/nvim-lspconfig",
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

			local json_schemas
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						validate = { enable = true },
					},
				},
				-- Build the SchemaStore table lazily, once, when the first jsonls client starts
				before_init = function(_, config)
					json_schemas = json_schemas or require("schemastore").json.schemas()
					config.settings.json.schemas = json_schemas
				end,
			})

			-- lspconfig ships no default cmd for bicep. Servers are enabled by
			-- mason-lspconfig after mason has put its bin dir on PATH, so the
			-- bare name resolves to mason's shim (.cmd on Windows).
			vim.lsp.config("bicep", {
				cmd = { "bicep-lsp" },
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
		},
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		-- Attaches to the buffers already open when it loads
		event = "VeryLazy",
		opts = {},
		keys = {
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
