return {
	"saghen/blink.cmp",
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "xzbdmw/colorful-menu.nvim", opts = {} },
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-c>"] = { "cancel", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-n>"] = { "show", "fallback" },
		},

		completion = {
			menu = {
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
				},
			},
			accept = {
				auto_brackets = { enabled = true },
			},
		},

		cmdline = {
			enabled = true,
			completion = {
				-- blink only shows the cmdline menu inside the command window by
				-- default, falling back to ghost text on the ":" line itself.
				menu = { auto_show = true },
				ghost_text = { enabled = false },
			},
		},

		signature = { enabled = true },

		fuzzy = { implementation = "prefer_rust_with_warning" },

		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
