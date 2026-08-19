return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            disabled_filetypes = {
                "",
                "DiffviewFiles",
                "Outline",
                "OverseerList",
                "neo-tree",
                "neotest-summary",
                "snacks_terminal",
                "snacks_dashboard",
                "grug-far",
            },
            section_separators = { right = "", left = ""},
        },
        sections = {
            lualine_a = {
                "mode",
            },
            lualine_b = {
                require("custom-functions").get_buffer_relative_path,
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {
                "overseer",
                "filetype",
            },
            lualine_z = {
                "location",
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

