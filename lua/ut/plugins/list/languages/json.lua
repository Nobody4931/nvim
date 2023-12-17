return {
  -- Add json grammars to treesitter
  {
    "nvim-treesitter/nvim-treesitter",

    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "json", "json5", "jsonc" })
      end
    end,
  },

  -- Add json language server to lspconfig
  {
    "neovim/nvim-lspconfig",

    opts = {
      servers = {
        jsonls = {},
      },
    },
  },
}
