---@type LazySpec[]
return {
  -- Highly extensible fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',

      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

      'rcarriga/nvim-notify',
    },

    cmd = 'Telescope',
    keys = {
      -- TODO: Consider using require("telescope.themes").get_ivy() - it doesn't look that
      -- bad, and also leaves the buffer somewhat visible

      {
        '<leader>sf',
        function()
          require('telescope.builtin').find_files({
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false,
          })
        end,
      },

      {
        '<leader>sF',
        function()
          require('telescope.builtin').find_files({
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          })
        end,
      },

      {
        '<leader>sv',
        function()
          require('telescope.builtin').find_files({
            prompt_title = 'Vim Files',
            cwd = vim.fn.stdpath('config'),
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          })
        end,
      },

      {
        '<leader>sg',
        function()
          vim.ui.input({ prompt = 'Grep String: ' }, function(input)
            if input then
              require('telescope.builtin').grep_string({
                search = input,
                additional_args = { '--hidden' },
              })
            end
          end)
        end,
      },

      {
        '<leader>sG',
        function()
          vim.ui.input({ prompt = 'Grep String (All Files): ' }, function(input)
            if input then
              require('telescope.builtin').grep_string({
                search = input,
                additional_args = { '--hidden', '--no-ignore' },
              })
            end
          end)
        end,
      },

      {
        '<leader>sl',
        function()
          require('telescope.builtin').live_grep({
            additional_args = { '--hidden' },
          })
        end,
      },

      {
        '<leader>sL',
        function()
          require('telescope.builtin').live_grep({
            additional_args = { '--hidden', '--no-ignore' },
          })
        end,
      },

      {
        '<leader>sh',
        function()
          require('telescope.builtin').help_tags()
        end,
      },

      {
        '<leader>sH',
        function()
          require('telescope.builtin').man_pages()
        end,
      },

      {
        '<leader>sb',
        function()
          require('telescope.builtin').buffers()
        end,
      },

      {
        '<leader>so',
        function()
          require('telescope.builtin').oldfiles()
        end,
      },

      {
        '<leader>sm',
        function()
          require('telescope.builtin').marks()
        end,
      },

      {
        '<leader>sq',
        function()
          require('telescope.builtin').quickfix()
        end,
      },

      {
        '<leader>sQ',
        function()
          require('telescope.builtin').loclist()
        end,
      },

      {
        '<leader>sk',
        function()
          require('telescope.builtin').keymaps()
        end,
      },

      {
        '<leader>sc',
        function()
          require('telescope.builtin').highlights()
        end,
      },

      {
        '<leader>sn',
        function()
          require('telescope').extensions.notify.notify()
        end,
      },
    },

    opts = function()
      local opts = {
        defaults = {
          prompt_prefix = ' > ',

          file_ignore_patterns = {
            '%.git$',
            '%.git[/\\]',
            'node_modules',
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }

      local actions = require('telescope.actions')

      local dual_mode_maps = {
        ['<CR>'] = actions.select_default,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,

        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<M-j>'] = actions.toggle_selection + actions.move_selection_next,
        ['<M-k>'] = actions.toggle_selection + actions.move_selection_previous,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
      }

      local insert_mode_maps = {
        ['<C-w>'] = { '<C-S-w>', type = 'command' }, -- fix ctrl+w not working (thanks telescope!)
      }

      local normal_mode_maps = {
        ['<Esc>'] = actions.close,
        ['<C-c>'] = actions.close,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['J'] = actions.toggle_selection + actions.move_selection_next,
        ['K'] = actions.toggle_selection + actions.move_selection_previous,
        ['m'] = actions.toggle_selection,

        ['H'] = actions.move_to_top,
        ['M'] = actions.move_to_middle,
        ['L'] = actions.move_to_bottom,
      }

      -- Mapping configuration
      opts.defaults.default_mappings = {}
      opts.defaults.default_mappings.i = vim.tbl_extend('error', dual_mode_maps, insert_mode_maps)
      opts.defaults.default_mappings.n = vim.tbl_extend('error', dual_mode_maps, normal_mode_maps)

      return opts
    end,

    config = function(_, opts)
      local telescope = require('telescope')

      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('notify')
    end,
  },
}
