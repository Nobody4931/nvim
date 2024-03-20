---@type LazyPluginSpec[]
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
        '<leader>tE',
        function()
          require('overseer').open({ enter = true })
        end,
      },

      {
        '<leader>to',
        function()
          require('overseer').run_template({ prompt = 'always' })
        end,
      },

      {
        '<leader>tO',
        function()
          require('overseer').run_template({ prompt = 'missing', name = 'shell' })
        end,
      },

      {
        '<leader>ta',
        function()
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          local task = tasks[1]
          if task then
            overseer.run_action(task)
          end
        end,
      },

      {
        '<leader>tp',
        function()
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          local task = tasks[1]
          if task then
            overseer.run_action(task, 'open float')
          end
        end,
      },

      {
        '<leader>tr',
        function()
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          local task = tasks[1]
          if task then
            overseer.run_action(task, 'restart')
          end
        end,
      },

      {
        '<leader>tc',
        function()
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          local task = tasks[1]
          if task then
            overseer.run_action(task, 'edit')
          end
        end,
      },

      {
        '<leader>td',
        function()
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          local task = tasks[1]
          if task then
            overseer.run_action(task, 'dispose')
          end
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
