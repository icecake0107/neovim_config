return {
  'bngarren/checkmate.nvim',
  ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
  opts = {
    -- Disable the defalt keys
    keys = false,
    todo_states = {
      -- Built-in states (cannot change markdown or type)
      unchecked = { marker = '' },
      checked = { marker = '✅' },

      -- Custom states
      in_progress = {
        marker = '⏳',
        markdown = '.', -- Saved as `- [.]`
        type = 'incomplete', -- Counts as "not done"
        order = 50,
      },
      cancelled = {
        marker = '❌',
        markdown = 'c', -- Saved as `- [c]`
        type = 'complete', -- Counts as "done"
        order = 2,
      },
      on_hold = {
        marker = '⏸️',
        markdown = '/', -- Saved as `- [/]`
        type = 'inactive', -- Ignored in counts
        order = 100,
      },
    },
    metadata = {
      started = {
        aliases = { 'init' },
        style = { fg = '#9fd6d5' },
        get_value = function()
          return tostring(os.date '%m/%d/%y %H:%M')
        end,
        key = '<leader>tms',
        sort_order = 20,
      },
      -- Example: A @done tag that also sets the todo item state when it is added and removed
      done = {
        aliases = { 'completed', 'finished' },
        style = { fg = '#96de7a' },
        get_value = function()
          return tostring(os.date '%m/%d/%y %H:%M')
        end,
        key = '<leader>tmd',
        on_add = function(todo_item)
          require('checkmate').set_todo_item(todo_item, 'checked')
        end,
        on_remove = function(todo_item)
          require('checkmate').set_todo_item(todo_item, 'unchecked')
        end,
        sort_order = 30,
      },
    },
    -- files = { "*.md" }, -- any .md file (instead of defaults)
  },
}

