# Neovim Plugins Overview

This directory contains all the plugin specifications loaded by [`lazy.nvim`](https://github.com/folke/lazy.nvim). Each `.lua` file returns a single plugin spec (or a list of specs) describing the plugin, its dependencies, lazy-loading triggers, and configuration.

## Table of Contents

- [Quick Reference](#quick-reference)
- [UI & Appearance](#ui--appearance)
- [Navigation & Search](#navigation--search)
- [Editing](#editing)
- [Completion & AI](#completion--ai)
- [Git Integration](#git-integration)
- [Language & Syntax](#language--syntax)
- [Markdown & Notes](#markdown--notes)
- [REPL & HTTP](#repl--http)
- [Productivity](#productivity)

## Quick Reference

| Plugin | File | Purpose |
|--------|------|---------|
| `tokyonight.nvim` | `colortheme.lua` | Color scheme (loads `default` colorscheme) |
| `snacks.nvim` | `snacks.lua` | QoL bundle: dashboard, terminal, notifier, indent guides, etc. |
| `mini.nvim` | `mini.lua` | Statusline + surround actions (with Copilot indicator) |
| `neo-tree.nvim` | `neo-tree.lua` | File explorer sidebar |
| `telescope.nvim` | `telescope.lua` | Fuzzy finder for files, grep, LSP, buffers |
| `aerial.nvim` | `aerial.lua` | Symbol/code outline window |
| `which-key.nvim` | `which-key.lua` | Popup that shows pending keybindings |
| `nvim-treesitter` | `nvim-treesitter.lua` | Syntax highlighting & parsing |
| `nvim-autopairs` | `autopairs.lua` | Auto-close brackets/quotes |
| `blink.cmp` | `blinkcmp.lua` | Fast completion engine (Rust fuzzy) |
| `copilot.vim` | `copilot.lua` | GitHub Copilot (disabled by default) |
| `nvim-dap` + `nvim-dap-ui` + `nvim-dap-python` | `dap.lua` | Debug Adapter Protocol client, UI, and Python (debugpy) integration |
| `gitsigns.nvim` | `gitsigns.lua` | Git diff signs in the gutter |
| `lazygit.nvim` | `lazygit.lua` | Lazygit terminal UI integration |
| `todo-comments.nvim` | `todo-comments.lua` | Highlight & search TODO/FIX/HACK comments |
| `nvim-ufo` | `ufo.lua` | Modern code folding |
| `render-markdown.nvim` | `render-makerdown.lua` | In-buffer markdown rendering |
| `obsidian.nvim` | `obsidian.lua` | Obsidian vault integration |
| `checkmate.nvim` | `checkmate.lua` | Markdown todo lists with custom states |
| `iron.nvim` | `iron.lua` | REPL integration (Python, Lua, Node, etc.) |
| `kulala.nvim` | `kulala.lua` | HTTP client for `.http` / `.rest` files |

---

## UI & Appearance

### `colortheme.lua` — tokyonight.nvim
Installs the [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) palette but actually loads Neovim's built-in `default` colorscheme. Comments are forced non-italic. Loaded with `priority = 1000` so it boots before other UI plugins.

### `snacks.lua` — snacks.nvim
A bundle of quality-of-life modules from [folke/snacks.nvim](https://github.com/folke/snacks.nvim) with the following enabled:

- `bigfile` — performance tweaks for large files
- `dashboard` — startup screen with a custom ASCII "OPZ" header
- `indent` — indent guides
- `input` — pretty `vim.ui.input`
- `notifier` — notification toasts (5s timeout, wrapping)
- `quickfile`, `scroll`, `statuscolumn`, `words`, `terminal`

Keybinds: `<C-/>` toggles a floating terminal, `<leader>n` opens notifier history.

### `mini.lua` — mini.nvim
Loads two `mini` modules:

- `mini.surround` — `sa`/`sd`/`sr` surround actions
- `mini.statusline` — sets the statusline; the location section is overridden to `LINE:COLUMN`, the filename section is augmented with the current Aerial symbol breadcrumb, and the fileinfo section gains a Copilot ON/OFF indicator (with light/dark-aware highlights that update on `ColorScheme` and `OptionSet background`).

### `which-key.lua` — which-key.nvim
Shows a popup of pending keybindings as soon as you start a chord (`delay = 0`). Loaded on `VimEnter`.

---

## Navigation & Search

### `neo-tree.lua` — neo-tree.nvim
File explorer in a sidebar. Eagerly loaded (`lazy = false`).

- `\` toggles the tree
- Follows the current file and binds to cwd
- Does **not** hide gitignored files

### `telescope.lua` — telescope.nvim
Fuzzy finder with `fzf-native` (built via `make`) and `ui-select` extensions. Loaded on `VimEnter`. Keybinds (all under `<leader>s*`):

| Key | Action |
|-----|--------|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sf` | Find files |
| `<leader>ss` | Telescope builtins |
| `<leader>sw` | Grep current word (also works on visual selection) |
| `<leader>sg` | Live grep |
| `<leader>sd` | Diagnostics |
| `<leader>sr` | Resume last picker |
| `<leader>s.` | Recent files |
| `<leader><leader>` | Buffers |
| `<leader>/` | Fuzzy search current buffer (dropdown theme) |
| `<leader>s/` | Live grep open files |
| `<leader>sn` | Find files in `stdpath('config')` |

### `aerial.lua` — aerial.nvim
Symbol outline window (treesitter → lsp → markdown → man backends). Opens on the left at window scope. Integrates with telescope (`require('telescope').load_extension('aerial')`) and is also surfaced in the `mini.statusline` filename breadcrumb.

| Key | Action |
|-----|--------|
| `<leader>a` | Toggle Aerial |
| `<leader>an` | Toggle Aerial Nav floating window |
| `<leader>ao` / `<leader>ac` | Open / close all symbols |
| `{` / `}` (in attached buf) | Prev / next symbol |

Additional in-window keymaps (jump, splits, fold tree) are defined inside the spec.

---

## Editing

### `autopairs.lua` — nvim-autopairs
Auto-closes brackets, quotes, etc. Loaded on `InsertEnter` with default options.

### `ufo.lua` — nvim-ufo
Modern folding engine with `promise-async` as a dependency. Plugin is declared but no `opts`/`config` is set here, so it uses default behavior (your folding setup likely lives in your global `init.lua` / `options.lua`).

---

## Completion & AI

### `blinkcmp.lua` — blink.cmp
Fast Rust-based completion engine, version `1.*` (uses pre-built binaries).

- Keymap preset: `default` (`C-y` to accept, `C-n`/`C-p` to navigate, `C-space` for menu/docs, `C-e` to hide)
- Sources: `lsp`, `path`, `snippets`, `buffer`
- Documentation popup is **not** auto-shown (manual trigger only)
- Fuzzy matcher prefers Rust with a warning fallback

### `copilot.lua` — copilot.vim
Loads [github/copilot.vim](https://github.com/github/copilot.vim) but starts with `vim.g.copilot_enabled = 0` (off by default). Toggle state is reflected in the mini.statusline indicator.

---

## Debugging

### `dap.lua` — nvim-dap + nvim-dap-ui + nvim-dap-python
Debug Adapter Protocol stack for stepping through code. **No Mason** is used; the Python adapter (`debugpy`) is auto-resolved at runtime from the project's active Python via this helper:

```lua
local function resolve_python()
  if vim.env.VIRTUAL_ENV  ~= nil and vim.env.VIRTUAL_ENV  ~= '' then
    return vim.env.VIRTUAL_ENV  .. '/bin/python'
  end
  if vim.env.CONDA_PREFIX ~= nil and vim.env.CONDA_PREFIX ~= '' then
    return vim.env.CONDA_PREFIX .. '/bin/python'
  end
  return vim.fn.exepath('python3') ~= '' and 'python3' or 'python'
end
```

**Plugins included:**

- [`mfussenegger/nvim-dap`](https://github.com/mfussenegger/nvim-dap) — core DAP client. Lazy-loaded via `keys`.
- [`rcarriga/nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui) — UI panels (Scopes, Stacks, Watches, Breakpoints, REPL, Console). Depends on `nvim-nio`. Auto-opens on `before.attach` / `before.launch` and auto-closes on `event_terminated` / `event_exited`.
- [`mfussenegger/nvim-dap-python`](https://github.com/mfussenegger/nvim-dap-python) — Python adapter glue. Lazy-loaded for `ft = 'python'`.

**Keymaps:**

| Key | Mode | Action |
|-----|------|--------|
| `<F5>` | n | Continue / start debugging |
| `<F10>` | n | Step over |
| `<F11>` | n | Step into |
| `<F12>` | n | Step out |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint (prompts for condition) |
| `<leader>dr` | n | Open REPL |
| `<leader>dl` | n | Run last configuration |
| `<leader>dq` | n | Terminate session |
| `<leader>du` | n | Toggle dap-ui |
| `<leader>de` | n / v | Eval expression / selection |
| `<leader>dt` | n | (python) Debug test method under cursor |
| `<leader>dc` | n | (python) Debug test class under cursor |
| `<leader>ds` | v | (python) Debug visual selection |

**How to use (per project):**

1. Activate the env where you want to debug: `source .venv/bin/activate` (or `conda activate myenv`).
2. Install debugpy in that env: `pip install debugpy`.
3. Launch `nvim` from that activated shell so `VIRTUAL_ENV` / `CONDA_PREFIX` is set.
4. Open a `.py` file, place cursor on a line, press `<leader>db` to set a breakpoint.
5. Press `<F5>` and pick a launch configuration (e.g., "Launch file"). dap-ui opens automatically.
6. Step with `<F10>` / `<F11>` / `<F12>`; inspect with `<leader>de`; open REPL with `<leader>dr`.
7. For pytest: cursor inside a test, `<leader>dt` debugs that single test; `<leader>dc` debugs the class.
8. `<leader>dq` terminates; dap-ui closes automatically.

**Verify:** `:checkhealth dap`, and `:lua print(require('dap-python').resolve_python and require('dap-python').resolve_python() or '(set at setup time)')` to confirm the Python interpreter in use. `:DapShowLog` for adapter logs.

---

## Git Integration

### `gitsigns.lua` — gitsigns.nvim
Git diff signs in the gutter (`+`, `~`, `_`, `‾`). Line-highlighting and word-diff start off.

| Key | Action |
|-----|--------|
| `]g` / `[g` | Next / previous hunk (or diff change in diff mode) |
| `<leader>gl` | Toggle line highlight |
| `<leader>gb` | Full blame for current line / visual selection |

### `lazygit.lua` — lazygit.nvim
Bare spec installing [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim). Provides the `:LazyGit` command (no custom keymap defined here).

---

## Language & Syntax

### `nvim-treesitter.lua` — nvim-treesitter
Runs `:TSUpdate` on install. Pre-installs parsers for: `bash`, `c`, `cpp`, `css`, `diff`, `html`, `javascript`, `json`, `lua`, `luadoc`, `markdown`, `markdown_inline`, `python`, `query`, `typescript`, `vim`, `vimdoc`, `vue`. `auto_install` is on. Indent enabled (Ruby disabled), highlight enabled with extra vim regex highlighting for Ruby.

---

## Markdown & Notes

### `render-makerdown.lua` — render-markdown.nvim
In-buffer markdown rendering (headings, code blocks, links, etc.).

- Renders in `n`, `c`, `t` modes
- Anti-conceal enabled but disabled in normal mode, with several elements (code background, indent, sign, virtual lines, link) always shown
- LaTeX rendering disabled
- Links rendered in normal & visual modes

### `obsidian.lua` — obsidian.nvim
Obsidian vault integration, lazy-loaded for `markdown` filetype. Two workspaces:

- `personal` → `~/Documents/obsidian/Personal`
- `work` → `~/Documents/obsidian/Work/`

Legacy commands disabled, and the plugin's UI is disabled (relies on `render-markdown.nvim` instead).

### `checkmate.lua` — checkmate.nvim
Rich todo lists in markdown files (`ft = 'markdown'`). Default keys are disabled.

**Todo states:** unchecked, checked (✅), `in_progress` ⏳ (`- [.]`), `cancelled` ❌ (`- [c]`), `on_hold` ⏸️ (`- [/]`).

**Metadata tags** with keymaps:

- `@started` / `@init` — timestamp, `<leader>tms`
- `@done` / `@completed` / `@finished` — timestamp, auto-toggles state, `<leader>tmd`
- `@priority` (low/medium/high) with color-coded styles, `<leader>tmp`

---

## REPL & HTTP

### `iron.lua` — iron.nvim
REPL integration that opens a vertical split on the right (50% width).

**REPL definitions:** Python (`python`), Lua (`lua`), JavaScript (`node`), TypeScript (`ts-node`), Bash, Sh. Block dividers like `# %%` / `// %%` / `-- %%` let you send code blocks à la Jupyter.

**Keybinds (under `<leader>i*` / `<leader>s*`):**

| Key | Action |
|-----|--------|
| `<leader>iri` | Toggle REPL |
| `<leader>irr` | Restart REPL |
| `<leader>isf` | Send file |
| `<leader>isl` | Send line |
| `<leader>isb` | Send code block |
| `<space>isn` | Send block & move |
| `<space>isp` | Send paragraph |
| `<leader>isc` / `<leader>isv` | Send motion / visual |
| `<leader>su` | Send until cursor |
| `<leader>imc` / `<leader>imd` | Mark / remove mark |
| `<leader>is<cr>` / `<leader>is<space>` / `<leader>isq` | CR / interrupt / exit |
| `<leader>icl` | Clear |

### `kulala.lua` — kulala.nvim
HTTP client (REST in Neovim) for `.http` / `.rest` files. Global keymaps prefixed with `<leader>R`:

- `<leader>Rs` — Send request
- `<leader>Ra` — Send all requests
- `<leader>Rb` — Open scratchpad

---

## Productivity

### `todo-comments.lua` — todo-comments.nvim
Highlights and searches TODO-style comments. Loaded on `VimEnter`. Recognized keywords: `FIX`/`FIXME`/`BUG`/`FIXIT`/`ISSUE`, `TODO`, `HACK`, `WARN`/`WARNING`/`XXX`, `PERF`/`OPTIM`/`PERFORMANCE`/`OPTIMIZE`, `NOTE`/`INFO`, `TEST`/`TESTING`/`PASSED`/`FAILED`.

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next / previous todo comment |
| `<leader>xt` | Trouble: all todos |
| `<leader>xT` | Trouble: TODO/FIX/FIXME only |
| `<leader>st` | TodoTelescope picker |

---

## Notes

- Most specs use `lazy.nvim`'s lazy-loading hooks (`event`, `ft`, `keys`) to keep startup snappy.
- `colortheme.lua` and `snacks.lua` use `priority = 1000` to ensure they load early.
- The Copilot indicator in the statusline lives in `mini.lua` and reads `vim.g.copilot_enabled` set by `copilot.lua`.
- Aerial integrates with both Telescope (extension) and the statusline (breadcrumb) — both wired up from their respective files.
- `render-makerdown.lua` is a typo for "render-markdown" but the file itself is fine; rename if you'd like consistency.
