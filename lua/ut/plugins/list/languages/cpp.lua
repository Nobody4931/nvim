---@type LazySpec[]
return {
  -- Add c/cpp grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'c', 'cpp' })
      end
    end,
  },

  -- Add c/cpp language server to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        clangd = {},
      },
    },
  },

  -- Add c/cpp linters to nvim-lint
  {
    'mfussenegger/nvim-lint',

    opts = {
      linters_by_ft = {
        c = { 'cpplint' },
        cpp = { 'cpplint' },
      },
    },
  },

  -- Add c/cpp formatters to conform
  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
      formatter_install_names = {
        clang_format = 'clang-format',
      },
    },
  },
}
