---@type LazyPluginSpec[]
return {
  -- Better vim.notify()
  {
    'rcarriga/nvim-notify',

    lazy = false,
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
      },
    },

    opts = {
      timeout = 3000,
      render = 'compact',
      stages = 'fade',
      background_colour = '#000000', -- Just to shut up the transparent background color warning
      max_height = function()
        return math.floor(vim.o.lines * 0.5)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
      on_open = function(window)
        vim.api.nvim_win_set_config(window, { zindex = 150 }) -- Ensure topmost
      end,
    },

    config = function(_, opts)
      local notify = require('notify')
      notify.setup(opts)

      -- Replace the default vim.notify() function
      vim.notify = notify
    end,
  },

  -- Better vim.ui.input() and vim.ui.select()
  {
    'stevearc/dressing.nvim',

    dependencies = {
      'nvim-telescope/telescope.nvim',
    },

    init = function()
      -- Create custom lazy loaders to load the plugin on function call

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
    end,

    config = function()
      require('dressing').setup()
    end,
  },

  -- Customizable statusline
  {
    'nvim-lualine/lualine.nvim',

    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'catppuccin/nvim', name = 'catppuccin.nvim' },
    },

    event = 'VeryLazy',

    opts = function()
      local colors = require('catppuccin.palettes').get_palette(require('catppuccin').options.flavour)

      local active_fg = colors.text
      local inactive_fg = colors.overlay0

      local opts = {
        options = {
          -- Disable separators
          component_separators = '',
          section_separators = '',

          theme = {
            normal = {
              c = {
                fg = active_fg,
                bg = colors.surface0,
              },
            },

            inactive = {
              c = {
                fg = inactive_fg,
                bg = colors.surface0,
              },
            },
          },

          globalstatus = false,
        },

        sections = {
          -- Remove defaults from non-center sections
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- Empty center sections to fill manually later
          lualine_c = {},
          lualine_x = {},
        },

        inactive_sections = {
          -- Remove defaults from non-center sections
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- Empty center sections to fill manually later
          lualine_c = {},
          lualine_x = {},
        },
      }

      local add_component = function(side, component_factory)
        local side_tbl = (side == 'l') and 'lualine_c' or 'lualine_x'
        table.insert(opts.sections[side_tbl], component_factory(true))
        table.insert(opts.inactive_sections[side_tbl], component_factory(false))
      end

      -- Mode component
      add_component('l', function(active)
        return {
          function()
            return '▊'
          end,

          color = function()
            local mode_colors = {
              -- Normal mode
              ['n'] = colors.blue,
              ['no'] = colors.blue,

              -- Operator pending modes
              ['r'] = colors.blue,
              ['rm'] = colors.blue,
              ['r?'] = colors.blue,

              -- Insert mode
              ['i'] = colors.green,
              ['ic'] = colors.green,

              -- Terminal mode
              ['t'] = colors.green,

              -- Visual mode
              ['v'] = colors.mauve,
              ['V'] = colors.mauve,
              [''] = colors.mauve,

              -- Command mode
              ['c'] = colors.teal,
              ['cv'] = colors.teal,

              -- Replace mode
              ['R'] = colors.red,
              ['Rv'] = colors.red,

              -- Select mode
              ['s'] = colors.peach,
              ['S'] = colors.peach,
              [''] = colors.peach,
            }

            return { fg = active and mode_colors[vim.fn.mode()] or inactive_fg }
          end,

          padding = {
            right = 1,
          },
        }
      end)

      -- Icon component
      add_component('l', function()
        return {
          function()
            return '宇'
          end,

          padding = {
            right = 1,
          },

          color = { gui = 'bold' },
        }
      end)

      -- File size component
      add_component('l', function()
        return {
          'filesize',

          padding = {
            right = 2,
          },

          draw_empty = true,
        }
      end)

      -- File type component
      add_component('l', function(active)
        return {
          'filetype',
          colored = active,
          icon_only = true,
          padding = {
            right = 0,
          },
        }
      end)

      -- File name component
      add_component('l', function(active)
        return {
          'filename',
          file_status = false,
          newfile_status = false,
          path = 1,

          symbols = {
            unnamed = '*unnamed file*',
          },

          color = function()
            return { fg = active and (vim.bo.modified and colors.peach or colors.lavender) or inactive_fg, gui = 'bold' }
          end,

          padding = {
            right = 2,
          },
        }
      end)

      -- Cursor location component
      add_component('l', function()
        return {
          'location',
          padding = {
            right = 1,
          },
        }
      end)

      -- Cursor progress component
      add_component('l', function()
        return {
          'progress',
          padding = {
            right = 1,
          },
        }
      end)

      -- Diagnostics component
      add_component('l', function(active)
        return {
          'diagnostics',
          colored = active,
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          padding = {
            left = 1,
          },
        }
      end)

      -- File encoding component
      add_component('r', function(active)
        return {
          'o:encoding',
          fmt = string.upper,
          color = { fg = active and colors.flamingo or inactive_fg },
          padding = {
            right = 1,
          },
        }
      end)

      -- File format component
      add_component('r', function(active)
        return {
          'o:fileformat',
          fmt = string.upper,
          color = { fg = active and colors.flamingo or inactive_fg },
          padding = {
            right = 1,
          },
        }
      end)

      -- Git branch component
      add_component('r', function(active)
        return {
          'branch',
          icon = '',
          color = { fg = active and colors.pink or inactive_fg },
          cond = function()
            return true -- bc for some reason it doesnt show when inactive
          end,
          padding = {
            right = 1,
          },
        }
      end)

      -- Git diff component
      add_component('r', function(active)
        return {
          'diff',
          colored = active,
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          padding = {
            right = 1,
          },
        }
      end)

      return opts
    end,

    config = function(_, opts)
      vim.opt.laststatus = 2 -- always show statusline
      vim.opt.showtabline = 0 -- never show tabline
      vim.opt.showmode = false -- don't show mode at the bottom
      vim.opt.showcmd = true -- show pending command at the bottom
      vim.opt.cmdheight = 1

      require('lualine').setup(opts)
    end,
  },

  -- Adds indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',

    event = 'BufReadPost',

    opts = {
      scope = {
        enabled = false,
      },
    },

    config = function(_, opts)
      require('ibl').setup(opts)
    end,
  },

  -- Highlights other occurrences the word under the cursor
  {
    'RRethy/vim-illuminate',

    event = 'BufReadPost',
    keys = {
      {
        '[[',
        function()
          require('illuminate').goto_prev_reference()
        end,
      },
      {
        ']]',
        function()
          require('illuminate').goto_next_reference()
        end,
      },
    },

    opts = {
      delay = 100,
      large_file_cutoff = 1000,
      providers = { 'lsp', 'treesitter' },
    },

    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
}
