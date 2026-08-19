return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup {
            "telescope",
            files = {
                git_icons = false,
            },
            grep = {
                git_icons = false,
            },
        }
    end,
    keys = {
        { "ff", function() require("fzf-lua").files() end,     desc = "Search Files" },
        { "fg", function() require("fzf-lua").live_grep_native() end, desc = "RipGrep" },
    },
}
