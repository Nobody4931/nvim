---@type LazyPluginSpec[]
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

  -- Add css language servers to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        cssls = {},
      },
    },
  },
}
