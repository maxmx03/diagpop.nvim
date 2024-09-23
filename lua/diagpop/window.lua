local M = {}

local function isempty(s)
  return s == nil or s == ''
end

local function get_filename(full_path)
  local filename = vim.fn.fnamemodify(full_path, ':t')
  local extension = vim.fn.expand('%:e')

  if not isempty(filename) then
    local devicons = require('nvim-web-devicons')
    local file_icon = devicons.get_icon(filename, extension, { default = true })
    local navic_text = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
    vim.api.nvim_set_hl(0, 'Winbar', { fg = navic_text.fg })
    return string.format('%s %s', filename, file_icon)
  end
end

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
  local icons = require('diagpop.icons')
  local severities = {
    icons = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warning,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Information,
    },
    highligts = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticVirtualTextError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticVirtualTextWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticVirtualTextHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticVirtualTextInfo',
    },
  }

  if not bufnr or bufnr < 1 then return floats end

  local lines = {}
  local max_width = 0

  local buffername = vim.api.nvim_buf_get_name(current_buffer)
  local filename = get_filename(buffername)

  if not isempty(filename) then
    table.insert(lines, ' ' .. filename .. ' ')
  else
    return {}
  end

  for _, diagnostic in ipairs(diagnostics) do
    local message = string.format(
      '%s - %s %s',
      diagnostic.lnum + 1,
      severities.icons[diagnostic.severity],
      diagnostic.message
    )
    local limit = 45
    if #message > limit then message = message:sub(1, limit) end
    table.insert(lines, '  ' .. message:gsub("\n", " ") .. '  ')
    max_width = math.max(max_width, #message + 4)
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  vim.api.nvim_buf_add_highlight(bufnr, 0, 'FloatTitle', 0, 0, -1)
  for i, diagnostic in ipairs(diagnostics) do
    vim.api.nvim_buf_add_highlight(
      bufnr,
      0,
      severities.highligts[diagnostic.severity],
      i,
      0,
      -1
    )
  end

  local screen_width = vim.o.columns
  local float_height = #lines
  local row = math.floor(vim.o.lines * 0.05)
  local col = screen_width - max_width - 2
  local config = {
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
  if opts.relative == 'cursor' then
    config.relative = opts.relative
    config.row = 0
  end
  local float_window = vim.api.nvim_open_win(bufnr, false, config)
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
