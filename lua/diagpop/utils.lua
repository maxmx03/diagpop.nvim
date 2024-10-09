local M = {}

M.isempty = function(s)
  return s == nil or s == ''
end

M.get_filename = function(fname)
  local filename = vim.fn.fnamemodify(fname, ':t')
  local extension = vim.fn.expand('%:e')

  if not M.isempty(filename) then
    local devicons = require('nvim-web-devicons')
    local file_icon = devicons.get_icon(filename, extension, { default = true })
    local navic_text = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
    vim.api.nvim_set_hl(0, 'Winbar', { fg = navic_text.fg })
    return string.format('%s %s', filename, file_icon)
  end
end

return M
