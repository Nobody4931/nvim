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

  -- Add rust language servers to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
  },
}
