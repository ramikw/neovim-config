return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_background = "medium" -- "soft", "medium" or "hard"
		vim.g.gruvbox_material_foreground = "mix" -- "material", "mix" or "original"
		vim.g.gruvbox_material_enable_italic = 1
		vim.o.background = "dark"

		-- Terminal background: slightly darker than the normal background
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "gruvbox-material",
			callback = function()
				vim.api.nvim_set_hl(0, "TerminalNormal", { bg = "#222120" })
				local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
				vim.api.nvim_set_hl(0, "TerminalBorder", { fg = border.fg, bg = "#222120" })
			end,
		})
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
