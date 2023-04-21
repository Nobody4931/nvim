return {
	{
		"nvim-tree/nvim-tree.lua",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		cmd = "NvimTreeToggle",
		keys = {
			{ "<leader>et", function() require("nvim-tree.api").tree.toggle() end },
			{ "<leader>ef", function() require("nvim-tree.api").tree.focus() end },
			{ "<leader>eF", function() require("nvim-tree.api").tree.find_file({ open = true, focus = true, current_window = false }) end },
		},

		opts = {
			sort_by = "name",
			sync_root_with_cwd = true,

			view = {
				width = "20%",
				side = "left",
			},

			renderer = {
				add_trailing = true,
				group_empty = false,
				root_folder_label = function(path)
					return vim.fn.fnamemodify(vim.fs.normalize(path), ":~")
				end,
				indent_width = 2,
				indent_markers = {
					enable = true,
				},
				special_files = {},
			},

			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},

			filesystem_watchers = {
				enable = true,
			},

			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},

			modified = {
				enable = false,
			},

			actions = {
				change_dir = {
					global = true,
				},
				file_popup = {
					open_win_config = {
						border = "none",
					},
				},
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
		},

		---@diagnostic disable-next-line: unused-local
		config = function(_plugin, opts)
			require("nvim-tree").setup(opts)
		end
	},
}
