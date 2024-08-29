local M = {
  opts = {
    limit = 10,
    hl_group = 'NormalFloat',
    border = 'rounded',
    relative = 'editor',
  },
}

function M.setup(config)
  local window = require('diagpop.window')
  local opts = vim.tbl_deep_extend('force', M.opts, config or {})
  local floats = {}

  vim.diagnostic.handlers['diag/notifier'] = {
    show = function(_, bufnr, diagnostics)
      if #diagnostics > opts.limit then
        diagnostics = vim.list_slice(diagnostics, 1, config.limit)
      end
      floats = window.open_floats(bufnr, diagnostics, opts)
    end,
    hide = function()
      pcall(window.close_floats, floats)
    end,
  }
end

return M
