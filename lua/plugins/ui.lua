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
        "nvim-mini/mini.hipatterns",
        opts = {
            highlighters = {
                fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
            },
        },
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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = "markdown",
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
        },
    },
}
