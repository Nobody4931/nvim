---@type LazySpec[]
return {
  -- Dired-like file explorer that allows the file system to be edited like a regular buffer
  {
    'stevearc/oil.nvim',

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    cmd = 'Oil',
    keys = {
      {
        '<leader>eo',
        function()
          require('oil').open()
        end,
      },

      {
        '<leader>eO',
        function()
          require('oil').open(vim.loop.cwd())
        end,
      },

      {
        '<leader>ec',
        function()
          local oil = require('oil')
          oil.discard_all_changes()
          oil.close()
        end,
      },

      {
        '<leader>eC',
        function()
          require('oil').close()
        end,
      },

      {
        '<leader>ed',
        function()
          require('oil').discard_all_changes()
        end,
      },
    },

    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = false,

      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },

      view_options = {
        show_hidden = true,
      },

      use_default_keymaps = false,
      keymaps = {
        ['g?'] = 'actions.show_help',

        ['<CR>'] = 'actions.select',
        ['<C-s>'] = 'actions.select_vsplit',
        ['<C-h>'] = 'actions.select_split',
        ['<C-p>'] = 'actions.preview',
        ['<C-l>'] = 'actions.refresh',

        ['-'] = 'actions.parent',
        ['`'] = 'actions.cd',
        ['_'] = 'actions.open_cwd',

        ['gs'] = 'actions.change_sort',
        ['g.'] = 'actions.toggle_hidden',

        ['gx'] = 'actions.open_external',
        ['gy'] = 'actions.copy_entry_path',
      },
    },

    config = function(_, opts)
      require('oil').setup(opts)
    end,
  },
}
