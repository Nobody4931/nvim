---@type LazySpec[]
return {
  {
    'stevearc/overseer.nvim',

    cmd = { 'OverseerToggle', 'OverseerOpen', 'OverseerClose', 'OverseerRun', 'OverseerRunCmd' },
    keys = {
      {
        '<leader>te',
        function()
          require('overseer').toggle({ enter = false })
        end,
      },

      {
        '<leader>tf',
        function()
          require('overseer').open({ enter = true })
        end,
      },

      {
        '<leader>tr',
        function()
          require('overseer').run_template({ prompt = 'always' })
        end,
      },

      {
        '<leader>tR',
        function()
          require('overseer').run_template({ prompt = 'missing', name = 'shell' })
        end,
      },
    },

    opts = {
      task_list = {
        direction = 'bottom',
        default_detail = 1,
      },

      task_launcher = {
        bindings = {
          i = {
            ['<C-c>'] = false,
            ['<C-g>'] = 'Cancel',
          },
        },
      },
      task_editor = {
        bindings = {
          i = {
            ['<C-c>'] = false,
            ['<C-g>'] = 'Cancel',
          },
        },
      },

      form = { win_opts = { winblend = 0 } },
      confirm = { win_opts = { winblend = 0 } },
      task_win = { win_opts = { winblend = 0 } },
    },

    config = function(_, opts)
      require('overseer').setup(opts)
    end,
  },
}
