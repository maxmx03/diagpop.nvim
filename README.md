# Diagpop

DiagFloat is a Neovim plugin that enhances your coding experience by
displaying diagnostic messages in customizable floating windows

![2024-08-24 09-41-43](https://github.com/user-attachments/assets/00e8d137-e7ee-4648-93c4-81b8348ce54c)


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
    dependencies = {
       'nvim-tree/nvim-web-devicons'
    }
  },
}
```
