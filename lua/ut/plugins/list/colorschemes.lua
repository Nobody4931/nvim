local colors = require("ut.util.colors")

return {
	{
		"folke/tokyonight.nvim",

		opts = {
			style = "storm",
			transparent = true,
			terminal_colors = true,

			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = {},
				variables = {},
				sidebars = "transparent",
				floats = "dark",
			},

			sidebars = { "help", "qf" },

			hide_inactive_statusline = false,
			dim_inactive = false,
			lualine_bold = true,

			---@diagnostic disable-next-line: unused-local
			on_highlights = function(highlights, _color)
				local bg_trans = { bg = "NONE" }

				highlights.TelescopeNormal = vim.tbl_extend("keep", bg_trans, highlights.TelescopeNormal or {})
				highlights.TelescopeBorder = vim.tbl_extend("keep", bg_trans, highlights.TelescopeBorder or {})

				highlights.FTermNormal = vim.tbl_extend("keep", bg_trans, highlights.NormalFloat or {})
				highlights.FloatBorder = vim.tbl_extend("keep", bg_trans, highlights.FloatBorder or {})
			end
		},

		init = function()
			if colors.colorscheme == "tokyonight" then
				vim.opt.termguicolors = true
				vim.cmd.colorscheme(colors.colorscheme)
			end
		end,

		---@diagnostic disable-next-line: unused-local
		config = function(_plugins, opts)
			require("tokyonight").setup(opts)
		end
	},

	{
		"catppuccin/nvim", name = "catppuccin.nvim",

		opts = {
			flavour = "mocha",
			transparent_background = false,
			show_end_of_buffer = true,
			term_colors = true,
			dim_inactive = {
				enabled = false,
			},

			no_italic = true,
			no_bold = true,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},

			color_overrides = {},
			custom_highlights = function(color)
				local bg_dark = { bg = color.mantle }

				return {
					TelescopeNormal = bg_dark,
					TelescopeBorder = bg_dark,

					FTermNormal = bg_dark,
					FloatBorder = bg_dark,
				}
			end,

			integrations = {
				treesitter = true,
			}
		},

		init = function()
			if colors.colorscheme == "catppuccin" then
				vim.opt.termguicolors = true
				vim.cmd.colorscheme(colors.colorscheme)
			end
		end,

		---@diagnostic disable-next-line: unused-local
		config = function(_plugin, opts)
			require("catppuccin").setup(opts)
		end
	},
}
