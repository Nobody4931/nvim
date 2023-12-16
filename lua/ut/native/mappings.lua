local map = vim.keymap.set

-- Use a different keystroke to enter normal mode
map({"", "i"}, "<C-c>", "<Esc>") -- ctrl+c in most modes
map("t", "<C-q>", "<C-\\><C-n>") -- ctrl+q in terminal mode

-- Switch to alternate file
map("n", "gb", "<C-^>")

-- Send j/k movements to jumplist when a count is used
map("n", "j", function()
	return (vim.v.count > 0 and ("m'" .. vim.v.count) or "") .. "j"
end, { expr = true })

map("n", "k", function()
	return (vim.v.count > 0 and ("m'" .. vim.v.count) or "") .. "k"
end, { expr = true })

-- Copy to system register
map({"n", "v"}, "<leader>y", "\"+y")
map({"n", "v"}, "<leader>Y", "\"+Y")

-- Paste from system register
map({"n", "v"}, "<leader>p", "\"+p")
map({"n", "v"}, "<leader>P", "\"+P")

-- Delete without replacing register contents
map({"n", "v"}, "<leader>d", "\"_d")
map({"n", "v"}, "<leader>D", "\"_D")

-- Center cursor while navigating
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Navigate the quickfix/location list
map("n", "<C-j>", "<CMD>cnext<CR>zz")
map("n", "<C-k>", "<CMD>cprev<CR>zz")
map("n", "<M-j>", "<CMD>lnext<CR>zz")
map("n", "<M-k>", "<CMD>lprev<CR>zz")

-- Insert mode navigation shortcuts
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

map("i", "<M-h>", "<C-o>I")
map("i", "<M-j>", "<C-o>o")
map("i", "<M-k>", "<C-o>O")
map("i", "<M-l>", "<C-o>A")

-- Toggle word wrap
map("n", "<leader>cw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end)

vim.opt.wrap = false
