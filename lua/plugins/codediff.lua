return {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {
        { "<leader>g", "<cmd>CodeDiff<CR>", desc = "Toggle Diff View" },
    },
    opts = {
        diff = {
            layout = "side-by-side",
        },
    },
}
