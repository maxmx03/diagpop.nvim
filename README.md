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
    -- default config
    limit = 10,
    hl_group = 'NormalFloat',
    border = 'rounded',
    relative = 'editor', -- editor | cursor
    dependencies = {
       'nvim-tree/nvim-web-devicons'
    }
  },
}
```
