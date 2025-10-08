return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup({
      -- Priority list of preferred backends for aerial.
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },

      layout = {
        -- Determines the default direction to open the aerial window.
        default_direction = 'left',
        -- Determines where the aerial window will be opened
        placement = 'window',
        -- Preserve window size equality with (:help CTRL-W_=)
        preserve_equality = false,
      },

      -- Keymaps in aerial window
      keymaps = {
        ['?'] = 'actions.show_help',
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.jump',
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit',
        ['<C-s>'] = 'actions.jump_split',
        ['p'] = 'actions.scroll',
        ['<C-j>'] = 'actions.down_and_scroll',
        ['<C-k>'] = 'actions.up_and_scroll',
        ['{'] = 'actions.prev',
        ['}'] = 'actions.next',
        ['[['] = 'actions.prev_up',
        [']]'] = 'actions.next_up',
        ['q'] = 'actions.close',
        ['o'] = 'actions.tree_toggle',
        ['za'] = 'actions.tree_toggle',
        ['O'] = 'actions.tree_toggle_recursive',
        ['zA'] = 'actions.tree_toggle_recursive',
        ['l'] = 'actions.tree_open',
        ['zo'] = 'actions.tree_open',
        ['L'] = 'actions.tree_open_recursive',
        ['zO'] = 'actions.tree_open_recursive',
        ['h'] = 'actions.tree_close',
        ['zc'] = 'actions.tree_close',
        ['H'] = 'actions.tree_close_recursive',
        ['zC'] = 'actions.tree_close_recursive',
        ['zr'] = 'actions.tree_increase_fold_level',
        ['zR'] = 'actions.tree_open_all',
        ['zm'] = 'actions.tree_decrease_fold_level',
        ['zM'] = 'actions.tree_close_all',
        ['zx'] = 'actions.tree_sync_folds',
        ['zX'] = 'actions.tree_sync_folds',
      },

      -- When true, don't load aerial until a command or function is called
      lazy_load = true,

      -- Disable aerial on files with this many lines
      disable_max_lines = 10000,

      -- Disable aerial on files this size or larger (in bytes)
      disable_max_size = 2000000, -- 2MB

      -- A list of all symbols to display. Set to false to display all symbols.
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
        'Field',
        'Property',
        'Constant',
        'Variable',
      },

      -- Automatically open aerial when entering supported buffers
      open_automatic = false,

      -- Show box drawing characters for the tree hierarchy
      show_guides = true,

      -- Customize the characters used when show_guides = true
      guides = {
        mid_item = '├─',
        last_item = '└─',
        nested_top = '│ ',
        whitespace = '  ',
      },

      -- Options for opening aerial in a floating win
      float = {
        border = 'rounded',
        relative = 'cursor',
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
        override = function(conf, source_winid)
          conf.col = conf.col + 2
          return conf
        end,
      },

      -- Options for the floating nav windows
      nav = {
        border = 'rounded',
        max_height = 0.9,
        min_height = { 10, 0.1 },
        max_width = 0.5,
        min_width = { 0.2, 20 },
        win_opts = {
          cursorline = true,
          winblend = 10,
        },
        -- Jump to symbol in source window when the cursor moves
        autojump = false,
        -- Show a preview of the code in the right hand side of the nav window
        preview = false,
        -- Keymaps in the nav window
        keymaps = {
          ['<CR>'] = 'actions.jump',
          ['<2-LeftMouse>'] = 'actions.jump',
          ['<C-v>'] = 'actions.jump_vsplit',
          ['<C-s>'] = 'actions.jump_split',
          ['h'] = 'actions.left',
          ['l'] = 'actions.right',
          ['<C-c>'] = 'actions.close',
        },
      },

      -- Options for the code window that appears with the preview
      preview = {
        -- Determines whether to open preview immediately upon opening aerial
        open_automatic = false,
      },

      -- Options for highlighting
      highlight_on_hover = true,
      highlight_on_jump = 300,

      -- Run this function when aerial attaches to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    })

    -- Set up telescope integration
    require('telescope').load_extension('aerial')

    -- You can also use the aerial API directly
    local aerial = require('aerial')

    -- Toggle the aerial window with <leader>a
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })

    -- Optional additional keymaps
    vim.keymap.set('n', '<leader>an', '<cmd>AerialNavToggle<CR>', { desc = 'Aerial Nav Toggle' })
    vim.keymap.set('n', '<leader>ao', '<cmd>AerialOpenAll<CR>', { desc = 'Aerial Open All' })
    vim.keymap.set('n', '<leader>ac', '<cmd>AerialCloseAll<CR>', { desc = 'Aerial Close All' })
  end,
}
