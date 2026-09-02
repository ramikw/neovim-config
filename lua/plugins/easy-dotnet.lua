return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			"folke/snacks.nvim",
		},
		ft = { "cs", "fsharp", "xml", "csproj", "fsproj", "sln", "razor" },
		opts = {
			lsp = {
				enabled = true,
				preload_roslyn = true,
				enhanced_rename = true,
				create_type_from_usage = true,
				-- enhanced_rename and create_type_from_usage need the extension
				easy_dotnet_extension_enabled = true,
				restart_roslyn_on_branch_change = true,
				-- no "N references" codelens above members
				auto_refresh_codelens = false,
				config = {
					settings = {
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = false,
						},
					},
				},
				razor = {
					enabled = false,
				},
			},
			auto_bootstrap_namespace = {
				enabled = true,
				type = "file_scoped",
			},
			diagnostics = {
				default_severity = "warning",
				setqflist = false,
			},
			test_runner = {
				neotest_integration = true,
			},
			debugger = {
				engine = "netcoredbg",
				auto_register_dap = true,
			},
		},
		keys = {
			{
				"<leader>n",
				function()
					require("easy-dotnet").run_default()
				end,
				desc = "Run default .NET project",
			},
			{
				"<leader>m",
				function()
					require("easy-dotnet").debug_default()
				end,
				desc = "Debug default .NET project",
			},
		},
	},
}
