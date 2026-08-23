-- Visual/UI enhancements

return {
    { "brenoprata10/nvim-highlight-colors", opts = {} },
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        "nvim-mini/mini.icons",
        lazy = false,
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
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
            { "<leader>u", function() require("outline").toggle() end, desc = "Toggle outline" },
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
