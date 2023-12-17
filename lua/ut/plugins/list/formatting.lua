return {
	-- Lightweight formatter plugin that works alongside the native LSP client
	{
		'stevearc/conform.nvim',

		dependencies = {
			'williamboman/mason.nvim',
		},

		event = 'BufReadPost',

		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
			},
		},

		config = function(_, opts)
			local conform = require('conform')
			conform.setup(opts)

			vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

			-- Automatically install missing formatters
			local mason_registry = require('mason-registry')
			for _, formatters in pairs(opts.formatters_by_ft) do
				for _, formatter in ipairs(formatters) do
					local formatter_pkg = mason_registry.get_package(formatter)
					if not formatter_pkg:is_installed() then
						formatter_pkg:install()
					end
				end
			end

			-- Formatter runner
			vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
				group = vim.api.nvim_create_augroup('run_formatters', { clear = true }),
				callback = function(args)
					conform.format({ bufnr = args.buf, async = false })
				end,
			})
		end,
	},
}
