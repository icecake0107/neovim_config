return  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Add aerial symbol information to statusline
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        -- Get the default filename section
        local filename = vim.fn.expand '%:t'
        if filename == '' then
          filename = '[No Name]'
        end

        -- Get aerial symbol information if available
        local aerial_info = ''
        local ok, aerial = pcall(require, 'aerial')
        if ok then
          local symbols = aerial.get_location(true)
          if symbols and #symbols > 0 then
            local symbol_names = {}
            for _, symbol in ipairs(symbols) do
              table.insert(symbol_names, symbol.name)
            end
            aerial_info = ' › ' .. table.concat(symbol_names, ' › ')
          end
        end

        return filename .. aerial_info
      end

      local default_section_fileinfo = statusline.section_fileinfo
      statusline.section_fileinfo = function(...)
        local fileinfo = default_section_fileinfo(...)

        local function is_copilot_enabled()
          local value = vim.g.copilot_enabled
          if type(value) == 'boolean' then
            return value
          elseif type(value) == 'number' then
            return value ~= 0
          elseif type(value) == 'string' then
            local lowered = value:lower()
            return lowered ~= '0' and lowered ~= 'false'
          end
          return false
        end

        local icon = vim.g.have_nerd_font and '' or 'Copilot'
        local indicator = string.format('%s %s', icon, is_copilot_enabled() and 'ON' or 'OFF')

        if fileinfo ~= '' then
          return string.format('%s %s', indicator, fileinfo)
        end

        return indicator
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  }
