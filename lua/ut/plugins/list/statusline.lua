return {
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
				sections = { "error", "warn", "info" },
			}

			local component_filename = { "filename",
				path = 1,
				file_status = true,
			}

			local component_filesize = "filesize"
			local component_filetype = { "filetype",
				colored = true,
				icon = { align = "left" },
			}

			local component_progress = "progress"

			local component_location = "location"

			return {
				options = {
					theme = "auto",
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
					"quickfix",
					"nvim-tree",
				},
			}
		end,

		config = function(_plugin, opts)
			vim.opt.laststatus = 2
			vim.opt.ruler = false
			vim.opt.showmode = false
			vim.opt.showcmd = true
			vim.opt.cmdheight = 1

			require("lualine").setup(opts)
		end
	},
}
