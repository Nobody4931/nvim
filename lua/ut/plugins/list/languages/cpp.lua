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

  -- Add c/cpp language servers to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        clangd = {},
      },
    },
  },
}
