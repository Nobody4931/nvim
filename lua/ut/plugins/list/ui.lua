return {
	-- Better vim.notify()
	{
		"rcarriga/nvim-notify",

		lazy = false,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
			},
		},

		opts = {
			timeout = 3000,
			render = "compact",
			stages = "fade",
			background_colour = "#000000", -- Just to shut up the transparent background color warning
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(window)
				vim.api.nvim_win_set_config(window, { zindex = 150 }) -- Ensure topmost
			end,
		},

		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)

			-- Replace the default vim.notify() function
			vim.notify = notify
		end,
	},
}
