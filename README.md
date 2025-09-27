# telescope-copy-path.nvim

A Telescope extension for copying file paths with preview functionality.

## Features

- Copy various path formats of the current file
- Multiple copy options:
  - Relative path
  - Absolute path
  - Filename only
  - Directory path

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
local telescope = require("telescope")

telescope.setup {
  ...
}

telescope.load_extension("copy_path")
```

## Usage

```lua
-- Open the copy path picker
:lua require('telescope').extensions.copy_path.copy_path()
```

### Key Mappings

- `<CR>` (Enter): Copy selected path to clipboard

