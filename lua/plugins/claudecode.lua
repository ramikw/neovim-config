return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        terminal = {
            split_width_percentage = 0.25,
            snacks_win_opts = {
                keys = {
                    remove_focus = {
                        "<C-w>w",
                        function()
                            vim.cmd("wincmd p")
                        end,
                        mode = "t",
                        desc = "Remove focus"
                    },
                },
            },
        },
    },
    keys = {
        { "<leader>ac", function() require("claudecode.terminal").simple_toggle({}) end,               desc = "Toggle Claude" },
        { "<leader>af", function() require("claudecode.terminal").focus_toggle({}) end,                desc = "Focus Claude" },
        { "<leader>ar", function() require("claudecode.terminal").simple_toggle({}, "--resume") end,   desc = "Resume Claude" },
        { "<leader>aC", function() require("claudecode.terminal").simple_toggle({}, "--continue") end, desc = "Continue Claude" },
        { "<leader>am", function() require("claudecode").open_with_model() end,                        desc = "Select Claude model" },
        {
            "<leader>ab",
            function()
                require("claudecode").send_at_mention(vim.fn.expand("%:p"), nil, nil, "ClaudeCodeAdd")
            end,
            desc = "Add current buffer",
        },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "snacks_picker_list", "oil", "minifiles", "netrw" },
        },
        { "<leader>aa", function() require("claudecode.diff").accept_current_diff() end, desc = "Accept diff" },
        { "<leader>ad", function() require("claudecode.diff").deny_current_diff() end,   desc = "Deny diff" },
    },
}
