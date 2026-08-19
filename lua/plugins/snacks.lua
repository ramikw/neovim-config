return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { title = "MRU", padding = 1 },
                { section = "recent_files", limit = 8, padding = 1 },
                { section = "startup" },
            },
        },
        notifier = {
            enabled = true,
            timeout = 4000,
            filter = function(notif)
                return notif.title ~= "boilersharp.nvim"
            end,
        },
        image = { enabled = true },
        indent = { enabled = true, animate = { enabled = false } },
        words = { enabled = true },
        terminal = {
            win = { height = 0.25 },
        },
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
        { "<C-t>", mode = { "n", "t" }, function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal" },
    },
}
