-- Shows function signatures while typing
---@type LazyPluginSpec
return {
  'ray-x/lsp_signature.nvim',

  -- TODO: Figure out why there's no separating line between the
  -- function signature and the documentation
  opts = {
    handler_opts = {
      border = 'none',
    },

    doc_lines = 100,
    max_height = 25,
    max_width = 120,

    close_timeout = 500,

    hint_enable = false,
  },

  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}
