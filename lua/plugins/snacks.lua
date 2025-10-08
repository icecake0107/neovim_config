return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {

      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
     ██████╗ ██████╗ ███████╗ 
    ██╔═══██╗██╔══██╗╚══███╔╝
    ██║   ██║██████╔╝  ███╔╝ 
    ██║   ██║██╔══██╗ ███╔╝  
    ╚██████╔╝██║  ██║███████╗
     ╚═════╝ ╚═╝  ╚═╝╚══════╝
    (ノ-_-)ノ~┻━┻
        ]],
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        wo = { wrap = true },
        timeout = 5000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      terminal = { enabled = true },
    },
    keys = {
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
    },
  }
