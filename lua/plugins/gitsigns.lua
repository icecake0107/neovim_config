  return { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      -- Enable line highlighting for git changes
      linehl = false, -- Start with line highlighting off, toggle with <leader>tl
      -- Optionally, you can also add word highlighting
      word_diff = false, -- Set to true if you want word-level diff highlighting
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git hunk' })

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git hunk' })

        -- Toggle line highlighting
        map('n', '<leader>gl', gitsigns.toggle_linehl, { desc = 'Toggle git line highlighting' })

        -- Show git blame for current line
        map('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Show git blame for current line' })

        -- Show git blame for selected lines in visual mode
        map('v', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Show git blame for selected lines' })
      end,
    },
  }
