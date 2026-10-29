return {
	{
		"nvim-mini/mini.nvim",
		lazy = false,
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
			require("mini.pairs").setup()
			require("mini.surround").setup()

			-- Treesitter textobjects: daf (function), vic (class), cio (block/if/loop),
			-- yau (function call), plus mini.ai's improved a(/i"/ia (argument) etc.
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					u = ai.gen_spec.function_call(),
				},
			})
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
