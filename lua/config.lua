vim.opt.termguicolors = true

-- Lines

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- Vertical line

vim.opt.colorcolumn = "80"

-- Swap files

vim.opt.swapfile = false

-- Scrolloff

vim.opt.scrolloff = 5

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ui",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

-- Autocomplete size

vim.opt.pumwidth = 50

-- Ignore case by default, unless the search contains uppercase

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Persistent undo

vim.opt.undofile = true

-- Always show the sign column so text doesn't shift

vim.opt.signcolumn = "yes"

-- Splits

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Faster CursorHold

vim.opt.updatetime = 250

-- Live preview of :s substitutions

vim.opt.inccommand = "split"

-- Ask to save instead of failing on :q

vim.opt.confirm = true

-- System clipboard (uses win32yank.exe on WSL)

vim.opt.clipboard = "unnamedplus"

-- Highlight on yank

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Enable title

vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = "nvim %{expand('%:p') != '' ? expand('%:p') : fnamemodify(getcwd(), ':~')}" -- fall back to cwd when no file is open

-- Format alias

vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format()
end, {})

-- Mouse

vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
]])

-- Styling

vim.o.winborder = "rounded"
vim.opt.wrap = true

-- Hide the tabline (e.g. shown by codediff.nvim's diff tab)

vim.opt.showtabline = 0

-- Required for LuaLine: https://github.com/neovim/neovim/pull/17266

vim.opt.laststatus = 3

-- Spelling. Treesitter's @spell captures (see plugins/treesitter.lua) limit
-- checks to comments/strings/prose instead of scanning whole lines like
-- spelunker.vim did, so this is both native and faster.

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.spell = false
	end,
})

-- Unused language providers

vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Windows settings
if require("custom-functions").is_windows() then
	vim.o.shell = "nu"
	vim.o.shellcmdflag = "-n --no-newline -c"
	vim.o.shellredir = "out+err> %s"
	vim.o.shellpipe =
		"| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end
