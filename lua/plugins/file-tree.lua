return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        ---@module "neo-tree"
        ---@type neotree.Config
        opts = {
            auto_clean_after_session_restore = true,
            popup_border_style = "",

            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                filtered_items_filter_on = "directories_and_files",
            },

            window = {
                width = 40,
                mappings = {
                    ["E"] = "expand_all_subnodes",

                    ["<cr>"] = "open_with_window_picker",
                    ["S"] = "split_with_window_picker",
                    ["s"] = "vsplit_with_window_picker",
                }
            },

            default_component_configs = {
                file_size = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "<F3>",      function() require("neo-tree.command").execute({ action = "focus" }) end,                desc = "Open File Tree" },
            { "<F4>",      function() require("neo-tree.command").execute({ action = "close" }) end,                desc = "Close File Tree" },
            { "<leader>e", function() require("neo-tree.command").execute({ action = "focus", reveal = true }) end, desc = "Reveal current file in file tree" },
        },
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = {
            hint = "floating-big-letter",
            show_prompt = false,
            filter_rules = {
                bo = {
                    filetype = { "NvimTree", "neo-tree", "notify", "snacks_notif", "trouble", "grug-far", "dap-view" },
                }
            }
        },
    },
}
