return {
	{
		"catppuccin/nvim", name = "catppuccin.nvim",

		lazy = true,

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

			color_overrides = {},
			custom_highlights = {},
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
					lsp = true,
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
		end
	},
}
