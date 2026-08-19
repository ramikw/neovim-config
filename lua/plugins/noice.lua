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
        -- `messages` (ext_messages) and `cmdline` (ext_cmdline) share the
        -- same bottom row. Fully disabling `cmdline` while `messages` stays
        -- on made the message router redraw over that row on every
        -- keystroke, erasing what you typed. Keeping cmdline enabled but on
        -- the classic non-floating "cmdline" view (bottom row, no popup)
        -- avoids that fight while still dropping the popup window.
        cmdline = {
            enabled = true,
            view = "cmdline",
        },
        popupmenu = {
            enabled = true,
            backend = "nui",
        },
        presets = {
        },
        routes = {
            {
                filter = {
                    find = "boilersharp",
                },
                opts = { skip = true },
            },
        },
    },
}
