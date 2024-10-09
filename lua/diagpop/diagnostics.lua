return {
  [vim.diagnostic.severity.ERROR] = {
    icon = '',
    hl = 'DiagnosticVirtualTextError',
  },
  [vim.diagnostic.severity.WARN] = {
    icon = '',
    hl = 'DiagnosticVirtualTextWarn',
  },
  [vim.diagnostic.severity.HINT] = {
    icon = '󰌶',
    hl = 'DiagnosticVirtualTextHint',
  },
  [vim.diagnostic.severity.INFO] = {
    icon = '',
    hl = 'DiagnosticVirtualTextInfo',
  },
}
