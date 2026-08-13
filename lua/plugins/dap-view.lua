return {
    {
        "igorlfs/nvim-dap-view",
        ---@module "dap-view"
        ---@type dapview.Config
        keys = {
            { "<leader>d", function() require("dap-view").toggle() end, desc = "Toggle DAP view" },
        },
        opts = {
            winbar = {
                default_section = "scopes",
                sections = { "scopes", "watches", "repl", "breakpoints", },
                controls = {
                    enabled = true,
                },
            },
            windows = {
                size = 0.20,
                terminal = {
                    size = 0.4,
                    position = "right",
                }
            },
            auto_toggle = true,
        },
    },
}
