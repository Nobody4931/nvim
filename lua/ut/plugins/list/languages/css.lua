---@type LazySpec[]
return {
  -- Add css grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'css', 'scss' })
      end
    end,
  },

  -- Add css language server to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        cssls = {},
      },
    },
  },

  -- Add css formatters to conform
  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        css = { 'prettierd' },
        scss = { 'prettierd' },
      },
    },
  },
}
