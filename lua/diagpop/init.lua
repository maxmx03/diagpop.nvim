local M = {
  config = {
    limit = 5,
    hl_group = 'FloatBorder',
    border = 'single',
    relative = 'editor',
    severity = nil,
  },
}

function M.setup(opts)
  local window = require('diagpop.window')
  local config = vim.tbl_deep_extend('force', M.config, opts or {})
  local floats = {}

  vim.diagnostic.handlers['diag/notifier'] = {
    show = function(_, bufnr, diagnostics)
      if type(config.severity) == 'number' then
        diagnostics = vim.tbl_filter(function(diagnostic)
          return diagnostic.severity == config.severity
        end, diagnostics)
      end
      if #diagnostics > config.limit then
        diagnostics = vim.list_slice(diagnostics, 1, config.limit)
      end
      if not vim.tbl_isempty(diagnostics) then
        floats = window.open_floats(bufnr, diagnostics, config)
      end
    end,
    hide = function()
      pcall(window.close_floats, floats)
    end,
  }
end

return M
