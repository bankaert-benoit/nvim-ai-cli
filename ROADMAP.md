# nvim-ai-cli — Roadmap

A Neovim plugin that launches any AI CLI tool (e.g. `gemini`, `claude`, `aider`, `sgpt`, …)
in a vertical split terminal buffer, fully driven by user config.

---

## Vision

Bring AI CLI assistants natively into Neovim without leaving the editor.
The plugin stays CLI-agnostic: any tool that runs interactively in a terminal
can be wired up through a simple configuration table.

---

## Milestones

### v0.1 — Core MVP

> Goal: open a vertical split terminal and launch the configured CLI tool.

- [x] Plugin scaffolding (`lua/nvim-ai-cli/init.lua`, `plugin/nvim-ai-cli.lua`)
- [x] `setup(opts)` entry-point accepting a config table
- [x] Config option: `cmd` — the CLI command to run (string or list of strings)
- [x] Config option: `width` — width of the vertical split (default: 40 % of window)
- [x] Config option: `side` — `"left"` or `"right"` (default: `"right"`)
- [x] Open a vertical split with `:vsplit` and start the CLI via `termopen()` / `jobstart()`
- [x] Auto-enter insert mode so the terminal is immediately interactive
- [x] User command `:AiCli` to toggle the panel open / close
- [x] Basic README with install & quick-start instructions

---

### v0.2 — Quality of Life

> Goal: make the panel feel polished and non-intrusive.

- [x] Toggle: if the panel is already open, close it; otherwise open it
- [x] Remember the terminal job across toggles (don't restart the CLI on every open)
- [x] Config option: `auto_close` — close the split when the terminal job exits
- [ ] Config option: `env` — extra environment variables forwarded to the CLI process
- [ ] Config option: `on_open` / `on_close` callbacks (Lua functions)
- [x] Keymaps: optional default keymap (e.g. `<leader>ai`) configurable via `keymap` option
- [x] Proper buffer options: `bufhidden=hide`, `nobuflisted`, etc.
- [ ] Graceful error handling when `cmd` is not found in `$PATH`

---

### v0.3 — Context Sharing

> Goal: send editor context to the CLI without copy-pasting.

- [ ] Command / keymap to send the current visual selection to the terminal stdin
- [ ] Command to send the entire current buffer to stdin
- [ ] Command to send a file path as an argument or via stdin
- [ ] Config option: `context_format` — a Lua function to format context before sending
      (e.g. wrap in a code fence with the filetype)
- [ ] Prompt prefix support: prepend a configurable string before the context

---

### v0.4 — Multiple Profiles

> Goal: support multiple CLI tools / personas without restarting Neovim.

- [ ] Config option: `profiles` — a table of named CLI configs
  ```lua
  profiles = {
    gemini = { cmd = "gemini" },
    claude = { cmd = "claude" },
    aider  = { cmd = "aider", env = { AIDER_NO_AUTO_COMMITS = "1" } },
  }
  ```
- [ ] `:AiCli {profile}` — open the panel with a specific profile
- [ ] Profile picker via `vim.ui.select` when no argument is given
- [ ] Each profile gets its own terminal buffer (parallel sessions)

---

### v0.5 — History & Sessions

> Goal: persist and restore conversations across Neovim sessions.

- [ ] Save terminal scrollback / transcript to a log file per profile
- [ ] Config option: `history_dir` — where logs are stored
- [ ] `:AiCliHistory` command to open the log for the current profile
- [ ] Session restore: optionally reattach to a running `tmux` / `screen` pane if detected

---

### v0.6 — UI Polish & Integrations

> Goal: feel like a first-class Neovim citizen.

- [ ] Optional floating window mode (alternative to vertical split)
- [ ] Config option: `layout` — `"vsplit"` | `"hsplit"` | `"float"`
- [ ] Status-line / winbar indicator showing which profile is active
- [ ] Integration hint: document how to use with `lualine`, `heirline`
- [ ] Telescope picker for switching profiles and browsing history
- [ ] Health check (`:checkhealth nvim-ai-cli`) verifying `cmd` executables exist

---

### v1.0 — Stable Release

> Goal: production-ready, well-documented, community-tested.

- [ ] Full documentation via `vimdoc` (`:help nvim-ai-cli`)
- [ ] Comprehensive test suite (using `plenary.nvim` busted runner)
- [ ] CI with GitHub Actions (lint via `luacheck`, tests on Neovim stable + nightly)
- [ ] Changelog and semantic versioning
- [ ] Plugin manager compatibility verified: `lazy.nvim`, `packer`, `vim-plug`

---

## Non-Goals (for now)

- Built-in HTTP/API clients — the plugin delegates all AI logic to the CLI tool
- Chat UI rendering (bubbles, markdown highlighting inside the terminal) — use the CLI's own UI
- LSP or completion integration — out of scope for v1

---

## Contributing

Contributions are welcome at any milestone.
Open an issue to discuss a feature before submitting a PR.

---

## Tech Stack

| Layer | Choice |
|---|---|
| Language | Lua (Neovim built-in) |
| Min Neovim version | 0.9+ |
| Terminal API | `vim.fn.termopen()` / `vim.fn.jobstart()` |
| Testing | `plenary.nvim` (busted) |
| CI | GitHub Actions |
