---@type LazySpec[]
return {
  -- Git interface inspired by Magit
  {
    'NeogitOrg/neogit',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },

    cmd = 'Neogit',
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open()
        end,
      },

      {
        '<leader>gb',
        function()
          require('neogit').open({ 'branch' })
        end,
      },

      {
        '<leader>gc',
        function()
          require('neogit').open({ 'commit' })
        end,
      },

      {
        '<leader>gl',
        function()
          require('neogit').open({ 'log' })
        end,
      },

      {
        '<leader>gd',
        function()
          require('neogit').open({ 'diff' })
        end,
      },

      {
        '<leader>gf',
        function()
          require('neogit').open({ 'fetch' })
        end,
      },

      {
        '<leader>gp',
        function()
          require('neogit').open({ 'pull' })
        end,
      },

      {
        '<leader>gP',
        function()
          require('neogit').open({ 'push' })
        end,
      },
    },

    opts = {
      graph_style = 'unicode',

      disable_hint = true,
      disable_context_highlighting = false,
      disable_signs = false,
      disable_commit_confirmation = false,
      disable_insert_on_commit = true,
      disable_line_numbers = true,

      remember_settings = false,
      use_per_project_settings = true,

      kind = 'split',

      popup = { kind = 'split' },
      preview_buffer = { kind = 'split' },
      commit_select_view = { kind = 'split' },
      commit_view = { kind = 'vsplit' },

      commit_editor = { kind = 'auto' },
      rebase_editor = { kind = 'auto' },
      merge_editor = { kind = 'auto' },
      tag_editor = { kind = 'auto' },

      log_view = { kind = 'replace' },
      reflog_view = { kind = 'replace' },

      telescope_sorter = function()
        return require('telescope').extensions.fzf.native_fzf_sorter()
      end,
    },

    config = function(_, opts)
      require('neogit').setup(opts)
    end,
  },

  -- Shows changes since the last commit in the signcolumn
  {
    'lewis6991/gitsigns.nvim',

    event = 'BufReadPost',
    keys = {
      {
        ']h',
        function()
          require('gitsigns').next_hunk()
        end,
      },
      {
        '[h',
        function()
          require('gitsigns').prev_hunk()
        end,
      },

      { 'ih', ':<C-u>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },

      { '<leader>ghs', ':Gitsigns stage_hunk<CR>', mode = { 'n', 'v' } },
      { '<leader>ghr', ':Gitsigns reset_hunk<CR>', mode = { 'n', 'v' } },
      {
        '<leader>ghS',
        function()
          require('gitsigns').stage_buffer()
        end,
      },
      {
        '<leader>ghR',
        function()
          require('gitsigns').reset_buffer()
        end,
      },

      {
        '<leader>ghu',
        function()
          require('gitsigns').undo_stage_hunk()
        end,
      },

      {
        '<leader>ghd',
        function()
          require('gitsigns').diffthis()
        end,
      },
      {
        '<leader>ghD',
        function()
          require('gitsigns').diffthis('~')
        end,
      },
      {
        '<leader>gtd',
        function()
          require('gitsigns').toggle_deleted()
        end,
      },
    },

    opts = {
      signcolumn = true,
      numhl = false,
      linehl = false,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1500,
      },
    },

    config = function(_, opts)
      vim.opt.signcolumn = 'yes'

      require('gitsigns').setup(opts)
    end,
  },
}
