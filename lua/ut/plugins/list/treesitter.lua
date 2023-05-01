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

						["im"] = "@comment.outer",
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
						["]B"] = "@block.inner",
						["]b"] = "@block.outer",

						["]C"] = "@class.inner",
						["]c"] = "@class.outer",
						["]F"] = "@function.inner",
						["]f"] = "@function.outer",

						["]N"] = "@conditional.inner",
						["]n"] = "@conditional.outer",
						["]L"] = "@loop.inner",
						["]l"] = "@loop.outer",

						["]X"] = "@call.inner",
						["]x"] = "@call.outer",
						["]e"] = "@parameter.inner",

						["]m"] = "@comment.outer",
					},

					goto_next_end = {
						["g]B"] = "@block.inner",
						["g]b"] = "@block.outer",

						["g]C"] = "@class.inner",
						["g]c"] = "@class.outer",
						["g]F"] = "@function.inner",
						["g]f"] = "@function.outer",

						["g]N"] = "@conditional.inner",
						["g]n"] = "@conditional.outer",
						["g]L"] = "@loop.inner",
						["g]l"] = "@loop.outer",

						["g]X"] = "@call.inner",
						["g]x"] = "@call.outer",
						["g]e"] = "@parameter.inner",

						["g]m"] = "@comment.outer",
					},

					goto_previous_start = {
						["[B"] = "@block.inner",
						["[b"] = "@block.outer",

						["[C"] = "@class.inner",
						["[c"] = "@class.outer",
						["[F"] = "@function.inner",
						["[f"] = "@function.outer",

						["[N"] = "@conditional.inner",
						["[n"] = "@conditional.outer",
						["[L"] = "@loop.inner",
						["[l"] = "@loop.outer",

						["[X"] = "@call.inner",
						["[x"] = "@call.outer",
						["[e"] = "@parameter.inner",

						["[m"] = "@comment.outer",
					},

					goto_previous_end = {
						["g[B"] = "@block.inner",
						["g[b"] = "@block.outer",

						["g[C"] = "@class.inner",
						["g[c"] = "@class.outer",
						["g[F"] = "@function.inner",
						["g[f"] = "@function.outer",

						["g[N"] = "@conditional.inner",
						["g[n"] = "@conditional.outer",
						["g[L"] = "@loop.inner",
						["g[l"] = "@loop.outer",

						["g[X"] = "@call.inner",
						["g[x"] = "@call.outer",
						["g[e"] = "@parameter.inner",

						["g[m"] = "@comment.outer",
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

		---@diagnostic disable-next-line: unused-local
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
