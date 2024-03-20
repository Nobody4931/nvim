-- Automatic Lua language server setup for Neovim's Lua API
---@type LazyPluginSpec
return {
  'folke/neodev.nvim',

  opts = {
    setup_jsonls = false,
  },

  config = function(_, opts)
    require('neodev').setup(opts)
  end,
}
