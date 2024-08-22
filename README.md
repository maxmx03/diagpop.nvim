# Diagpop

DiagFloat is a Neovim plugin that enhances your coding experience by
displaying diagnostic messages in customizable floating windows

![screenshot](https://github.com/user-attachments/assets/2b99e617-8000-4cee-bd5a-b4c5d1978e77)

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
  },
}
```
