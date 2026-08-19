return {
    "rmagatti/auto-session",
    lazy = false,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {},

    config = function(_, opts)
        -- "folds" here is what persists folds; the previous mkview/loadview
        -- autocmds on BufWinLeave/BufWinEnter duplicated that at the cost of
        -- synchronous view-file I/O on every single buffer switch.
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

        require("auto-session").setup(opts)
    end,
}
