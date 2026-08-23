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
        { "<leader>p", [[:Trouble diagnostics focus=true<CR>]], desc = "Open Project Diagnostics" },
        { "<leader>x", [[:Trouble diagnostics focus filter.buf=0<CR>]], desc = "Open Buffer Diagnostics" },
    },
}
