return { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight'

      -- Respect the terminal's (transparent) background by clearing the
      -- background of common highlight groups. Reapplied on every colorscheme
      -- change so it survives reloads.
      local function make_transparent()
        local groups = {
          'Normal',
          'NormalNC',
          'NormalFloat',
          'FloatBorder',
          'FloatTitle',
          'SignColumn',
          'LineNr',
          'CursorLineNr',
          'EndOfBuffer',
          'MsgArea',
          'TabLine',
          'TabLineFill',
          'StatusLine',
          'StatusLineNC',
          'WinBar',
          'WinBarNC',
          'Folded',
          'FoldColumn',
          'NonText',
          'WinSeparator',
        }
        for _, group in ipairs(groups) do
          vim.api.nvim_set_hl(0, group, { bg = 'none', ctermbg = 'none' })
        end
      end

      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('TransparentBackground', { clear = true }),
        callback = make_transparent,
      })

      make_transparent()
    end,
  }
