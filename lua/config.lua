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

-- Ignore case by default

vim.opt.ignorecase = true

-- Enable title

vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = "nvim %{expand('%:p')}"

-- Format alias

vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format() end, {})

-- Mouse

vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
]])

-- Styling

vim.o.winborder = "rounded"
vim.opt.wrap = true

-- Required for LuaLine: https://github.com/neovim/neovim/pull/17266

vim.opt.laststatus = 3

-- Spelling. Treesitter's @spell captures (see plugins/treesitter.lua) limit
-- checks to comments/strings/prose instead of scanning whole lines like
-- spelunker.vim did, so this is both native and faster.

vim.opt.spell = true
vim.opt.spelllang = "en_us"
