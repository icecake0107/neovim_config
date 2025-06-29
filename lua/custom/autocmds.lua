-- Auto save all changes.
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = { '*' },
  command = 'silent! wall',
  nested = true,
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
