---@type LazyPluginSpec[]
return {
  -- Add html grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'html' })
      end
    end,
  },

  -- Add html language servers to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        html = {},
      },
    },
  },
}
