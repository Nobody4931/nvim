return {
	-- Highly customizable file tree focused on good user experience
	{
		"nvim-neo-tree/neo-tree.nvim", branch = "v3.x",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},

		cmd = "Neotree",
		keys = {
			{ "<leader>et", function() require("neo-tree.command").execute({ action = "show", toggle = true }) end },
			{ "<leader>eT", function() require("neo-tree.command").execute({ action = "focus", toggle = true }) end },
			{ "<leader>ef", function() require("neo-tree.command").execute({ action = "focus" }) end },
			{ "<leader>eF", function() require("neo-tree.command").execute({ action = "focus", reveal_file = vim.fn.expand("%:p") }) end },
		},

		opts = {
			close_if_last_window = false,
			popup_border_style = "rounded",

			enable_git_status = true,
			enable_diagnostics = true,
			enable_normal_mode_for_inputs = false,
			sort_case_insensitive = false,

			default_component_configs = {
				container = {
					enable_character_fade = false,
				},
				indent = {
					with_expanders = true,
				},
				modified = {
					symbol = "[+]",
				},
				name = {
					trailing_slash = true,
					use_git_status_colors = false,
				},
				git_status = {
					symbols = {
						added     = "A",
						modified  = "M",
						deleted   = "D",
						renamed   = "R",
						untracked = "?",
						ignored   = "",
						unstaged  = "",
						staged    = "",
						conflict  = "",
					}
				},
				symlink_target = {
					enabled = true,
				},
			},

			window = {
				position = "left",
				width = "20%",
				mappings = {
					["<Space>"] = "none",
					["e"] = "open",
				},
			},

			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = false,
				},
			},
		},

		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
}
