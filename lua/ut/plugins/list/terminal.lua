local state = {}

return {
  {
    'numToStr/FTerm.nvim',

    ---@diagnostic disable-next-line: unused-local
    keys = function(_plugin)
      local function terminal_toggle(n)
        state.last = n
        state.terms[n].shell:toggle()
      end

      local function terminal_execute(n)
        vim.ui.input({
          prompt = 'Command: ',
          default = state.terms[n].cmd,
        }, function(input)
          if input then
            state.last = n
            state.terms[n].cmd = input
            state.terms[n].shell:run(input)
          end
        end)
      end

      local function other_toggle(n)
        state.others[n]:toggle()
      end

      local keys = {
        {
          '<leader>tg',
          function()
            other_toggle('g')
          end,
        },
        {
          '<leader>te',
          function()
            terminal_toggle(state.last)
          end,
        },
        {
          '<leader>tce',
          function()
            terminal_execute(state.last)
          end,
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          '<leader>t' .. i,
          function()
            terminal_toggle(i)
          end,
        })
        table.insert(keys, {
          '<leader>tc' .. i,
          function()
            terminal_execute(i)
          end,
        })
      end

      return keys
    end,

    opts = {
      cmd = vim.opt.shell:get(),
      auto_close = false,

      hl = 'FTermNormal',
      blend = 0,

      border = 'rounded',
      dimensions = {
        height = 0.7,
        width = 0.7,
        x = 0.5,
        y = 0.5,
      },
    },

    ---@diagnostic disable-next-line: unused-local
    config = function(_plugin, opts)
      local fterm = require('FTerm')

      fterm.setup(opts)

      state.terms = {}
      state.others = {}
      state.last = 1

      for i = 1, 9 do
        state.terms[i] = {}
        state.terms[i].shell = fterm:new(opts)
        state.terms[i].cmd = ''
      end

      state.others['g'] = fterm:new(vim.tbl_extend('keep', { cmd = 'lazygit', auto_close = true }, opts))
    end,
  },
}
