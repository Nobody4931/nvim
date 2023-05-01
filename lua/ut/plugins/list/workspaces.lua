return {
	{
		"natecraddock/workspaces.nvim",

		dependencies = {
			"nvim-telescope/telescope.nvim"
		},

		keys = {
			{ "<leader>sp", function() require("telescope").extensions.workspaces.workspaces(require("telescope.themes").get_dropdown()) end },
		},

		opts = {
			path = vim.fn.stdpath("data") .. "/workspaces",

			cd_type = "global",

			sort = true,
			mru_sort = true,
			auto_open = false,
			notify_info = false,
			hooks = {
				add = {},
				remove = {},
				rename = {},
				open_pre = {},
				open = {},
			},
		},

		---@diagnostic disable-next-line: unused-local
		config = function(_plugin, opts)
			require("workspaces").setup(opts)
			require("telescope").load_extension("workspaces")
		end
	}
}
