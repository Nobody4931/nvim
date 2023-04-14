return {
	{
		"hrsh7th/nvim-cmp",

		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},

		event = "InsertEnter",

		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = {
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							cmp.complete()
						end
					end, { "i", "s" }),

					["<C-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							cmp.complete()
						end
					end, { "i", "s" }),

					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),

					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
				},

				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{
						name = "buffer",
						option = {
							-- Provide completion from all visible buffers (with size < 512 KiB)
							get_bufnrs = function()
								local tab_wins = vim.api.nvim_tabpage_list_wins(0)
								local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
								return vim.tbl_filter(function(bufnr)
									local bytes = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
									return bytes < 1024 * 512
								end, tab_bufs)
							end
						}
					}
				},

				experimental = {
					ghost_text = true,
				},
			}
		end,

		config = function(_plugin, opts)
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			vim.opt.pumheight = 25
			vim.opt.pumwidth = 15

			require("cmp").setup(opts)
		end
	},
}
