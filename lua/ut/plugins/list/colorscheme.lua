return {
	{
		"catppuccin/nvim", name = "catppuccin.nvim",

		opts = {
			flavour = "mocha",
			transparent_background = true,
			term_colors = true,

			dim_inactive = {
				enabled = false,
			},

			no_italic = true,
			no_bold = false,
			no_underline = false,

			custom_highlights = function(colors)
				return {
					-- Make telescope's floating windows transparent
					TelescopeNormal = { bg = colors.none, fg = colors.text },
					TelescopeBorder = { bg = colors.none, fg = colors.blue },
					TelescopeTitle = { bg = colors.none, fg = colors.blue },

					-- Make neotree's floating windows transparent
					NeoTreeFloatBorder = { bg = colors.none },
					NeoTreeFloatTitle = { bg = colors.none },
					-- Make NeoTree's inactive black statusline transparent
					NeoTreeStatusLineNC = { bg = colors.none },

					-- Make floating windows opaque
					NormalFloat = { bg = colors.base },
					FloatBorder = { bg = colors.base },
					FloatTitle = { bg = colors.base },
				}
			end,

			integrations = {
				-- TODO: Come back to this later after adding more plugins
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				markdown = true,
				mason = true,
				neotree = true,
				neogit = true,
				cmp = true,
				native_lsp = {
					enabled = true,
				},
				notify = true,
				semantic_tokens = true,
				treesitter = true,
				telescope = {
					enabled = true,
				},
				illuminate = {
					enabled = true,
					lsp = false,
				},
			},
		},

		init = function()
			vim.opt.background = "dark"
			vim.opt.termguicolors = true
			vim.cmd.colorscheme("catppuccin")
		end,

		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},
}
