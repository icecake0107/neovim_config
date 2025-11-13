return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        render_modes = { 'n', 'c', 't' },
        anti_conceal = {
            enabled = true,
            disabled_modes = { 'n' },
            above = 0,
            below = 0,
            -- Which elements to always show, ignoring anti conceal behavior. Values can either be
            -- booleans to fix the behavior or string lists representing modes where anti conceal
            -- behavior will be ignored. Valid values are:
            --   bullet
            --   callout
            --   check_icon, check_scope
            --   code_background, code_border, code_language
            --   dash
            --   head_background, head_border, head_icon
            --   indent
            --   link
            --   quote
            --   sign
            --   table_border
            --   virtual_lines
            ignore = {
                code_background = true,
                indent = true,
                sign = true,
                virtual_lines = true,
                link = true
            },
        },
        link = { enabled = true, render_modes = { 'n', 'v' } },
        latex = {enabled=false}
    },
}

