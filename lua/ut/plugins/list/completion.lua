return {
	-- Completion provider
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
		},

		event = { 'InsertEnter', 'CmdlineEnter' },

		opts = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			return {
				core = {
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},

					completion = {
						keyword_length = 1,
					},

					mapping = {
						['<C-n>'] = cmp.mapping(function()
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								cmp.complete()
							end
						end, { 'i', 's' }),

						['<C-p>'] = cmp.mapping(function()
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								cmp.complete()
							end
						end, { 'i', 's' }),

						['<C-s>'] = cmp.mapping.confirm({ select = true }),
						['<C-g>'] = cmp.mapping.abort(),

						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
					},

					sources = {
						{ name = 'nvim_lsp' },
						{ name = 'path' },
						{
							name = 'buffer',
							option = {
								-- Provide completion from all visible buffers (with size < 2 MiB)
								get_bufnrs = function()
									local tab_wins = vim.api.nvim_tabpage_list_wins(0)
									local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
									return vim.tbl_filter(function(bufnr)
										local bytes =
											vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
										return bytes < 1024 * 1024 * 2
									end, tab_bufs)
								end,
							},
						},
					},

					experimental = {
						ghost_text = true,
					},
				},

				cmdline = {
					mapping = {
						['<Tab>'] = cmp.mapping(function()
							if cmp.visible() then
								cmp.select_next_item()
							else
								cmp.complete()
							end
						end, { 'c' }),

						['<S-Tab>'] = cmp.mapping(function()
							if cmp.visible() then
								cmp.select_prev_item()
							else
								cmp.complete()
							end
						end, { 'c' }),

						['<C-s>'] = cmp.mapping.confirm({ select = true }),
						['<C-g>'] = cmp.mapping.abort(),
					},

					sources = {
						{ name = 'cmdline' },
						{ name = 'path' },
					},
				},
			}
		end,

		config = function(_, opts)
			vim.opt.pumheight = math.floor(vim.o.lines * 0.5)
			vim.opt.pumwidth = math.floor(vim.o.columns * 0.5)

			local cmp = require('cmp')

			cmp.setup(opts.core)
			cmp.setup.cmdline(':', opts.cmdline)
		end,
	},
}
