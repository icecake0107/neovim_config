# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on kickstart.nvim - a starting point for Neovim that is small, single-file, and completely documented. It's NOT a Neovim distribution, but a foundation for personal configuration.

## Key Architecture

### Configuration Structure
- **`init.lua`**: Main configuration file containing all core settings, keymaps, and plugin specifications
- **`lua/custom/plugins/`**: User-defined plugins that extend the base configuration
  - `lsp.lua`: LSP configuration with Mason for auto-installation
  - `colortheme.lua`: Additional color theme (nvim-grey)
  - `init.lua`: Imports all custom plugins
- **`lua/kickstart/`**: Base kickstart plugins (optional additions)
- **`lazy-lock.json`**: Plugin version lock file managed by Lazy.nvim

### Plugin Management
- Uses **Lazy.nvim** as the plugin manager
- Plugins are configured directly in `init.lua` or modularized in `lua/custom/plugins/`
- Plugin installation is automatic on first startup

### Key Features
- **Leader key**: `<space>` (both leader and maplocalleader)
- **Auto-save**: Enabled on InsertLeave and TextChanged
- **Folding**: Advanced folding with nvim-ufo plugin using LSP and treesitter (Vue, Python, TypeScript, C++, HTML, etc.)
- **LSP**: Comprehensive setup with Mason for auto-installation, including Volar for Vue files
- **Autocompletion**: Uses blink.cmp with LuaSnip
- **Fuzzy Finding**: Telescope for files, grep, and LSP symbols
- **Color Themes**: Tokyo Night (default) with toggle to grey theme (`<leader>ub`)

## Common Commands

### Plugin Management
- `:Lazy` - View plugin status and manage plugins
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers and tools

### LSP Development
- `:LspInfo` - Show LSP server information
- `:checkhealth` - Check Neovim health including LSP setup
- Mason auto-installs: `stylua`, `eslint`, `prettierd` + configured LSP servers

### Key Mappings
- `<leader>f` - Format buffer with conform.nvim
- `<leader>gg` - Open LazyGit
- `<leader>qq` - Save and quit all buffers
- `<leader>bd` - Delete current buffer
- `<leader>ub` - Toggle between Tokyo Night and grey themes
- `<C-/>` - Toggle terminal (Snacks.terminal)

### Folding Commands
- `zR` - Open all folds
- `zM` - Close all folds
- `zr` - Open one fold level
- `zm` - Close one fold level
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `za` - Toggle fold under cursor

### Search and Navigation
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sh` - Search help
- `<leader>sk` - Search keymaps
- `<leader>sn` - Search Neovim config files
- `<leader>sr` - Search resume (last search)
- `<leader>ss` - Search select Telescope
- `<leader>st` - Search todos
- `<leader>sw` - Search current word
- `<leader>sd` - Search diagnostics
- `<leader>s.` - Search recent files
- `<leader>s/` - Search in open files

### LSP Keybindings (when LSP is attached)
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - Find references
- `grd` - Go to definition
- `gri` - Go to implementation
- `grt` - Go to type definition
- `gO` - Document symbols
- `gW` - Workspace symbols

## Development Setup

### Prerequisites
- Neovim (stable or nightly)
- `git`, `make`, `unzip`, C compiler
- `ripgrep` and `fd-find` for Telescope
- Node.js/npm for TypeScript/JavaScript development
- Nerd Font (optional but recommended)

### Language Servers
Currently configured LSP servers:
- `lua_ls` - Lua
- `pyright` - Python  
- `vtsls` - TypeScript/JavaScript
- `vue_ls` - Vue.js (with enhanced configuration for better folding)
- `html` - HTML
- `sourcekit` - Swift

### Adding New Plugins
1. Add plugin specification to `init.lua` plugins table, or
2. Create new file in `lua/custom/plugins/` and require it in `lua/custom/plugins/init.lua`

### Configuration Patterns
- Use `opts = {}` for simple plugin configuration
- Use `config = function()` for complex setup
- Event-based loading (`event = 'VimEnter'`) for performance
- Conditional loading with `cond` function
- Dependencies are automatically managed

## File Organization

### Core Files
- `init.lua` - Main configuration (970+ lines)
- `lazy-lock.json` - Plugin versions
- `README.md` - Installation and usage instructions

### Custom Extensions
- `lua/custom/plugins/` - User plugins
- `lua/kickstart/plugins/` - Optional kickstart plugins

### Auto-generated
- Lazy.nvim data in `~/.local/share/nvim/lazy/`
- Mason tools in `~/.local/share/nvim/mason/`

## Important Notes

- Configuration follows kickstart.nvim philosophy: readable, documented, educational
- Format-on-save is disabled by default (can be enabled in conform.nvim config)
- Auto-save is enabled for all file changes
- No relative line numbers by default (can be enabled)
- Nerd Font support is configurable via `vim.g.have_nerd_font`
- **nvim-ufo plugin**: Provides advanced folding using LSP and treesitter for improved code folding
- **vim-vue plugin**: Adds enhanced Vue.js support with better syntax highlighting and folding for single-file components
- **Enhanced Vue folding**: Combines nvim-ufo, vim-vue, and improved vue_ls configuration for better Vue Composition API folding
- **Search-optimized keybindings**: Removed mini.surround to avoid conflicts with `<leader>s` search commands