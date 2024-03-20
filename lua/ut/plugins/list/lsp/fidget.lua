-- Shows loading progress for LSP servers
---@type LazyPluginSpec
return {
  'j-hui/fidget.nvim',

  opts = {
    progress = {
      display = {
        done_icon = '',
      },
    },

    notification = {
      window = {
        winblend = 0,
      },
    },
  },

  config = function(_, opts)
    require('fidget').setup(opts)
  end,
}
