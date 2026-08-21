local custom_functions = require("custom-functions")

return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nsidorenco/neotest-vstest",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-jest",
            "rcasia/neotest-java",
            "marilari88/neotest-vitest",
            "mrcjkb/rustaceanvim",
            "stevearc/overseer.nvim",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-jest"),
                    require("neotest-python"),
                    require("neotest-vstest"),
                    require("rustaceanvim.neotest"),
                    require("neotest-vitest"),
                },
                consumers = {
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
            { "<leader>l", custom_functions.debug_test,   desc = "Debug Test" },
            { "<leader>o", [[:Neotest output<CR>]], desc = "Show Test Output" },
            { "<leader>t", custom_functions.toggle_test_summary, desc = "Toggle test summary" },
            { "<leader>r", custom_functions.run_marked_tests, desc = "Toggle test summary" },
        },
    },
    {
        "andythigpen/nvim-coverage",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {},
        keys = {
            { "<leader>c", custom_functions.load_coverage, desc = "Load Coverage" },
            { "<leader>s", custom_functions.show_coverage_summary, desc = "Show Coverage Summary" },
        },
    },
}
