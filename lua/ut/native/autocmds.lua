local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local augroup_opts = { clear = true }

-- Toggle relative numbers when entering/leaving insert mode
local number_toggle = augroup("number_toggle", augroup_opts)

vim.opt.number = true
vim.opt.relativenumber = true

autocmd("InsertEnter", {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd("InsertLeave", {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Clean trailing whitespace on save
local clean_whitespace = augroup("clean_whitespace", augroup_opts)

autocmd("BufWritePre", {
  group = clean_whitespace,
  callback = function()
    vim.cmd([[normal mz]])
    vim.cmd([[silent! keepjumps %s/\s\+$//e]])
    vim.cmd([[normal g`z]])
  end,
})

-- Enforce 'formatoptions' setting
local format_options = augroup("format_options", augroup_opts)

autocmd("BufEnter", {
  group = format_options,
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - "t" -- don't wrap text using 'textwidth'
      + "c" -- wrap comments using 'textwidth'
      + "r" -- continue comments with newline in insert mode
      - "o" -- don't continue comments with newline in normal mode
      + "q" -- format comments with 'gq'
      - "a" -- don't auto format text
      + "n" -- auto format numbered lists
      + "j" -- remove comment leaders when joining lines
  end,
})
