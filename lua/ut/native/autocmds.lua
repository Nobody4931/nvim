local new_aug = vim.api.nvim_create_augroup
local new_au = vim.api.nvim_create_autocmd

local aug_opt = { clear = true }

-- Line number toggle
local number_toggle = new_aug("number_toggle", aug_opt)

vim.opt.signcolumn = "no"
vim.opt.number = true
vim.opt.relativenumber = true

new_au("InsertEnter", {
	group = number_toggle,
	callback = function()
		vim.opt.relativenumber = false
	end
})

new_au("InsertLeave", {
	group = number_toggle,
	callback = function()
		vim.opt.relativenumber = true
	end
})

-- Clean trailing whitespace on save
local clean_whitespace = new_aug("clean_whitespace", aug_opt)

new_au("BufWritePre", {
	group = clean_whitespace,
	callback = function()
		vim.cmd([[normal mz]])
		vim.cmd([[silent! keepjumps %s/\s\+$//e]])
		vim.cmd([[normal g`z]])
	end
})

-- Fix 'formatoptions' setting
local format_options = new_aug("format_options", aug_opt)

new_au("BufEnter", {
	group = format_options,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end
})
