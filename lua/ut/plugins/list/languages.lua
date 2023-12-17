---@type LazySpec[]
return {
  {
    import = 'ut.plugins.list.languages',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-lint',
      'stevearc/conform.nvim',
    },
  },
}
