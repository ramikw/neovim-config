return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			local ensureInstalled = {
				"angular",
				"asm",
				"bash",
				"bibtex",
				"bicep",
				"c",
				"c_sharp",
				"cmake",
				"comment",
				"cpp",
				"css",
				"csv",
				"dart",
				"desktop",
				"diff",
				"dockerfile",
				"dot",
				"dtd",
				"editorconfig",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"html",
				"http",
				"java",
				"javadoc",
				"javascript",
				"jq",
				"jsdoc",
				"json",
				"json5",
				"kotlin",
				"latex",
				"lua",
				"luadoc",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"meson",
				"nginx",
				"ninja",
				"nix",
				"passwd",
				"php",
				"powershell",
				"printf",
				"pymanifest",
				"python",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
				"toml",
				"tsv",
				"tsx",
				"typescript",
				"typespec",
				"typoscript",
				"udev",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
				"zig",
			}

			-- Deferred: get_installed() stats the parser directory and install()
			-- reloads the parser table, neither of which needs to sit on the
			-- startup path. Only call install() when something is missing --
			-- calling it with nothing to do still pays for a parser reload.
			vim.schedule(function()
				local alreadyInstalled = require("nvim-treesitter.config").get_installed()
				local parsersToInstall = vim.iter(ensureInstalled)
					:filter(function(parser)
						return not vim.tbl_contains(alreadyInstalled, parser)
					end)
					:totable()
				if #parsersToInstall > 0 then
					require("nvim-treesitter").install(parsersToInstall)
				end
			end)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Enable treesitter highlighting and disable regex syntax
					if not pcall(vim.treesitter.start, args.buf) then
						return
					end
					-- Treesitter indentation, only for languages that ship an indents
					-- query; the rest keep Vim's regex indent scripts
					local lang = vim.treesitter.language.get_lang(args.match)
					if lang and vim.treesitter.query.get(lang, "indents") then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		-- Provides the @function/@class/... queries used by mini.ai (see plugins/mini.lua)
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		-- Pins the current function/class header to the top of the window
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		opts = { max_lines = 3 },
	},
}
