return {
	"rmagatti/auto-session",
	lazy = false,

	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- Close the Claude panel before saving so sessions never reopen it.
		pre_save_cmds = {
			function()
				require("claudecode.terminal").close()
			end,
		},
	},

	config = function(_, opts)
		-- "folds" here is what persists folds; the previous mkview/loadview
		-- autocmds on BufWinLeave/BufWinEnter duplicated that at the cost of
		-- synchronous view-file I/O on every single buffer switch.
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

		require("auto-session").setup(opts)
	end,
}
