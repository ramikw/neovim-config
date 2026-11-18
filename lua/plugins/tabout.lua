return {
	"abecodes/tabout.nvim",
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		-- Tab is mapped by blink.cmp (snippet_forward first, then <Plug>(Tabout))
		tabkey = "",
		backwards_tabkey = "",
		act_as_tab = true,
		act_as_shift_tab = true,
		completion = false,
		ignore_beginning = true,
	},
}
