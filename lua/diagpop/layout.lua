local utils = require('diagpop.utils')
local diag = require('diagpop.diagnostics')

local function layout(opts)
  local lines = {}
  local max_width = 0

  local buffername = vim.api.nvim_buf_get_name(opts.current_buffer)
  local filename = utils.get_filename(buffername)

  if not utils.isempty(filename) then
    table.insert(lines, ' ' .. filename .. ' ')
  else
    return {}
  end

  for _, diagnostic in ipairs(opts.diagnostics) do
    local message = string.format(
      '%s - %s %s',
      diagnostic.lnum + 1,
      diag[diagnostic.severity].icon,
      diagnostic.message
    )
    local limit = 45
    if #message > limit then message = message:sub(1, limit) end
    table.insert(lines, '  ' .. message:gsub('\n', ' ') .. '  ')
    max_width = math.max(max_width, #message + 4)
  end

  vim.api.nvim_buf_set_lines(opts.bufnr, 0, -1, true, lines)
  vim.api.nvim_buf_add_highlight(opts.bufnr, 0, 'FloatTitle', 0, 0, -1)
  for i, diagnostic in ipairs(opts.diagnostics) do
    vim.api.nvim_buf_add_highlight(
      opts.bufnr,
      0,
      diag[diagnostic.severity].hl,
      i,
      0,
      -1
    )
  end

  local screen_width = vim.o.columns
  local float_height = #lines
  local row = math.floor(vim.o.lines * 0.05)
  local col = screen_width - max_width - 2

  return {
    relative = 'editor',
    row = row,
    col = col,
    width = max_width,
    height = float_height,
    focusable = false,
    style = 'minimal',
    border = opts.border,
    noautocmd = true,
  }
end

return layout
