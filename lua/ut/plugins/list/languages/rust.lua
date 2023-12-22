---@type LazySpec[]
return {
  -- Add rust grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'rust', 'toml' })
      end
    end,
  },

  -- Add rust language server to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
  },

  -- TODO Add rust linters (clippy) to nvim-lint (currently unsupported)

  -- Add rust formatters to conform
  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        rust = { 'rustfmt' },
      },

      ignore_install = {
        rustfmt = true, -- NOTE: rustfmt should be installed through rustup (`rustup component add rustfmt`)
      },
    },
  },
}
