return {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function(_, opts)
        vim.opt.fillchars:append("diff:╱")
        require("diffview").setup(opts)
    end,
    keys = {
        {
            "<leader>g",
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end,
            desc = "Toggle Diffview",
        },
    },
    opts = {
        enhanced_diff_hl = true,
        hooks = {
            diff_buf_win_enter = function(bufnr, winid)
                vim.schedule(function()
                    vim.wo[winid].foldenable = false
                end)
            end,
        },
    }
}
