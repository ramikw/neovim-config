return {
	"mrjones2014/smart-splits.nvim",
	event = "VeryLazy",
	config = function()
		local smart_splits = require("smart-splits")

		vim.keymap.set("n", "<A-h>", smart_splits.resize_left, { desc = "Resize Width -" })
		vim.keymap.set("n", "<A-l>", smart_splits.resize_right, { desc = "Resize Width +" })
		vim.keymap.set("n", "<A-j>", smart_splits.resize_down, { desc = "Resize Height -" })
		vim.keymap.set("n", "<A-k>", smart_splits.resize_up, { desc = "Resize Height +" })
	end,
}
