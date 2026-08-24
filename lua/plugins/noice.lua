return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        -- nvim-notify intentionally omitted: notifications are routed
        -- through snacks.nvim's notifier (see lua/plugins/snacks.lua)
        -- instead of noice's own notify view.
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            hover = {
                enabled = true,
            },
        },
        notify = {
            enabled = false,
        },
        messages = {
            enabled = true,
            view = "notify",
            view_error = "notify",
            view_warn = "notify",
            view_history = "messages",
            view_search = "virtualtext",
        },
        cmdline = {
            enabled = true,
            view = "cmdline",
        },
        presets = {
            lsp_doc_border = true,
        }
    },
}
