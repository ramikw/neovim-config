local max_name_length = 34

return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
        local bufferline = require("bufferline")

        bufferline.setup {
            options = {
                diagnostics = "nvim_lsp",
                style_preset = bufferline.style_preset.no_italic,
                show_tab_indicators = false,
                show_close_icon = false,
                show_buffer_close_icons = false,
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return icon .. count
                end,
                name_formatter = function(buf)
                    if string.len(buf.name) > max_name_length then
                        local each_direction_length = (max_name_length - 2) / 2
                        return string.sub(buf.name, 0, each_direction_length)
                            .. ".."
                            .. string.sub(buf.name, -each_direction_length)
                    else
                        return buf.name
                    end
                end,
                max_name_length = max_name_length,
                offsets = {
                    {
                        filetype = "snacks_picker_list",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                    },
                },
                indicator = {
                    style = "icon",
                    icon = "┃",
                },
            },
        }
    end,
    keys = {
        { "<C-j>", [[:bp<CR>]],      desc = "Previous Buffer" },
        { "<C-k>", [[:bn<CR>]],      desc = "Next Buffer" },
        { "<leader>w",   function() require("snacks").bufdelete.delete() end, desc = "Close Current Buffer" },
    },
}
