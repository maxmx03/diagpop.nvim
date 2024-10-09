local layout = require('diagpop.layout')

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

function M.open_floats(current_buffer, diagnostics, opts)
  local floats = {}
  local bufnr = vim.api.nvim_create_buf(false, true)
  if not bufnr or bufnr < 1 then return floats end
  local config = layout({
    current_buffer = current_buffer,
    bufnr = bufnr,
    border = opts.border,
    diagnostics = diagnostics,
  })

  if opts.relative == 'cursor' then
    config.relative = opts.relative
    config.row = 0
  end

  local float_window = vim.api.nvim_open_win(bufnr, false, config)
  vim.api.nvim_set_option_value(
    'winhl',
    'FloatBorder:' .. opts.hl_group,
    { win = float_window }
  )
  floats[float_window] = bufnr
  vim.cmd('redraw')
  return floats
end

return M
