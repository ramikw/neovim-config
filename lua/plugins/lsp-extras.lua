-- LSP supporting plugins (signature, lazydev, file operations, language clients)

return {
    { "mfussenegger/nvim-jdtls", lazy = true },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "TheLeoP/powershell.nvim",
        ft = "ps1",
        ---@type powershell.user_config
        opts = {
            bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        ft = "rust",
        config = function()
            ---@type rustaceanvim.Opts
            vim.g.rustaceanvim = {
                dap = {
                    configuration = {
                        type = "rust-gdb",
                        name = "rust-gdb",
                        request = "launch",
                    }
                }
            }
        end
    },
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_view_general_viewer = "SumatraPDF"
            vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
        end,
    },
}
