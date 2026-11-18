return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	---@module "claudecode"
	---@type PartialClaudeCodeConfig
	---@diagnostic disable-next-line: missing-fields
	opts = {
		-- Copying in Claude printed "52;c;<base64>" into its input box when nvim runs inside
		-- tmux. Hide tmux from Claude so it skips its tmux clipboard path.
		env = { TMUX = "", TMUX_PANE = "" },
		-- terminal is typed as the full ClaudeCodeTerminalConfig, not a partial
		---@diagnostic disable-next-line: missing-fields
		terminal = {
			split_width_percentage = 0.27,
		},
	},
	keys = {
		{
			"<leader>ac",
			function()
				require("claudecode.terminal").simple_toggle({})
			end,
			desc = "Toggle Claude",
		},
		{
			"<leader>af",
			function()
				require("claudecode.terminal").focus_toggle({})
			end,
			desc = "Focus Claude",
		},
		{
			"<leader>ar",
			function()
				require("claudecode.terminal").simple_toggle({}, "--resume")
			end,
			desc = "Resume Claude",
		},
		{
			"<leader>aC",
			function()
				require("claudecode.terminal").simple_toggle({}, "--continue")
			end,
			desc = "Continue Claude",
		},
		{
			"<leader>am",
			function()
				require("claudecode").open_with_model()
			end,
			desc = "Select Claude model",
		},
		{
			"<leader>ab",
			function()
				require("claudecode").send_at_mention(vim.fn.expand("%:p"), nil, nil, "ClaudeCodeAdd")
			end,
			desc = "Add current buffer",
		},
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Send to Claude" },
		{ "<leader>as", "<cmd>.ClaudeCodeSend<cr>", mode = "n", desc = "Send current line to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "snacks_picker_list", "oil", "minifiles", "netrw" },
		},
		{
			"<leader>aa",
			function()
				require("claudecode.diff").accept_current_diff()
			end,
			desc = "Accept diff",
		},
		{
			"<leader>ad",
			function()
				require("claudecode.diff").deny_current_diff()
			end,
			desc = "Deny diff",
		},
	},
}
