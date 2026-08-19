-- Text editing helpers

return {
    {
        "windwp/nvim-autopairs",
        opts = {},
    },
    { "tpope/vim-repeat" },
    { "windwp/nvim-ts-autotag", opts = {} },
    {
        "tpope/vim-surround",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    {
        "nmac427/guess-indent.nvim",
        lazy = false,
        config = function()
            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
            require("guess-indent").setup {}
        end,
    },
}
