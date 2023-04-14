return {
	{
		"numToStr/Comment.nvim",

		keys = function(plugin)
			local opts = plugin.opts
			return {
				{ opts.toggler.line },
				{ opts.toggler.block },
				{ opts.opleader.line, mode = { "n", "x" } },
				{ opts.opleader.block, mode = { "n", "x" } },
				{ opts.extra.above },
				{ opts.extra.below },
				{ opts.extra.eol },
			}
		end,

		opts = {
			padding = true,
			sticky = true,

			toggler = {
				line = "<leader>cll",
				block = "<leader>cbb",
			},

			opleader = {
				line = "<leader>cl",
				block = "<leader>cb",
			},

			extra = {
				above = "<leader>cO",
				below = "<leader>co",
				eol = "<leader>cA",
			},

			mappings = {
				basic = true,
				extra = true,
			},
		},

		config = function(_plugin, opts)
			require("Comment").setup(opts)
		end
	},

	{
		"echasnovski/mini.align",

		keys = function(plugin)
			local opts = plugin.opts
			return {
				{ opts.mappings.start, mode = { "n", "x" } },
				{ opts.mappings.start_with_preview, mode = { "n", "x" } },
			}
		end,

		opts = {
			mappings = {
				start = "<leader>a",
				start_with_preview = "<leader>A",
			}
		},

		config = function(_plugin, opts)
			require("mini.align").setup(opts)
		end
	},

	{
		"echasnovski/mini.move",

		keys = function(plugin)
			local opts = plugin.opts
			return {
				{ opts.mappings.left, mode = "x" },
				{ opts.mappings.right, mode = "x" },
				{ opts.mappings.down, mode = "x" },
				{ opts.mappings.up, mode = "x" },
			}
		end,

		opts = {
			mappings = {
				left = "H",
				right = "L",
				down = "J",
				up = "K",

				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			}
		},

		config = function(_plugin, opts)
			require("mini.move").setup(opts)
		end
	},

	{
		"echasnovski/mini.surround",

		keys = function(plugin)
			local opts = plugin.opts
			return {
				{ opts.mappings.add, mode = { "n", "x" } },
				{ opts.mappings.replace },
				{ opts.mappings.delete },
				{ opts.mappings.find },
				{ opts.mappings.find_left },
			}
		end,

		opts = {
			mappings = {
				add = "<leader>ra",
				replace = "<leader>rr",
				delete = "<leader>rd",
				find = "<leader>rn",
				find_left = "<leader>rp",
				highlight = "",

				update_n_lines = "",

				suffix_last = "",
				suffix_next = "",
			},

			search_method = "cover",
			n_lines = 50,
		},

		config = function(_plugin, opts)
			require("mini.surround").setup(opts)
		end
	},
}
