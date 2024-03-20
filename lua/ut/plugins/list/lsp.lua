---@type LazySpec[]
return {
  -- Package manager for Neovim that can automatically install LSP servers, linters, formatters, etc.
  {
    'williamboman/mason.nvim',

    build = ':MasonUpdate',

    event = 'VeryLazy',
    cmd = 'Mason',

    opts = {
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

    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },

  -- Configuration tool for the native Neovim LSP client
  {
    'neovim/nvim-lspconfig',

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'folke/neodev.nvim',

      'hrsh7th/cmp-nvim-lsp',
      'ray-x/lsp_signature.nvim',

      'j-hui/fidget.nvim',
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
      local mason_lspconfig = require('mason-lspconfig')

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

        -- Hover mappings
        map('n', 'K', vim.lsp.buf.hover, map_opt)
        map('n', '<leader>k', vim.lsp.buf.signature_help, map_opt)

        -- Goto symbols mappings
        map('n', '<leader>lr', function()
          require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())
        end, map_opt)
        map('n', '<leader>ld', function()
          require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown())
        end, map_opt)
        map('n', '<leader>lD', vim.lsp.buf.declaration, map_opt) -- lol
        map('n', '<leader>li', function()
          require('telescope.builtin').lsp_implementations(require('telescope.themes').get_dropdown())
        end, map_opt)
        map('n', '<leader>lt', function()
          require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_dropdown())
        end, map_opt)
        map('n', '<leader>ls', function()
          require('telescope.builtin').lsp_document_symbols()
        end, map_opt)

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

        -- Code actions mappings
        map('n', '<leader>ln', vim.lsp.buf.rename, map_opt)
        map('n', '<leader>lc', vim.lsp.buf.code_action, map_opt)

        -- Goto diagnostics mappings
        map('n', '<leader>lg', vim.diagnostic.open_float, map_opt)
        map('n', '<leader>lG', function()
          require('telescope.builtin').diagnostics()
        end, map_opt)

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

      local ensure_installed = {}
      for server in pairs(opts.servers) do
        table.insert(ensure_installed, server)
      end

      mason_lspconfig.setup({ ensure_installed = ensure_installed })
      mason_lspconfig.setup_handlers({
        function(server_name)
          local server_opts = opts.servers[server_name]
          server_opts.root_dir = vim.loop.cwd
          server_opts.on_attach = on_attach
          server_opts.capabilities = capabilities

          lspconfig[server_name].setup(server_opts)
        end,
      })
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
      local null_ls = require('null-ls')

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

  -- Automatic Lua language server setup for Neovim's Lua API
  {
    'folke/neodev.nvim',

    opts = {
      setup_jsonls = false,
    },

    config = function(_, opts)
      require('neodev').setup(opts)
    end,
  },

  -- Shows function signatures while typing
  {
    'ray-x/lsp_signature.nvim',

    -- TODO: Figure out why there's no separating line between the
    -- function signature and the documentation
    opts = {
      handler_opts = {
        border = 'none',
      },

      doc_lines = 100,
      max_height = 25,
      max_width = 120,

      close_timeout = 500,

      hint_enable = false,
    },

    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },

  -- Shows loading progress for LSP servers
  {
    'j-hui/fidget.nvim',

    opts = {
      progress = {
        display = {
          done_icon = '',
        },
      },

      notification = {
        window = {
          winblend = 0,
        },
      },
    },

    config = function(_, opts)
      require('fidget').setup(opts)
    end,
  },
}
