return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_background = "medium" -- "soft", "medium" or "hard"
		vim.g.gruvbox_material_foreground = "mix" -- "material", "mix" or "original"
		vim.g.gruvbox_material_enable_italic = 1
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
