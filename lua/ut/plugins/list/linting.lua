---@type LazySpec[]
return {
  -- Asynchronous linter plugin that works alongside the native LSP client
  {
    'mfussenegger/nvim-lint',

    dependencies = {
      'williamboman/mason.nvim',
    },

    event = 'BufReadPost',

    opts = {
      linters_by_ft = {},
      ignore_install = {},
    },

    config = function(_, opts)
      local lint = require('lint')
      lint.linters_by_ft = opts.linters_by_ft

      -- Automatically install missing linters
      local mason_registry = require('mason-registry')
      for _, linters in pairs(opts.linters_by_ft) do
        for _, linter in ipairs(linters) do
          if not opts.ignore_install[linter] then
            local linter_pkg = mason_registry.get_package(linter)
            if not linter_pkg:is_installed() then
              linter_pkg:install()
            end
          end
        end
      end

      -- Create autocmd to run linters
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('run_linters', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
