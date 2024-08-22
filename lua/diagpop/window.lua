local M = {}

function M.close_floats(floats)
  for window, bufnr in pairs(floats) do
    if vim.api.nvim_win_is_valid(window) then
      vim.api.nvim_win_close(window, true)
    end
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

function M.open_floats(diagnostics, opts)
  local floats = {}
  local bufnr = vim.api.nvim_create_buf(false, true)
  local icons = require('diagpop.icons')
  local severities = {
    icons = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warning,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Information,
    },
    highligts = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
    },
  }

  if not bufnr or bufnr < 1 then return floats end

  local lines = {}
  local max_width = 0

  for _, diagnostic in ipairs(diagnostics) do
    local message = string.format(
      '%s - %s %s',
      diagnostic.lnum,
      severities.icons[diagnostic.severity],
      diagnostic.message
    )
    local limit = 45
    if #message > limit then message = message:sub(1, limit) end
    table.insert(lines, '  ' .. message .. '  ')
    max_width = math.max(max_width, #message + 4)
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)

  for i, diagnostic in ipairs(diagnostics) do
    vim.api.nvim_buf_add_highlight(
      bufnr,
      0,
      severities.highligts[diagnostic.severity],
      i - 1,
      0,
      -1
    )
  end

  local screen_width = vim.o.columns
  local float_height = #lines
  local row = math.floor(vim.o.lines * 0.05)
  local col = screen_width - max_width - 2
  local float_window = vim.api.nvim_open_win(bufnr, false, {
    relative = 'editor',
    row = row,
    col = col,
    width = max_width,
    height = float_height,
    focusable = false,
    style = 'minimal',
    border = opts.border,
    noautocmd = true,
  })
  vim.api.nvim_set_option_value(
    'winhl',
    'Normal:' .. opts.hl_group,
    { win = float_window }
  )
  vim.api.nvim_set_option_value('diff', false, { win = float_window })
  floats[float_window] = bufnr
  vim.cmd('redraw')
  return floats
end

return M
