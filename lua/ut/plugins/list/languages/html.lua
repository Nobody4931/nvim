return {
  -- Add html grammars to treesitter
  {
    "nvim-treesitter/nvim-treesitter",

    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html" })
      end
    end,
  },

  -- Add html language server to lspconfig
  {
    "neovim/nvim-lspconfig",

    opts = {
      servers = {
        html = {},
      },
    },
  },

  -- Add html formatters to conform
  {
    "stevearc/conform.nvim",

    opts = {
      formatters_by_ft = {
        html = { "prettierd" },
      },
    },
  },
}
