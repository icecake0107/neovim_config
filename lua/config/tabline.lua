local M = {}

function M.setup_hl()
  vim.api.nvim_set_hl(0, 'TabLine', { bg = 'none', fg = '#565f89' })
  vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#2563eb', fg = '#ffffff', bold = true })
  vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'TabLineMod', { fg = '#e0af68', bold = true })
end

local function get_buf_icon(bufnr)
  if not vim.g.have_nerd_font then
    return ''
  end

  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then
    return ''
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    local icon = devicons.get_icon('default_file', 'txt', { default = true })
    return icon and (icon .. ' ') or ''
  end

  local icon = devicons.get_icon(name, vim.fn.fnamemodify(name, ':e'), { default = true })
  return icon and (icon .. ' ') or ''
end

local function get_buf_label(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    return '[No Name]'
  end
  return vim.fn.fnamemodify(name, ':t')
end

function M.get()
  local str = ''
  local tab_count = vim.fn.tabpagenr('$')
  local current = vim.fn.tabpagenr()

  for i = 1, tab_count do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local hl = i == current and '%#TabLineSel#' or '%#TabLine#'
    local icon = get_buf_icon(bufnr)
    local label = get_buf_label(bufnr)
    local modified = vim.bo[bufnr].modified and ' %#TabLineMod#●' or ''

    str = str .. hl .. '%' .. i .. 'T ' .. i .. ' ' .. icon .. label .. modified .. ' %T'
  end

  return str
end

function M.setup()
  M.setup_hl()
  vim.opt.tabline = '%!v:lua.require("config.tabline").get()'

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('TablineHl', { clear = true }),
    callback = M.setup_hl,
  })
end

return M
