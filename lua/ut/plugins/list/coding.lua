---@type LazyPluginSpec[]
return {
  -- Smart commenting plugin
  {
    'numToStr/Comment.nvim',

    dependencies = {
      -- Treesitter integration for calculating the commentstring
      {
        'JoosepAlviste/nvim-ts-context-commentstring',

        opts = {
          enable_autocmd = false,
        },

        init = function()
          vim.g.skip_ts_context_commentstring_module = true -- skips backwards compatibility routines to speed up loading
        end,

        config = function(_, opts)
          require('ts_context_commentstring').setup(opts)
        end,
      },
    },

    ---@diagnostic disable-next-line: assign-type-mismatch
    keys = function(plugin)
      local opts = plugin.opts
      return {
        { opts.toggler.line },
        { opts.toggler.block },
        { opts.opleader.line, mode = { 'n', 'x' } },
        { opts.opleader.block, mode = { 'n', 'x' } },
      }
    end,

    opts = {
      padding = true,
      sticky = true,

      toggler = {
        line = '<leader>cll',
        block = '<leader>cbb',
      },

      opleader = {
        line = '<leader>cl',
        block = '<leader>cb',
      },

      mappings = {
        basic = true,
        extra = false,
      },
    },

    config = function(_, opts)
      local ts_context_commentstring = require('ts_context_commentstring.integrations.comment_nvim')

      opts.pre_hook = ts_context_commentstring.create_pre_hook()

      require('Comment').setup(opts)
    end,
  },

  {
    'echasnovski/mini.surround',

    ---@diagnostic disable-next-line: assign-type-mismatch
    keys = function(plugin)
      local opts = plugin.opts
      return {
        { opts.mappings.add, mode = { 'n', 'x' } },
        { opts.mappings.replace },
        { opts.mappings.delete },
        { opts.mappings.find },
        { opts.mappings.find_left },
      }
    end,

    opts = {
      mappings = {
        add = '<leader>csa',
        replace = '<leader>csr',
        delete = '<leader>csd',
        find = '<leader>csn',
        find_left = '<leader>csp',
        highlight = '',

        update_n_lines = '',

        suffix_last = '',
        suffix_next = '',
      },

      search_method = 'cover',
      n_lines = 50,
    },

    config = function(_, opts)
      require('mini.surround').setup(opts)
    end,
  },

  {
    'echasnovski/mini.move',

    ---@diagnostic disable-next-line: assign-type-mismatch
    keys = function(plugin)
      local opts = plugin.opts
      return {
        { opts.mappings.left, mode = 'x' },
        { opts.mappings.right, mode = 'x' },
        { opts.mappings.down, mode = 'x' },
        { opts.mappings.up, mode = 'x' },
      }
    end,

    opts = {
      mappings = {
        left = '<C-h>',
        right = '<C-l>',
        down = '<C-j>',
        up = '<C-k>',

        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
    },

    config = function(_, opts)
      require('mini.move').setup(opts)
    end,
  },

  {
    'echasnovski/mini.align',

    ---@diagnostic disable-next-line: assign-type-mismatch
    keys = function(plugin)
      local opts = plugin.opts
      return {
        { opts.mappings.start, mode = { 'n', 'x' } },
        { opts.mappings.start_with_preview, mode = { 'n', 'x' } },
      }
    end,

    opts = {
      mappings = {
        start = '<leader>ca',
        start_with_preview = '<leader>cA',
      },
    },

    config = function(_, opts)
      require('mini.align').setup(opts)
    end,
  },
}
