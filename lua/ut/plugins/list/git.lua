return {
	{
		"NeogitOrg/neogit",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},

		keys = {
			{ "<leader>gg", function() require("neogit").open() end },
			{ "<leader>gb", function() require("neogit").open({ "branch" }) end },
			{ "<leader>gc", function() require("neogit").open({ "commit" }) end },
			{ "<leader>gl", function() require("neogit").open({ "log" }) end },
			{ "<leader>gd", function() require("neogit").open({ "diff" }) end },
			{ "<leader>gf", function() require("neogit").open({ "fetch" }) end },
			{ "<leader>gp", function() require("neogit").open({ "pull" }) end },
			{ "<leader>gP", function() require("neogit").open({ "push" }) end },
		},

		opts = {
			graph_style = "unicode",

			disable_hint = true,
			disable_context_highlighting = false,
			disable_signs = false,
			disable_commit_confirmation = false,
			disable_insert_on_commit = true,
			disable_line_numbers = true,

			remember_settings = false,
			use_per_project_settings = true,

			kind = "split",

			popup = { kind = "split" },
			preview_buffer = { kind = "split" },
			commit_select_view = { kind = "split" },
			commit_view = { kind = "vsplit" },

			commit_editor = { kind = "auto" },
			rebase_editor = { kind = "auto" },
			merge_editor = { kind = "auto" },
			tag_editor = { kind = "auto" },

			log_view = { kind = "replace" },
			reflog_view = { kind = "replace" },

			telescope_sorter = function()
				return require("telescope").extensions.fzf.native_fzf_sorter()
			end,
		},

		config = function(_, opts)
			require("neogit").setup(opts)
		end,
	},
}
