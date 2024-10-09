# Diagpop

DiagFloat is a Neovim plugin that enhances your coding experience by
displaying diagnostic messages in customizable floating windows

![2024-08-24 22-30-10 (1)](https://github.com/user-attachments/assets/9f95d768-ce90-48c4-b28a-c9a070a49105)

## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
  'maxmx03/diagpop.nvim',
  opts = {
    limit = 5,
    hl_group = 'FloatBorder',
    border = 'single', -- single, double, rounded, shadow, none
    relative = 'editor', -- editor, cursor
    -- filter
    severity = nil, -- vim.diagnostic.severity.ERROR | WARN | INFO | HINT
  },
  dependencies = {'nvim-tree/nvim-web-devicons'}
}
```

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'maxmx03/diagpop.nvim'
Plug 'nvim-tree/nvim-web-devicons'
```

```lua
local diag = require 'diagpop'
diag.setup {
    limit = 5,
    hl_group = 'FloatBorder',
    border = 'single', -- single, double, rounded, shadow, none
    relative = 'editor', -- editor, cursor
    -- filter
    severity = nil, -- vim.diagnostic.severity.ERROR | WARN | INFO | HINT
}
```
