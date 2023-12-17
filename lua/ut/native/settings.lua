local opt = vim.opt

-- Mappings
vim.g.mapleader = " " -- set the leader key to space
vim.g.maplocalleader = " " -- set the buffer local leader key to space
opt.timeout = false -- remove timeout for mappings

-- Buffers
opt.hidden = true -- keep buffers open in the background
opt.autoread = true -- read and update for external changes to files

-- Recovery files
opt.writebackup = true -- save backup before writing to files
opt.backup = false -- delete backup after writing to files
opt.undofile = true -- save undo history
opt.swapfile = true -- use swapfiles for buffers

-- Rendering
opt.lazyredraw = true -- reduce unnecessary screen redraws
opt.cursorline = true -- highlight the line the cursor is on
opt.cursorcolumn = false -- don't highlight the column the cursor is on
opt.guicursor = "a:block" -- use block cursor for all modes

-- Indentation
opt.autoindent = true -- enable auto indent
opt.smartindent = true -- enable smart indent
opt.expandtab = false -- don't expand tabs into spaces
opt.tabstop = 4 -- make tabs 4 spaces wide
opt.shiftwidth = 4 -- make indents 4 spaces wide

-- Splits
opt.splitbelow = true -- open horizontal splits on the bottom
opt.splitright = true -- open vertical splits on the right

-- Searching
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- don't ignore case when the search query has both uppercase and lowercase
opt.incsearch = true -- show search results incrementally
opt.hlsearch = false -- don't highlight search results

opt.matchpairs:append("<:>") -- TODO: Find somewhere to put this?

-- TODO: Make an autocmd for setting 'conceallevel' on 'help' files
