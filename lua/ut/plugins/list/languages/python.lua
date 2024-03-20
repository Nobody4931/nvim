---@type LazyPluginSpec[]
return {
  -- Add python grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'python' })
      end
    end,
  },

  -- Add python language servers to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        pyright = {},
      },
    },
  },
}
