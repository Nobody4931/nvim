return {
	{
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		event = "BufReadPost",

		opts = {
			ensure_installed = { "comment", "vimdoc", "vim", "lua" },
			ignore_install = { "markdown" },
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},

			incremental_selection = {
				enable = true,
				disable = {},
				keymaps = {
					init_selection    = "<C-Space>",
					node_incremental  = "<C-Space>",
					scope_incremental = "<M-Space>",
					node_decremental  = "<C-Backspace>",
				}
			},

			indent = {
				enable = true,
				disable = {},
			},

			textobjects = {
				select = {
					enable = true,
					disable = {},

					lookahead = true,
					include_surrounding_whitespace = false,

					keymaps = {
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",

						["ic"] = "@class.inner",
						["ac"] = "@class.outer",
						["if"] = "@function.inner",
						["af"] = "@function.outer",

						["in"] = "@conditional.inner",
						["an"] = "@conditional.outer",
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",

						["ix"] = "@call.inner",
						["ax"] = "@call.outer",
						["ie"] = "@parameter.inner",
						["ae"] = "@parameter.outer",

						["am"] = "@comment.outer",
					},

					selection_modes = {
						["@block.inner"] = "v",
						["@block.outer"] = "V",

						["@function.inner"] = "v",
						["@function.outer"] = "V",
						["@class.inner"] = "v",
						["@class.outer"] = "V",

						["@conditional.inner"] = "v",
						["@conditional.outer"] = "V",
						["@loop.inner"] = "v",
						["@loop.outer"] = "V",

						["@call.inner"] = "v",
						["@call.outer"] = "v",
						["@parameter.inner"] = "v",
						["@parameter.outer"] = "v",

						["@comment.outer"] = "v",
					},
				},

				move = {
					enable = true,
					disable = {},

					set_jumps = true,

					goto_next_start = {
						["<M-b>"] = "@block.outer",

						["<M-c>"] = "@class.outer",
						["<M-f>"] = "@function.outer",

						["<M-n>"] = "@conditional.outer",
						["<M-l>"] = "@loop.outer",

						["<M-x>"] = "@call.outer",
						["<M-e>"] = "@parameter.outer",

						["<M-m>"] = "@comment.outer",
					},

					goto_next_end = {
						["g<M-b>"] = "@block.outer",

						["g<M-c>"] = "@class.outer",
						["g<M-f>"] = "@function.outer",

						["g<M-n>"] = "@conditional.outer",
						["g<M-l>"] = "@loop.outer",

						["g<M-x>"] = "@call.outer",
						["g<M-e>"] = "@parameter.outer",

						["g<M-m>"] = "@comment.outer",
					},

					goto_previous_start = {
						["<M-S-b>"] = "@block.outer",

						["<M-S-c>"] = "@class.outer",
						["<M-S-f>"] = "@function.outer",

						["<M-S-n>"] = "@conditional.outer",
						["<M-S-l>"] = "@loop.outer",

						["<M-S-x>"] = "@call.outer",
						["<M-S-e>"] = "@parameter.outer",

						["<M-S-m>"] = "@comment.outer",
					},

					goto_previous_end = {
						["g<M-S-b>"] = "@block.outer",

						["g<M-S-c>"] = "@class.outer",
						["g<M-S-f>"] = "@function.outer",

						["g<M-S-n>"] = "@conditional.outer",
						["g<M-S-l>"] = "@loop.outer",

						["g<M-S-x>"] = "@call.outer",
						["g<M-S-e>"] = "@parameter.outer",

						["g<M-S-m>"] = "@comment.outer",
					},
				},

				swap = {
					enable = true,
					disable = {},

					swap_next = {
						["<leader>wn"] = "@parameter.inner"
					},

					swap_previous = {
						["<leader>wp"] = "@parameter.inner"
					},
				},

				lsp_interop = {
					enable = false,
				}
			},
		},

		config = function(_plugin, opts)
			-- Folding module
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false

			-- Setup nvim-treesitter
			require("nvim-treesitter.configs").setup(opts)
		end
	},
}
