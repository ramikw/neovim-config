local map = vim.keymap.set
local defaultMapOptions = { silent = true, noremap = true }

-- Clear highlighting on escape in normal mode

map("n", "<esc>", "<cmd>:noh<CR>", defaultMapOptions)

-- Move by screen line on wrapped text, unless a count is given

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Save file (insert-mode <C-s> is left as Neovim's built-in signature help)

map({ "n", "x" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move between windows

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })

-- Move lines up and down

map("n", "<A-j>", "<cmd>:m .+1<CR>==", defaultMapOptions)
map("n", "<A-k>", "<cmd>:m .-2<CR>==", defaultMapOptions)
map("i", "<A-j>", "<Esc><cmd>:m .+1<CR>==gi", defaultMapOptions)
map("i", "<A-k>", "<Esc><cmd>:m .-2<CR>==gi", defaultMapOptions)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", defaultMapOptions)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", defaultMapOptions)
