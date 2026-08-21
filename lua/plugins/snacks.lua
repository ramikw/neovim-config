local function explorer()
    return require("snacks").picker.get({ source = "explorer" })[1]
end

local function explorer_focus()
    local e = explorer()
    if e then e:focus() else require("snacks").explorer.open() end
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        explorer = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { title = "MRU", padding = 1 },
                { section = "recent_files", limit = 8, padding = 1 },
                { section = "startup" },
            },
        },
        profiler = {
            enabled = true,
        },
        picker = {
            layout = { preset = "default" },
            sources = {
                explorer = {
                    follow_file = false, -- only reveal the current file via <leader>e
                    hidden = true,  -- show dotfiles
                    ignored = true, -- show gitignored files
                    win = { list = { keys = { ["E"] = "explorer_focus" } } },
                },
            },
            layouts = {
                -- Same as the builtin default, but with the input at the bottom.
                default = {
                    reverse = true,
                    layout = {
                        box = "horizontal",
                        width = 0.8,
                        height = 0.8,
                        {
                            box = "vertical",
                            border = true,
                            title = "{title} {live} {flags}",
                            { win = "list",  border = "none" },
                            { win = "input", height = 1, border = "top" },
                        },
                        { win = "preview", title = "{preview}", border = true, width = 0.5 },
                    },
                },
            },
        },
        rename = { enabled = true },
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
            win = { height = 0.9, width = 0.9 },
            theme = {
                selectedLineBgColor = { bg = "CursorLine" }
            }
        },
    },

    keys = {
        { "<C-g>", function() require("snacks").lazygit.open() end, desc = "LazyGit" },
        { "<F3>", function() explorer_focus() end, desc = "Open File Tree" },
        { "<F4>", function() local e = explorer(); if e then e:close() end end, desc = "Close File Tree" },
        { "<leader>e", function() require("snacks").explorer.reveal() end, desc = "Reveal current file in file tree" },
        { "ff", function() require("snacks").picker.files() end, desc = "Search Files" },
        { "fg", function() require("snacks").picker.grep() end, desc = "RipGrep" },
        { "fb", function() require("snacks").picker.buffers() end, desc = "Search Buffers" },
        { "fh", function() require("snacks").picker.help() end, desc = "Help Tags" },
        { "fr", function() require("snacks").picker.registers() end, desc = "Open Registers" },
        { "fm", function() require("snacks").picker.marks() end, desc = "Open Marks" },
        { "gr", function() require("snacks").picker.lsp_references() end, desc = "LSP References" },
        { "<C-c>", mode = { "n", "v" }, function() vim.lsp.buf.code_action() end, desc = "Code Actions" },
        { "go", function() require("snacks").gitbrowse.open() end, desc = "Open Git in browser" },
        { "<leader>h", function() require("snacks").notifier.show_history() end, desc = "Show notification history" },
        { "<C-t>", mode = { "n", "t" }, function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal" },
    },
}
