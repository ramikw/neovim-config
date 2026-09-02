return {
	{
		"nvim-mini/mini.nvim",
		lazy = false,
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.hipatterns").setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				},
			})
		end,
	},
}
