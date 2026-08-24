return {
    "folke/trouble.nvim",
    dependencies = "nvim-mini/mini.icons",
    opts = {
        action_keys = {
            jump = { "<tab>", "<2-leftmouse>" },
            jump_close = { "<cr>" }
        }
    },
    keys = {
        {
            "<leader>p",
            function() require("trouble").open({ mode = "diagnostics", focus = true }) end,
            desc = "Open Project Diagnostics",
        },
        {
            "<leader>x",
            function() require("trouble").open({ mode = "diagnostics", focus = true, filter = { buf = 0 } }) end,
            desc = "Open Buffer Diagnostics",
        },
    },
}
