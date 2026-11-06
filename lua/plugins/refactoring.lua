-- Keymaps follow LazyVim's editor.refactoring extra.
-- Refactors are operators: in normal mode follow them with a motion/textobject
-- (e.g. <leader>rfip, <leader>rxi(), or use them on a visual selection.
local function refactor(name, suffix)
	return function()
		return require("refactoring")[name]() .. (suffix or "")
	end
end

local function debug(name, opts, suffix)
	return function()
		return require("refactoring.debug")[name](opts) .. (suffix or "")
	end
end

return {
	"ThePrimeagen/refactoring.nvim",
	-- TODO: remove in nvim 0.13
	-- async.nvim is only needed on Neovim 0.12; drop it on 0.13+ (which ships vim.async)
	dependencies = {
		{
			"lewis6991/async.nvim",
			-- promise-async (nvim-ufo dependency) also provides a top-level `async` module and
			-- shadows async.nvim's. refactoring.nvim prefers `vim.async`, so load async.nvim
			-- by path and expose it there.
			config = function(plugin)
				if not vim.async then
					vim.async = dofile(plugin.dir .. "/lua/async.lua")
				end
			end,
		},
	},
	cmd = "Refactor",
	keys = {
		{ "<leader>rs", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Select Refactor" },
		{ "<leader>rf", refactor("extract_func"), mode = { "n", "x" }, expr = true, desc = "Extract Function" },
		{ "<leader>rF", refactor("extract_func_to_file"), mode = { "n", "x" }, expr = true, desc = "Extract Function To File" },
		{ "<leader>rx", refactor("extract_var"), mode = { "n", "x" }, expr = true, desc = "Extract Variable" },
		{ "<leader>ri", refactor("inline_var"), mode = { "n", "x" }, expr = true, desc = "Inline Variable" },
		{ "<leader>rp", debug("print_var", { output_location = "below" }, "iw"), expr = true, desc = "Debug Print Variable" },
		{ "<leader>rp", debug("print_var", { output_location = "below" }), mode = "x", expr = true, desc = "Debug Print Variable" },
		{ "<leader>rP", debug("print_loc", { output_location = "below" }), expr = true, desc = "Debug Print Location" },
		-- `ag` = whole buffer (mini.ai textobject defined in mini.lua)
		{ "<leader>rc", debug("cleanup", { restore_view = true }, "ag"), expr = true, remap = true, desc = "Debug Cleanup" },
	},
}
