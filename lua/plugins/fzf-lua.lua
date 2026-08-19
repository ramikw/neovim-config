return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup {
            fzf_opts = { ["--layout"] = "default" },
            files = {
                git_icons = false,
            },
            grep = {
                git_icons = false,
            },
            lsp = {
                code_actions = {
                    previewer = "codeaction_native",
                    preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
                },
            },
        }
        require("fzf-lua").register_ui_select()
    end,
    keys = {
        { "ff", function() require("fzf-lua").files() end,              desc = "Search Files" },
        { "fg", function() require("fzf-lua").live_grep_native() end,   desc = "RipGrep" },
        { "fb", function() require("fzf-lua").buffers() end,            desc = "Search Buffers" },
        { "fh", function() require("fzf-lua").helptags() end,           desc = "Help Tags" },
        { "fr", function() require("fzf-lua").registers() end,          desc = "Open Registers" },
        { "fm", function() require("fzf-lua").marks() end,              desc = "Open Marks" },
        { "gr", function() require("fzf-lua").lsp_references() end,     desc = "LSP References" },
        {
            "<C-c>",
            mode = { "n", "v" },
            function() require("fzf-lua").lsp_code_actions() end,
            desc = "Code Actions"
        },
    },
}
