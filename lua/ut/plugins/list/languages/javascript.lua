---@type LazySpec[]
return {
  -- Add javascript/typescript grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'javascript', 'jsdoc', 'typescript', 'tsx' })
      end
    end,
  },

  -- Add javascript/typescript language server to lspconfig
  -- Add javascript/typescript linter to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        tsserver = {},
        eslint = {},
      },
    },
  },

  -- Add javascript/typescript formatters to conform
  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
      },
    },
  },
}
