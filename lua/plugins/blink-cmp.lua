-- Mirrors LazyVim's extras/coding/blink.lua, minus the LazyVim-only helpers
-- (LazyVim.cmp.expand/map, LazyVim icons, blink.compat sources, AI hooks).
return {
	"saghen/blink.cmp",
	version = "*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = {
			preset = "default",
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<Right>"] = false,
				["<Left>"] = false,
			},
			completion = {
				list = { selection = { preselect = true } },
				menu = {
					auto_show = true,
				},
				ghost_text = { enabled = true },
			},
		},

		keymap = {
			-- "default" preset: only <C-y> accepts (with fallback), <CR> stays a newline
			preset = "default",
			-- <C-space> is taken by tmux, so <C-n> opens the menu when it's closed
			["<C-space>"] = false,
			["<C-n>"] = { "select_next", "show" },
			["<C-p>"] = { "select_prev", "show" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-c>"] = { "cancel", "fallback" },
		},
	},
	opts_extend = { "sources.default" },
}
