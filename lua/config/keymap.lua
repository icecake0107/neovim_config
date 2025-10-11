-- keymap
--------------------------------------------------------------------------------
-- Navigate visual lines
vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Up>', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set('i', '<Down>', '<C-\\><C-o>gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set('i', '<Up>', '<C-\\><C-o>gk', { desc = 'Navigate up (visual line)' })

-- Move Lines
vim.keymap.set({ 'n', 'x' }, '<M-S-Up>', ':move -2<cr>', { desc = 'Move Line Up' })
vim.keymap.set({ 'n', 'x' }, '<M-S-Down>', ':move +1<cr>', { desc = 'Move Line Down' })
vim.keymap.set('i', '<M-S-Up>', '<C-o>:move -2<cr>', { desc = 'Move Line Up' })
vim.keymap.set('i', '<M-S-Down>', '<C-o>:move +1<cr>', { desc = 'Move Line Down' })

-- Easier interaction with the system clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard after the cursor position' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before the cursor position' })

-- Navigating buffers
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })

-- Ctrl-L redraws the screen by default. Now it will also toggle search highlighting.
vim.keymap.set('n', '<C-l>', ':set hlsearch!<cr><C-l>', { desc = 'Toggle search highlighting' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Save and quit
vim.keymap.set('n', '<leader>qq', function()
  -- Close all terminal buffers first
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'terminal' then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  -- Then save and quit all
  vim.cmd 'wqa'
end, { desc = '[Q]uit all (save and quit)' })

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open lazygit' })

-- Toggle between color themes
vim.keymap.set('n', '<leader>ub', function()
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme == 'tokyonight-day' then
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'tokyonight-night'
  else
    -- Switch to melange light (latte)
    vim.o.background = 'light'
    vim.cmd.colorscheme 'tokyonight-day'
  end
end, { desc = 'Toggle [B]etween color themes' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize windows with Shift + arrow keys
vim.keymap.set('n', '<S-Up>', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<S-Down>', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<S-Left>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<S-Right>', '<C-w>>', { desc = 'Increase window width' })

-- Folding keymaps
vim.keymap.set('n', 'zR', function()
  -- Try nvim-ufo first, fallback to default
  if pcall(require, 'ufo') then
    require('ufo').openAllFolds()
  else
    vim.cmd 'normal! zR'
  end
end, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', function()
  -- Try nvim-ufo first, fallback to default
  if pcall(require, 'ufo') then
    require('ufo').closeAllFolds()
  else
    vim.cmd 'normal! zM'
  end
end, { desc = 'Close all folds' })
vim.keymap.set('n', 'zr', 'zr', { desc = 'Open one fold level' })
vim.keymap.set('n', 'zm', 'zm', { desc = 'Close one fold level' })
vim.keymap.set('n', 'zo', 'zo', { desc = 'Open fold under cursor' })
vim.keymap.set('n', 'zc', 'zc', { desc = 'Close fold under cursor' })
vim.keymap.set('n', 'za', 'za', { desc = 'Toggle fold under cursor' })

-- Github Copilot
vim.keymap.set('n', '<M-c>', function()
  -- Toggle Copilot
  if vim.g.copilot_enabled == true then
    vim.g.copilot_enabled = false
    print('Copilot Disabled')
  else
    vim.g.copilot_enabled = true
    print('Copilot Enabled')
  end
  vim.cmd 'redrawstatus'
end, { desc = 'Toggle GitHub [C]opilot' })

-- Checkmate.nvim keys
vim.keymap.set({'n'}, '<leader>ta', '<cmd>Checkmate archive<CR>', { desc = 'Archive checked/completed todo items (move to bottom section)' })
vim.keymap.set({'n', 'v'}, '<leader>tc', '<cmd>Checkmate check<CR>', { desc = 'Set todo item as checked (done)' })
vim.keymap.set({'n', 'v'}, '<leader>tC', '<cmd>Checkmate uncheck<CR>', { desc = 'Set todo item as unchecked' })
vim.keymap.set({'n', 'v'}, '<leader>tn', '<cmd>Checkmate create<CR>', { desc = 'Create todo item' })
vim.keymap.set({'n', 'v'}, '<leader>tr', '<cmd>Checkmate remove<CR>', { desc = 'Remove todo marker (convert to text)' })
vim.keymap.set({'n', 'v'}, '<leader>tt', '<cmd>Checkmate toggle<CR>', { desc = 'Toggle todo item' })
vim.keymap.set({'n', 'v'}, '<leader>tsp', '<cmd>Checkmate toggle on_hold<CR>', { desc = 'Set on hold status' })
vim.keymap.set({'n', 'v'}, '<leader>tsi', '<cmd>Checkmate toggle in_progress<CR>', { desc = 'Set in progress status' })
vim.keymap.set({'n', 'v'}, '<leader>tsx', '<cmd>Checkmate toggle cancelled<CR>', { desc = 'Set canceled status' })
vim.keymap.set({'n'}, '<leader>tv', '<cmd>Checkmate metadata select_value<CR>', { desc = 'Update the value of a metadata tag under the cursor' })
vim.keymap.set({'n'}, '<leader>t]', '<cmd>Checkmate metadata jump_next<CR>', { desc = 'Move cursor to next metadata tag' })
vim.keymap.set({'n'}, '<leader>t[', '<cmd>Checkmate metadata jump_previous<CR>', { desc = 'Move cursor to previous metadata tag' })

