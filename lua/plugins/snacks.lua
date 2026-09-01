local function explorer()
    return require("snacks").picker.get({ source = "explorer" })[1]
end

local function explorer_focus()
    local e = explorer()
    if e then e:focus() else require("snacks").explorer.open() end
end

local function explorer_reveal_and_focus()
    local e = require("snacks").explorer.reveal()
    if e then e:focus() end
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
            sources = {
                explorer = {
                    hidden = true,
                    win = {
                        list = {
                            keys = {
                                ["E"] = "explorer_focus",
                                ["A"] = "explorer_add_dotnet",
                            },
                        },
                    },
                    actions = {
                        -- "a" stays snacks' plain file/dir add, "A" scaffolds from
                        -- a dotnet template and registers it in the solution
                        explorer_add_dotnet = function(picker)
                            require("easy-dotnet").create_item(picker:dir())
                        end,
                    },
                },
            },
        },
        rename = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 4000,
        },
        image = { enabled = true },
        indent = { enabled = true, animate = { enabled = false } },
        words = { enabled = true },
        terminal = {
            win = { height = 0.25 },
        },
        lazygit = {
            enabled = true,
            win = { height = 0.9, width = 0.9, border = "rounded" },
        },
    },

    keys = {
        { "<C-g>", function() require("snacks").lazygit.open() end, desc = "LazyGit" },
        { "<F3>", function() explorer_focus() end, desc = "Open File Tree" },
        { "<F4>", function() local e = explorer(); if e then e:close() end end, desc = "Close File Tree" },
        { "<leader>e", function() explorer_reveal_and_focus() end, desc = "Reveal current file in file tree and focus it" },
        { "ff", function() require("snacks").picker.files() end, desc = "Search Files" },
        { "fg", function() require("snacks").picker.grep() end, desc = "RipGrep" },
        { "  ", function() require("snacks").picker.buffers({ sort_lastused = true }) end, desc = "Search Buffers" },
        { "fh", function() require("snacks").picker.help() end, desc = "Help Tags" },
        { "fr", function() require("snacks").picker.registers() end, desc = "Open Registers" },
        { "fm", function() require("snacks").picker.marks() end, desc = "Open Marks" },
        { "gr", function() require("snacks").picker.lsp_references() end, desc = "LSP References" },
        { "<C-c>", mode = { "n", "v" }, function() vim.lsp.buf.code_action() end, desc = "Code Actions" },
        { "go", function() require("snacks").gitbrowse.open() end, desc = "Open Git in browser" },
        { "<leader>h", function() require("snacks").notifier.show_history() end, desc = "Show notification history" },
        { "<C-t>", mode = { "n", "t" }, function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal" },
        { "<leader>w", function() require("snacks").bufdelete.delete() end, desc = "Close Current Buffer" },
    },
}
