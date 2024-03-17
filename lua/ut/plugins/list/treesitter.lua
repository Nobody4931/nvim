---@type LazySpec[]
return {
  -- Treesitter abstraction layer and configuration tool
  {
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',

    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },

    event = { 'BufReadPost', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall' },

    opts = {
      ensure_installed = {
        'comment',
        'diff',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'lua',
        'luap',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'vim',
        'vimdoc',
      },
      ignore_install = {},
      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {
          init_selection = '<C-n>',
          node_incremental = '<C-n>',
          scope_incremental = false,
          node_decremental = '<C-p>',
        },
      },

      indent = {
        enable = true,
        disable = {},
      },

      textobjects = {
        select = {
          enable = true,
          disable = {},
          lookahead = true,
        },

        swap = {
          enable = true,
          disable = {},
          swap_next = {
            ['<leader>cxn'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>cxp'] = '@parameter.inner',
          },
        },

        move = {
          enable = true,
          disable = {},
          set_jumps = true,
        },

        lsp_interop = {
          enable = false,
        },
      },
    },

    config = function(_, opts)
      -- Folding module
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false

      -- Textobjects keybinds
      local textobject_keys = {
        -- NOTE: Please do not bind any keys to 'i' or 'a' - This will be harder to type
        -- when selecting textobjects and also might break the move module
        ['s'] = { '@assignment.inner', '@assignment.outer' },
        ['T'] = { '@attribute.inner', '@attribute.outer' },
        ['b'] = { '@block.inner', '@block.outer' },
        ['x'] = { '@call.inner', '@call.outer' },
        ['c'] = { '@class.inner', '@class.outer' },
        ['m'] = { '@comment.inner', '@comment.outer' },
        ['n'] = { '@conditional.inner', '@conditional.outer' },
        ['f'] = { '@function.inner', '@function.outer' },
        ['l'] = { '@loop.inner', '@loop.outer' },
        ['N'] = { '@number.inner', '@number.inner' },
        ['e'] = { '@parameter.inner', '@parameter.outer' },
        ['R'] = { '@regex.inner', '@regex.outer' },
        ['r'] = { '@return.inner', '@return.outer' },
        ['S'] = { '@statement.outer', '@statement.outer' },
      }

      -- Textobjects select module
      local mod_select = opts.textobjects.select
      mod_select.keymaps = {}

      for key, queries in pairs(textobject_keys) do
        mod_select.keymaps['i' .. key] = queries[1]
        mod_select.keymaps['a' .. key] = queries[2]
      end

      -- Textobjects move module
      local mod_move = opts.textobjects.move
      mod_move.goto_next_start = {}
      mod_move.goto_next_end = {}
      mod_move.goto_previous_start = {}
      mod_move.goto_previous_end = {}

      for key, queries in pairs(textobject_keys) do
        mod_move.goto_next_start[']' .. key] = queries[2]
        mod_move.goto_next_end['g]' .. key] = queries[2]
        mod_move.goto_previous_start['[' .. key] = queries[2]
        mod_move.goto_previous_end['g[' .. key] = queries[2]

        mod_move.goto_next_start[']i' .. key] = queries[1]
        mod_move.goto_next_end['g]i' .. key] = queries[1]
        mod_move.goto_previous_start['[i' .. key] = queries[1]
        mod_move.goto_previous_end['g[i' .. key] = queries[1]
      end

      -- Setup nvim-treesitter
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
