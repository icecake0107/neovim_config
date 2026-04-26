-- DAP (Debug Adapter Protocol) setup for Python via debugpy
-- No Mason: debugpy is resolved from the project's active venv/conda env.

local function resolve_python()
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= '' then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end
  if vim.env.CONDA_PREFIX and vim.env.CONDA_PREFIX ~= '' then
    return vim.env.CONDA_PREFIX .. '/bin/python'
  end
  return vim.fn.exepath('python3') ~= '' and 'python3' or 'python'
end

return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'DAP: Continue / Start' },
      { '<F10>', function() require('dap').step_over() end, desc = 'DAP: Step Over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'DAP: Step Into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'DAP: Step Out' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'DAP: Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(input)
            if input and input ~= '' then
              require('dap').set_breakpoint(input)
            end
          end)
        end,
        desc = 'DAP: Conditional Breakpoint',
      },
      { '<leader>dr', function() require('dap').repl.open() end, desc = 'DAP: Open REPL' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'DAP: Run Last' },
      { '<leader>dq', function() require('dap').terminate() end, desc = 'DAP: Terminate Session' },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    keys = {
      { '<leader>du', function() require('dapui').toggle() end, desc = 'DAP: Toggle UI' },
      {
        '<leader>de',
        function() require('dapui').eval() end,
        mode = { 'n', 'v' },
        desc = 'DAP: Eval Expression',
      },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    keys = {
      {
        '<leader>dt',
        function() require('dap-python').test_method() end,
        ft = 'python',
        desc = 'DAP-Python: Test Method',
      },
      {
        '<leader>dc',
        function() require('dap-python').test_class() end,
        ft = 'python',
        desc = 'DAP-Python: Test Class',
      },
      {
        '<leader>ds',
        function() require('dap-python').debug_selection() end,
        mode = 'v',
        ft = 'python',
        desc = 'DAP-Python: Debug Selection',
      },
    },
    config = function()
      require('dap-python').setup(resolve_python())
    end,
  },
}
