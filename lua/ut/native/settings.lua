local env = require("ut.util.env")

local g = vim.g
local o = vim.opt

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- Rendering
o.wrap = false
o.lazyredraw = true
o.conceallevel = 3

-- Recovery files
o.backup = false
o.writebackup = true
o.swapfile = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Mouse and cursor
o.mouse = ""
o.guicursor = "a:block"
o.cursorcolumn = false
o.cursorline = true

-- Screen scrolling
o.scrolloff = 0
o.scrolljump = 1
o.sidescrolloff = 0
o.sidescroll = 1

-- Mappings
o.timeout = false
o.ttimeout = true

-- Buffers
o.hidden = true
o.autoread = true

-- Indentation
o.autoindent = true
o.smartindent = true

o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4

-- Splitting windows
o.splitbelow = true
o.splitright = true

-- Searching
o.incsearch = true
o.hlsearch = false

o.matchpairs:append("<:>")

-- Windows specific settings
if env.get_os() == "Windows_NT" then
	o.shell = vim.fn.shellescape(vim.fs.normalize("$ProgramW6432/Git/bin/bash.exe"))
	o.shellslash = true
	-- thanks vim for not automatically setting half of these!
	o.shellcmdflag = "-c"
	o.shellpipe = "2>&1| tee"
	o.shellredir = ">%s 2>&1"
	o.shellquote = ""
	o.shellxquote = ""
end

-- GUI Neovim specific settings
if env.is_gui_nvim() then
	o.guifont = "ProggyVector NF:h11:#e-subpixelantialias"
end

-- Neovide specific settings
if env.is_neovide() then
	g.neovide_fullscreen = false
	g.neovide_remember_window_size = true

	g.neovide_transparency = 1

	g.neovide_floating_blur_amount_x = 0
	g.neovide_floating_blur_amount_y = 0

	g.neovide_hide_mouse_when_typing = false

	g.neovide_scroll_animation_length = 0
	g.neovide_cursor_animation_length = 0
	g.neovide_cursor_trail_size = 0
	g.neovide_cursor_vfx_mode = ""
end
