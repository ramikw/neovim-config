local custom_functions = require("custom-functions")

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			-- Still needed even that the repo claims it is not.
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nsidorenco/neotest-vstest",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
			"marilari88/neotest-vitest",
			"mrcjkb/rustaceanvim",
			"stevearc/overseer.nvim",
		},
		config = function()
			vim.g.neotest_vstest = {
				build_opts = { additional_args = { "/p:SkipOpenApiGen=true" } },
			}
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-jest"),
					require("neotest-python"),
					require("neotest-vstest"),
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
			{ "<leader>ta", custom_functions.run_all_tests, desc = "Run All Tests" },
			{ "<leader>td", custom_functions.debug_test, desc = "Debug Test" },
			{
				"<leader>to",
				function()
					require("neotest").output.open()
				end,
				desc = "Show Test Output",
			},
			{ "<leader>ts", custom_functions.toggle_test_summary, desc = "Toggle test summary" },
			{ "<leader>tm", custom_functions.run_marked_tests, desc = "Run marked tests" },
		},
	},
}
