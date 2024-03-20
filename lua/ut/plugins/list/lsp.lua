local spec_neodev = require('ut.plugins.list.lsp.neodev')
local spec_fidget = require('ut.plugins.list.lsp.fidget')
local spec_lsp_signature = require('ut.plugins.list.lsp.lsp_signature')

---@type LazyPluginSpec[]
return {
  -- Package manager for Neovim that can automatically install LSP servers, linters, formatters, etc.
  {
    'williamboman/mason.nvim',

    build = ':MasonUpdate',

    event = 'VeryLazy',
    cmd = 'Mason',

    opts = {
      -- Options passed to `mason.setup()`
      mason = {
        max_concurrent_installers = math.floor(math.max(2, vim.loop.available_parallelism() / 3)),

        ui = {
          border = 'none',
          width = 0.8,
          height = 0.8,

          icons = {
            package_installed = '',
            package_pending = '',
            package_uninstalled = '',
          },
        },
      },

      -- Options passed to custom ensure_installed handler
      ensure_installed = {
        'lua-language-server',
        'stylua',
      },
    },

    config = function(_, opts)
      require('mason').setup(opts.mason)

      -- Custom ensure_installed handler
      local mason_registry = require('mason-registry')
      for _, package_name in ipairs(opts.ensure_installed) do
        local package = mason_registry.get_package(package_name)
        if not package:is_installed() then
          vim.notify(string.format("Installing '%s'...", package_name), vim.log.levels.INFO)
          local install_hndl = package:install()

          install_hndl:once('closed', function()
            vim.notify(string.format("Successfully installed '%s'", package_name), vim.log.levels.INFO)
          end)
        end
      end
    end,
  },

  -- Configuration tool for the native Neovim LSP client
  {
    'neovim/nvim-lspconfig',

    dependencies = {
      'williamboman/mason.nvim',

      'hrsh7th/cmp-nvim-lsp',

      spec_neodev,
      spec_fidget,
      spec_lsp_signature,
    },

    event = 'BufReadPost',

    opts = {
      -- Options passed to `vim.diagnostic.config()`
      diagnostic = {
        underline = true,
        virtual_text = true,
        signs = false,
        update_in_insert = false,
        severity_sort = true,
      },

      -- Options passed to `lspconfig[server].setup()`
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
      },
    },

    config = function(_, opts)
      -- Diagnostic configuration
      vim.diagnostic.config(opts.diagnostic)

      -- Language servers configurations
      local lspconfig = require('lspconfig')

      local lsp_signature = require('lsp_signature')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local function on_attach(client, bufnr)
        lsp_signature.on_attach(client, bufnr)

        -- Disable semantic token highlighting
        -- client.server_capabilities["semanticTokensProvider"] = nil

        -- Mapping configuration
        local map = vim.keymap.set
        local map_opt = { buffer = bufnr }

        -- Hover event
        map('n', 'K', vim.lsp.buf.hover, map_opt)

        -- Goto references
        map('n', '<leader>lr', function()
          require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())
        end, map_opt)

        -- Goto definition
        map('n', 'gd', function()
          require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown())
        end, map_opt)

        map('n', '<leader>ld', function()
          require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown())
        end, map_opt)

        -- Goto declaration
        map('n', '<leader>lD', vim.lsp.buf.declaration, map_opt) -- lol

        -- Goto implementations
        map('n', '<leader>li', function()
          require('telescope.builtin').lsp_implementations(require('telescope.themes').get_dropdown())
        end, map_opt)

        -- Goto type definition
        map('n', '<leader>lt', function()
          require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_dropdown())
        end, map_opt)

        -- Search document symbols
        map('n', '<leader>ls', function()
          require('telescope.builtin').lsp_document_symbols()
        end, map_opt)

        -- Search workspace symbols
        map('n', '<leader>lw', function()
          vim.ui.input({ prompt = 'Find Symbol: ' }, function(input)
            if input then
              require('telescope.builtin').lsp_workspace_symbols({ query = input })
            end
          end)
        end, map_opt)

        map('n', '<leader>lW', function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols()
        end, map_opt)

        -- Rename variable
        map('n', '<leader>ln', vim.lsp.buf.rename, map_opt)

        -- Perform code action
        map('n', '<leader>lc', vim.lsp.buf.code_action, map_opt)

        -- Show diagnostics
        map('n', '<leader>lg', vim.diagnostic.open_float, map_opt)

        map('n', '<leader>lG', function()
          require('telescope.builtin').diagnostics()
        end, map_opt)

        -- Goto diagnostics
        map('n', ']d', function()
          vim.diagnostic.goto_next()
        end, map_opt)

        map('n', '[d', function()
          vim.diagnostic.goto_prev()
        end, map_opt)

        map('n', ']D', function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, map_opt)

        map('n', '[D', function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, map_opt)
      end

      for server_name, server_opts in pairs(opts.servers) do
        server_opts.root_dir = vim.loop.cwd
        server_opts.on_attach = on_attach
        server_opts.capabilities = capabilities

        lspconfig[server_name].setup(server_opts)
      end
    end,
  },

  -- Interface for setting up LSP sources (eg. linters and formatters) through pure Lua
  {
    'nvimtools/none-ls.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
    },

    event = 'BufReadPost',

    config = function()
      local null_ls = require('null-ls') -- none-ls.nvim uses the same api as null-ls.nvim

      local format_on_save = vim.api.nvim_create_augroup('format_on_save', { clear = true })

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
        },

        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = format_on_save,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  bufnr = bufnr,
                  -- Send formatting request to null-ls only to reduce lag and incorrect formatting from alternate sources
                  filter = function(fmt_client)
                    return fmt_client.name == 'null-ls'
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
