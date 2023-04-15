return {
	{
		"williamboman/mason.nvim",

		cmd = "Mason",

		opts = {
			install_root_dir = vim.fn.stdpath("data") .. "/mason",
			max_concurrent_installers = 2,

			ui = {
				border = "none",
				width = 0.8,
				height = 0.8,

				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		},

		---@diagnostic disable-next-line: unused-local
		config = function(_plugin, opts)
			require("mason").setup(opts)
		end
	},

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},

		event = "BufReadPre",

		opts = {
			-- Options passed to `vim.diagnostic.config()`
			diagnostic = {
				underline = true,
				virtual_text = true,
				signs = false,
				update_in_insert = false,
				severity_sort = true,
			},

			-- Options passed to `nvim_lsp[server].setup()`
			servers = {
				rust_analyzer = {},
				gopls = {},
				clangd = {},
				tsserver = {},
				pylsp = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
							telemetry = { enable = false },
						}
					},
				},
			},
		},

		---@diagnostic disable-next-line: unused-local
		config = function(_plugin, opts)
			-- Diagnostic configuration
			vim.diagnostic.config(opts.diagnostic)

			-- Language servers configurations
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local mappings = require("ut.plugins.list.lsp.mappings")
			local colors = require("ut.plugins.list.lsp.colors")
			local function on_attach(...)
				mappings.on_attach(...)
				colors.on_attach(...)
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local ensure_installed = {}
			for server in pairs(opts.servers) do
				table.insert(ensure_installed, server)
			end

			mason_lspconfig.setup({ ensure_installed = ensure_installed })
			mason_lspconfig.setup_handlers({
				function(server)
					local server_opts = opts.servers[server]
					server_opts.on_attach = on_attach
					server_opts.capabilities = capabilities

					lspconfig[server].setup(server_opts)
				end
			})
		end
	},
}
