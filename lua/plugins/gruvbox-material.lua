return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_background = "hard" -- "soft", "medium" or "hard"
		vim.g.gruvbox_material_foreground = "mix" -- "material", "mix" or "original"
		vim.g.gruvbox_material_enable_italic = 1
		vim.o.background = "dark"

		-- Terminal background
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "gruvbox-material",
			callback = function()
				local float = vim.api.nvim_get_hl(0, { name = "ColorColumn", link = false })
				local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
				vim.api.nvim_set_hl(0, "TerminalNormal", { bg = float.bg })
				vim.api.nvim_set_hl(0, "TerminalBorder", { fg = border.fg, bg = float.bg })
			end,
		})
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
