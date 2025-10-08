-- options
--------------------------------------------------------------------------------
-- Relative and absolute line numbers combined
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Cursorline
vim.opt.cursorline = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions
vim.opt.inccommand = 'split'

-- Text wrapping
vim.opt.wrap = true
vim.opt.breakindent = true

-- Tabstops
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Save undo history
vim.opt.undofile = true

-- Set the default border for all floating windows
vim.opt.winborder = 'rounded'

-- Enable break indent
vim.o.breakindent = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Enable vertical cursor column highlight
vim.opt.cursorcolumn = true

vim.opt.textwidth = 110

vim.opt.eol = false
vim.opt.winborder = 'rounded'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

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

