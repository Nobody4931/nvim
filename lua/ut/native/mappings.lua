local map = vim.keymap.set

-- Entering normal mode
map({"", "i"}, "<C-c>", "<Esc>") -- Ctrl+C in insert-like modes
map("t", "<C-q>", "<C-\\><C-n>") -- Ctrl+Q in terminal mode

-- Alternate file alternative
map("n", "gb", "<C-^>")

-- CD into directory of current file
map("n", "gcd", "<CMD>cd %:h<CR>")

-- Send numeric up/down movements to jumplist
map("n", "j", [[(v:count > 0 ? "m'" . v:count : '') . 'j']], { expr = true })
map("n", "k", [[(v:count > 0 ? "m'" . v:count : '') . 'k']], { expr = true })

-- Copy to system register
map("n", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")
map("v", "<leader>y", "\"+y")

-- Paste from system register
map("n", "<leader>p", "\"+p")
map("n", "<leader>P", "\"+P")
map("v", "<leader>p", "\"+p")

-- Delete without replacing register contents
map("n", "<leader>d", "\"_d")
map("n", "<leader>D", "\"_D")
map("v", "<leader>d", "\"_d")

-- Paste without replacing register contents
map("v", "<leader>P", "\"_dP")

-- Center cursor while navigating
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Quickfix/Location list navigation
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

-- Windows specific mappings
if require("ut.util.env").get_os() == "Windows_NT" then
	-- Disable man lookup
	map("n", "K", "<NOP>")
end
