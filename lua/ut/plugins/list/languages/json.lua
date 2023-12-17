---@type LazySpec[]
return {
  -- Add json grammars to treesitter
  {
    'nvim-treesitter/nvim-treesitter',

    opts = function(plugin)
      if type(plugin.opts.ensure_installed) == 'table' then
        vim.list_extend(plugin.opts.ensure_installed, { 'json', 'json5', 'jsonc' })
      end
    end,
  },

  -- Add json language server to lspconfig
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        jsonls = {},
      },
    },
  },
}
