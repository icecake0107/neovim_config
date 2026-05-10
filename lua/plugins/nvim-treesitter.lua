-- Nvim 0.12+: use nvim-treesitter `main` branch (full rewrite; `master` / old `configs` API removed).
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
local parsers = {
  'bash',
  'c',
  'cpp',
  'css',
  'diff',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
}

local ts_filetypes = {
  'bash',
  'sh',
  'c',
  'cpp',
  'css',
  'diff',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'python',
  'query',
  'typescript',
  'tsx',
  'vim',
  'help',
  'vue',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()
    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ts_filetypes,
      callback = function()
        local ok = pcall(function()
          vim.treesitter.start()
        end)
        if ok then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
