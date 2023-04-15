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

			-- Close the window if nvim-tree is the last remaining window in the tab
			-- Close vim if nvim-tree is the last remaining window in the entire runtime
			vim.api.nvim_create_autocmd("WinClosed", {
				group = vim.api.nvim_create_augroup("auto_close_nvim_tree", { clear = true }),
				callback = function()
					local winnr = tonumber(vim.fn.expand("<amatch>"))
					vim.schedule(function()
						local utils = require("nvim-tree.utils")
						local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(0))
						local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
						if #tab_bufs == 1 and utils.is_nvim_tree_buf(tab_bufs[1]) then
							if #vim.api.nvim_list_wins() == 1 then
								vim.cmd.quit()
							else
								vim.api.nvim_win_close(tab_wins[1], true)
							end
						end
					end)
				end
			})
		end
	},
}
