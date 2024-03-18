---@type LazySpec[]
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin.nvim',

    ---@type CatppuccinOptions
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      show_end_of_buffer = true,
      term_colors = true,

      dim_inactive = {
        enabled = false,
      },

      no_italic = true,
      no_bold = false,
      no_underline = false,

      custom_highlights = function(colors)
        return {
          -- Make lazy.nvim and mason.nvim floating menus opaque
          LazyNormal = { bg = colors.mantle },
          MasonNormal = { bg = colors.mantle },

          -- Make completion menu opaque
          Pmenu = { bg = colors.base },
        }
      end,

      -- NOTE: Make sure to update integrations when adding a new plugin
      integrations = {
        fidget = true,
        gitsigns = true,
        indent_blankline = {
          enabled = true,
        },
        markdown = true,
        mason = true,
        mini = {
          enabled = true,
        },
        neogit = true,
        cmp = true,
        native_lsp = {
          enabled = true,
        },
        notify = true,
        semantic_tokens = true,
        treesitter = true,
        overseer = true,
        telescope = {
          enabled = true,
        },
        -- Thanks catppuccin for not properly setting typedefs...
        ---@diagnostic disable-next-line: assign-type-mismatch
        illuminate = {
          enabled = true,
          lsp = true,
        },
      },
    },

    init = function()
      vim.opt.background = 'dark'
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('catppuccin')
    end,

    config = function(_, opts)
      require('catppuccin').setup(opts)
    end,
  },
}
