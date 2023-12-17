---@type LazySpec[]
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin.nvim',

    ---@type CatppuccinOptions
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      term_colors = true,

      dim_inactive = {
        enabled = false,
      },

      no_italic = true,
      no_bold = false,
      no_underline = false,

      custom_highlights = function(colors)
        return {
          -- Fix NeoTree's inactive statusline being black
          NeoTreeStatusLineNC = { bg = colors.none },

          -- Make lazy.nvim and mason.nvim floating menus opaque
          LazyNormal = { bg = colors.mantle },
          MasonNormal = { bg = colors.mantle },

          -- Make completion menu opaque
          Pmenu = { bg = colors.base },
        }
      end,

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
        neotree = true,
        neogit = true,
        cmp = true,
        native_lsp = {
          enabled = true,
        },
        notify = true,
        semantic_tokens = true,
        treesitter = true,
        telescope = {
          enabled = true,
        },
        -- Thanks catppuccin for not properly setting typedefs...
        ---@diagnostic disable-next-line: assign-type-mismatch
        illuminate = {
          enabled = true,
          lsp = false,
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
