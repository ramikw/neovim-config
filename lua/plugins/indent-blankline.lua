return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local hooks = require "ibl.hooks"
        require("ibl").setup {
            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = { "snacks_dashboard" }
            },
        }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
}
