return {
	-- Better vim.notify()
	{
		"rcarriga/nvim-notify",

		lazy = false,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
			},
		},

		opts = {
			timeout = 3000,
			render = "compact",
			stages = "fade",
			background_colour = "#000000", -- Just to shut up the transparent background color warning
			max_height = function()
				return math.floor(vim.o.lines * 0.5)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.5)
			end,
			on_open = function(window)
				vim.api.nvim_win_set_config(window, { zindex = 150 }) -- Ensure topmost
			end,
		},

		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)

			-- Replace the default vim.notify() function
			vim.notify = notify
		end,
	},

	-- Customizable statusline
	{
		"nvim-lualine/lualine.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		event = "VeryLazy",

		opts = function()
			local component_mode = function()
				return "正"
			end

			local component_branch = "branch"
			local component_diff = "diff"
			local component_diagnostics = { "diagnostics",
				sources = { "nvim_lsp", "nvim_diagnostic" },
			}

			local component_filename = { "filename",
				path = 1,
			}

			local component_filesize = "filesize"
			local component_filetype = { "filetype",
				icon = { align = "right" },
			}

			local component_progress = "progress"

			local component_location = "location"

			return {
				options = {
					theme = "catppuccin",
					icons_enabled = true,
					globalstatus = false,
					always_divide_middle = true,
					component_separators = "",
					section_separators = "",
				},

				sections = {
					lualine_a = { component_mode },
					lualine_b = { component_branch, component_diff, component_diagnostics },
					lualine_c = { component_filename },
					lualine_x = { component_filesize, component_filetype },
					lualine_y = { component_progress },
					lualine_z = { component_location },
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { component_filename },
					lualine_x = { component_location },
					lualine_y = {},
					lualine_z = {},
				},

				tabline = {},
				winbar = {},
				inactive_winbar = {},

				extensions = {
					-- TODO: Come back to this later after adding more plugins
					"quickfix",
					"man",
					"lazy",
					"neo-tree",
				},
			}
		end,

		config = function(_, opts)
			vim.opt.laststatus = 2 -- always show statusline
			vim.opt.showtabline = 0 -- never show tabline
			vim.opt.showmode = false -- don't show mode at the bottom
			vim.opt.showcmd = true -- show pending command at the bottom
			vim.opt.cmdheight = 1

			require("lualine").setup(opts)
		end,
	},

	-- Adds indentation guides
	{
		"lukas-reineke/indent-blankline.nvim", main = "ibl",

		event = "BufReadPost",

		opts = {
			scope = {
				enabled = false,
			},
		},

		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	-- Highlights other occurrences the word under the cursor
	{
		"RRethy/vim-illuminate",

		event = "BufReadPost",
		keys = {
			{ "[[", function() require("illuminate").goto_prev_reference() end },
			{ "]]", function() require("illuminate").goto_next_reference() end },
		},

		opts = {
			delay = 100,
			large_file_cutoff = 1000,
			providers = { "lsp", "treesitter" },
		},

		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
