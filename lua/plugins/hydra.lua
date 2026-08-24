return {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    config = function()
        local Hydra = require("hydra")

        -- <leader>k opens a hydra so resizing can be repeated (e.g. "llll--kk")
        -- without re-pressing <leader>k every time.
        Hydra({
            name = "Resize",
            hint = [[
 ^^Width^^      ^^Height^^
 ^^^^-----------------------
 _h_ decr   _j_ decr
 _l_ incr   _k_ incr
]],
            config = {
                invoke_on_body = true,
                hint = {
                    type = "window",
                    position = "bottom",
                },
            },
            mode = "n",
            body = "<leader>k",
            heads = {
                { "h", "<C-w><" },
                { "l", "<C-w>>" },
                { "j", "<C-w>-" },
                { "k", "<C-w>+" },
                { "<Esc>", nil, { exit = true, desc = false } },
            },
        })
    end,
}
