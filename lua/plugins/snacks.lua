-- Leave a terminal split with <C-h/j/k/l>; floating terminals get the key passed through
local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

local function explorer()
	return require("snacks").picker.get({ source = "explorer" })[1]
end

local function explorer_focus()
	local e = explorer()
	if e then
		e:focus()
	else
		require("snacks").explorer.open()
	end
end

local function explorer_reveal_and_focus()
	local e = require("snacks").explorer.reveal()
	if e then
		e:focus()
	end
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		{
			"s1n7ax/nvim-window-picker",
			opts = {
				hint = "floating-big-letter",
				show_prompt = false,
				filter_func = function(window_ids)
					return vim.tbl_filter(function(win)
						local buf = vim.api.nvim_win_get_buf(win)
						return vim.bo[buf].buftype == "" and not vim.bo[buf].filetype:find("^snacks")
					end, window_ids)
				end,
			},
		},
	},
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		input = { enabled = true },
		explorer = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ title = "MRU", padding = 1 },
				{ section = "recent_files", limit = 8, padding = 1 },
				{ section = "startup" },
			},
		},
		profiler = {
			enabled = true,
		},
		picker = {
			win = {
				input = {
					keys = {
						["<C-l>"] = { "clear_input", mode = { "i", "n" } },
					},
				},
			},
			actions = {
				clear_input = function(picker)
					picker.input:set("", "")
				end,
			},
			sources = {
				explorer = {
					hidden = true,
					-- don't auto-reveal the current buffer; reveal only via the keymap
					follow_file = false,
					win = {
						list = {
							keys = {
								["E"] = "explorer_focus",
								["<CR>"] = "confirm_pick_win",
							},
						},
					},
					actions = {
						-- only prompt for a window when actually opening a file;
						-- toggling a folder shouldn't trigger the window picker
						confirm_pick_win = function(picker, item)
							if item and item.dir then
								-- toggle the folder in place, no window picker
								return picker:action("confirm")
							end
							-- Used when the explorer is not shown as a split (e.g. Floating picker).
							if not picker.layout.split then
								picker.layout:hide()
							end
							local win = require("window-picker").pick_window()
							if not picker.layout.split then
								picker.layout:unhide()
							end
							if not win then
								return
							end
							picker.main = win
							return picker:action("confirm")
						end,
					},
				},
			},
		},
		rename = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 4000,
		},
		image = { enabled = false },
		indent = { enabled = true, animate = { enabled = false } },
		words = { enabled = true },
		terminal = {
			win = {
				height = 0.25,
				keys = {
					nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
					nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
					nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
					nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
				},
			},
		},
		lazygit = {
			enabled = true,
			win = { height = 0.9, width = 0.9, border = "rounded" },
		},
	},

	keys = {
		{
			"<C-g>",
			function()
				require("snacks").lazygit.open()
			end,
			desc = "LazyGit",
		},
		{
			"<F3>",
			function()
				explorer_focus()
			end,
			desc = "Open File Tree",
		},
		{
			"<F4>",
			function()
				local e = explorer()
				if e then
					e:close()
				end
			end,
			desc = "Close File Tree",
		},
		{
			"<leader>e",
			function()
				explorer_reveal_and_focus()
			end,
			desc = "Reveal current file in file tree and focus it",
		},
		{
			"<leader>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Search Files",
		},
		{
			"<leader>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "RipGrep",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers({ sort_lastused = true })
			end,
			desc = "Search Buffers",
		},
		{
			"<leader>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Help Tags",
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.registers()
			end,
			desc = "Open Registers",
		},
		{
			"<leader>fm",
			function()
				require("snacks").picker.marks()
			end,
			desc = "Open Marks",
		},
		{
			"go",
			function()
				require("snacks").gitbrowse.open()
			end,
			desc = "Open Git in browser",
		},
		{
			"<leader>n",
			function()
				require("snacks").notifier.show_history()
			end,
			desc = "Show notification history",
		},
		{
			"<C-t>",
			mode = { "n", "t" },
			function()
				require("snacks").terminal.toggle()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<leader>bd",
			function()
				require("snacks").bufdelete.delete()
			end,
			desc = "Close Current Buffer",
		},
		{
			"<leader>bo",
			function()
				require("snacks").bufdelete.other()
			end,
			desc = "Close Other Buffers",
		},
		{
			"<leader>ba",
			function()
				require("snacks").bufdelete.all()
			end,
			desc = "Close All Buffers",
		},
	},
}
