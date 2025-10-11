-- Auto save
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = { '*' },
  command = 'silent! wall',
  nested = true,
})

-- Auto reload buffers on external file changes
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI', 'TermClose', 'TermLeave' }, {
  command = 'checktime',
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
  end,
})

-- Create an autocommand for "BufRead" events
vim.api.nvim_create_autocmd('BufRead', {
  -- This autocommand will only trigger if the buffer name matches the following patterns
  pattern = { '*' },
  -- The autocommand will trigger the following lua function
  callback = function()
    vim.opt.eol = true
    vim.cmd 'set noeol'
  end,
})
