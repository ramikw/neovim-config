-- Visual/UI enhancements

return {
    { "brenoprata10/nvim-highlight-colors", opts = {} },
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        "mhinz/vim-startify",
        config = function()
            vim.g.startify_change_to_dir = 0
        end,
    },
    {
        "tzachar/local-highlight.nvim",
        config = function()
            require("local-highlight").setup({
                animate = { enabled = false },
            })
        end,
    },
    { "moll/vim-bbye" },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = { signs = false },
    },
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>u", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            outline_window = { show_cursorline = true },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = "markdown",
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
        },
    },
}
