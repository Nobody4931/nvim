local readme_path = vim.fn.stdpath("state") .. "/lazy/readme"
local state_path = vim.fn.stdpath("state") .. "/lazy/state.json"
local lock_path = vim.fn.stdpath("config") .. "/lazy_lock.json"
local root_path = vim.fn.stdpath("data") .. "/lazy"
local lazy_path = root_path .. "/lazy.nvim"

-- Bootstrap lazy.nvim on first run
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path })
end

vim.opt.rtp:prepend(lazy_path)

local lazy = require("lazy")

-- Configure lazy.nvim and load plugins
lazy.setup("ut.plugins.list", {
	root = root_path,
	state = state_path,
	lockfile = lock_path,
	defaults = {
		lazy = true,
	},
	install = {
		missing = true,
		colorscheme = { "catppuccin", "habamax" },
	},
	ui = {
		border = "none",
		size = {
			width = 0.8,
			height = 0.8,
		},
		icons = {
			cmd = "",
			config = "",
			event = "",
			ft = "",
			init = "",
			import = "",
			keys = "",
			lazy = "",
			loaded = "",
			not_loaded = "",
			plugin = "",
			runtime = "",
			source = "",
			start = "",
			task = "",
			list = {
				"",
				"➜",
				"",
				"➜",
			},
		},
		custom_keys = {
			["<localleader>l"] = false,
			["<localleader>t"] = false,
		},
	},
	checker = {
		enabled = false,
	},
	change_detection = {
		enabled = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			reset = true,
			disabled_plugins = {
				"gzip",
				"tar",
				"tarPlugin",
				"zip",
				"zipPlugin",
				"getscript",
				"getscriptPlugin",
				"vimball",
				"vimballPlugin",
				-- "matchit",
				-- "matchparen",
				"2html_plugin",
				"logiPat",
				"rrhelper",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tohtml",
				"tutor",
			},
		},
	},
	readme = {
		enabled = true,
		root = readme_path,
		skip_if_doc_exists = true,
	},
})

-- Display startup time after loading
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	group = vim.api.nvim_create_augroup("display_startuptime", { clear = true }),
	callback = vim.schedule_wrap(function()
		local stats = lazy.stats()
		vim.notify(string.format("Loaded with %d plugins in %.2fms", stats.count, stats.startuptime), vim.log.levels.INFO, { title = "Neovim" })
	end)
})
