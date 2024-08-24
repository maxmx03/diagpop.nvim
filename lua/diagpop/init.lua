local M = {
  config = {
    limit = 10,
    hl_group = 'NormalFloat',
    border = 'rounded',
  },
}

function M.setup(config)
  local window = require('diagpop.window')
  config = vim.tbl_deep_extend('force', M.config, config or {})
  local floats = {}

  vim.diagnostic.handlers['diag/notifier'] = {
    show = function(_, bufnr, diagnostics)
      if #diagnostics > config.limit then
        diagnostics = vim.list_slice(diagnostics, 1, config.limit)
      end
      local opts = {
        hl_group = config.hl_group,
        border = config.border,
      }
      floats = window.open_floats(bufnr, diagnostics, opts)
    end,
    hide = function()
      pcall(window.close_floats, floats)
    end,
  }
end

return M
