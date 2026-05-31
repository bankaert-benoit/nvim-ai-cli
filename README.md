# nvim-ai-cli

A Neovim plugin that launches any AI CLI tool (e.g. `gemini`, `claude`, `aider`, `sgpt`, ...)
in a vertical split terminal buffer, fully driven by user config.

## Installation

### lazy.nvim

```lua
{
  "bankaert-benoit/nvim-ai-cli",
  config = function()
    require("nvim-ai-cli").setup({
      cmd = "gemini",
    })
  end,
}
```

### packer

```lua
use({
  "bankaert-benoit/nvim-ai-cli",
  config = function()
    require("nvim-ai-cli").setup({
      cmd = "gemini",
    })
  end,
})
```

### vim-plug

```vim
Plug 'bankaert-benoit/nvim-ai-cli'

lua << EOF
require("nvim-ai-cli").setup({
  cmd = "gemini",
})
EOF
```

## Usage

```
:AiCli      Open / close the AI terminal panel
```

The panel opens as a vertical split on the right side (configurable).
The configured CLI tool starts automatically inside the terminal buffer.

## Options

| Option  | Type               | Default   | Description                     |
|---------|--------------------|-----------|---------------------------------|
| `cmd`   | `string` or `list` | **required** | The CLI command to run        |
| `width`      | `number`           | `40`      | Width of the split (percent)    |
| `side`       | `"left"` / `"right"` | `"right"` | Which side to open the split  |
| `auto_close` | `boolean`          | `true`    | Close the split when terminal exits |

## Example

```lua
require("nvim-ai-cli").setup({
  cmd = { "aider", "--model", "claude-sonnet-4-20250514" },
  width = 50,
  side = "right",
})
```

## Roadmap

See [ROADMAP.md](./ROADMAP.md) for planned features.
