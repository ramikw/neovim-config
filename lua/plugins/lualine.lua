return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.nvim" },
    opts = {
        options = {
            component_separators = "",
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                "",
                "DiffviewFiles",
                "Outline",
                "OverseerList",
                "snacks_picker_list",
                "snacks_picker_input",
                "neotest-summary",
                "snacks_terminal",
                "snacks_dashboard",
                "grug-far",
            },
        },
        sections = {
            lualine_a = {
                { "mode", separator = { left = "" }, right_padding = 2 },
            },
            lualine_b = {
                { "branch" },
            },
            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },
            lualine_x = {
                "diagnostics",
            },
            lualine_y = {
                "overseer",
                "filetype",
            },
            lualine_z = {
                { "location", separator = { right = "" }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" },
        },
    }
}

