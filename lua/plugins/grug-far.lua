-- when the snacks explorer is focused, search the file/directory under the
-- cursor instead of the current buffer
local function search_path()
	local ok, snacks = pcall(require, "snacks")
	if ok then
		local picker = snacks.picker.get({ source = "explorer" })[1]
		if picker and picker:is_focused() then
			local item = picker:current()
			local path = item and snacks.picker.util.path(item)
			if path then
				return vim.fn.fnamemodify(path, ":.")
			end
		end
	end
	return vim.fn.expand("%")
end

return {
	"MagicDuck/grug-far.nvim",
	---@type grug.far.OptionsOverride
	opts = {
		showCompactInputs = true,
		windowCreationCommand = "botright 50vsplit",
	},
	keys = {
		{
			"<leader>sr",
			mode = { "n", "v" },
			function()
				require("grug-far").toggle_instance({
					instanceName = "far",
					staticTitle = "Find and Replace",
				})
			end,
			desc = "Open search",
		},
		{
			"<leader>sw",
			mode = "n",
			function()
				require("grug-far").open({
					transient = true,
					prefills = { search = vim.fn.expand("<cword>") },
				})
			end,
			desc = "Search word under cursor",
		},
		{
			"<leader>sw",
			mode = "v",
			function()
				require("grug-far").open({ transient = true })
			end,
			desc = "Search visual selection",
		},
		{
			"<leader>sf",
			mode = { "n", "v" },
			function()
				require("grug-far").open({
					transient = true,
					prefills = { paths = search_path() },
				})
			end,
			desc = "Search current file or explorer selection",
		},
		{
			"<leader>ss",
			mode = "v",
			function()
				require("grug-far").open({
					transient = true,
					visualSelectionUsage = "operate-within-range",
				})
			end,
			desc = "Search within selected range",
		},
	},
}
