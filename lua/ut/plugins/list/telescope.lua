return {
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		cmd = "Telescope",
		keys = {
			{ "<leader>sf", function() require("telescope.builtin").find_files({ no_ignore = false }) end },
			{ "<leader>sF", function() require("telescope.builtin").find_files({ no_ignore = true  }) end },
			{ "<leader>sg", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Find Word: ") }) end },
			{ "<leader>sG", function() require("telescope.builtin").live_grep() end },
			{ "<leader>sh", function() require("telescope.builtin").help_tags() end },
			{ "<leader>sm", function() require("telescope.builtin").man_pages() end },
			{ "<leader>so", function() require("telescope.builtin").oldfiles() end },
			{ "<leader>sv", function() require("telescope.builtin").find_files({ prompt_title = "Vim Files", cwd = vim.fn.stdpath("config") }) end },
		},

		opts = {
			defaults = {
				prompt_prefix   = " > ",
				entry_prefix    = "  ",
				selection_caret = "> ",

				file_ignore_patterns = {
					"%.git$", "%.git[/\\]", "node_modules"
				}
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sortes = true,
					case_mode = "smart_case",
				}
			}
		},

		---@diagnostic disable-next-line: unused-local
		config = function(_plugins, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			-- Mapping configuration
			local dual_mode_maps = {
				["<CR>"] = actions.select_default,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<M-j>"] = actions.toggle_selection + actions.move_selection_next,
				["<M-k>"] = actions.toggle_selection + actions.move_selection_previous,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			}

			local insert_mode_maps = {
				["<C-w>"] = { "<C-S-w>", type = "command" },
			}

			local normal_mode_maps = {
				["<Esc>"] = actions.close,
				["<C-c>"] = actions.close,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["J"] = actions.toggle_selection + actions.move_selection_next,
				["K"] = actions.toggle_selection + actions.move_selection_previous,

				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
			}

			opts.defaults.default_mappings = {}
			opts.defaults.default_mappings.i = vim.tbl_extend("error", dual_mode_maps, insert_mode_maps)
			opts.defaults.default_mappings.n = vim.tbl_extend("error", dual_mode_maps, normal_mode_maps)

			-- Setup telescope.nvim
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end
	},
}
