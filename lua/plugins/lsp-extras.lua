-- LSP supporting plugins (lspkind, signature, lazydev, file operations, language clients)

return {
    { "mfussenegger/nvim-jdtls", lazy = true },
    { "onsails/lspkind.nvim",    lazy = true },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = { hint_enable = false },
    },
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
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        opts = {},
    },
    {
        "TheLeoP/powershell.nvim",
        ---@type powershell.user_config
        opts = {
            bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        lazy = false,
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
        config = function()
            vim.g.vimtex_quickfix_open_on_warning = 0
            local custom_functions = require("custom-functions")
            if custom_functions.is_nixos() then
                vim.g.vimtex_view_general_viewer = "papers"
            else
                vim.g.vimtex_view_general_viewer = "SumatraPDF"
                vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            end
        end,
    },
}
