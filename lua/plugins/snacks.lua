return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 4000,
            filter = function(notif)
                return notif.title ~= "boilersharp.nvim"
            end,
        },
        image = { enabled = true },
        lazygit = {
            enabled = true,
            theme = {
                selectedLineBgColor = { bg = "CursorLine" }
            }
        },
    },

    keys = {
        { "<C-g>", function() require("snacks").lazygit.open() end, desc = "LazyGit" },
        { "go", function() require("snacks").gitbrowse.open() end, desc = "Open Git in browser" },
        { "<leader>h", function() require("snacks").notifier.show_history() end, desc = "Show notification history" },
    },
}
