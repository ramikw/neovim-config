local custom_functions = require("custom-functions")

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
			"GustavEikaas/easy-dotnet.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
			"marilari88/neotest-vitest",
			"mrcjkb/rustaceanvim",
			"stevearc/overseer.nvim",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-jest"),
					require("neotest-python"),
					require("easy-dotnet.neotest"),
					require("rustaceanvim.neotest"),
					require("neotest-vitest"),
				},
				discovery = {
					enabled = true,
					concurrent = 0,
					-- these are walked by every adapter otherwise, which delays
					-- the summary until the whole tree has been scanned
					filter_dir = function(name)
						return not vim.tbl_contains({
							"node_modules",
							"bin",
							"obj",
							"target",
							"dist",
							"build",
							"__pycache__",
							"vendor",
							"coverage",
						}, name)
					end,
				},
				consumers = {
					---@diagnostic disable-next-line: assign-type-mismatch
					overseer = require("neotest.consumers.overseer"),
				},
				overseer = {
					enabled = true,
					force_default = true,
				},
			})
		end,
		keys = {
			{ "<leader>a", custom_functions.run_all_tests, desc = "Run All Tests" },
			{ "<leader>l", custom_functions.debug_test, desc = "Debug Test" },
			{
				"<leader>o",
				function()
					require("neotest").output.open()
				end,
				desc = "Show Test Output",
			},
			{ "<leader>t", custom_functions.toggle_test_summary, desc = "Toggle test summary" },
			{ "<leader>r", custom_functions.run_marked_tests, desc = "Run marked tests" },
		},
	},
}
