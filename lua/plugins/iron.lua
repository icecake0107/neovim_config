return {
    'Vigemus/iron.nvim',
    config = function()
        local iron = require('iron.core')

        iron.setup({
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    python = {
                        command = { 'python', '--no-autoindent' },
                        format = require('iron.fts.common').bracketed_paste,
                    },
                    lua = {
                        command = { 'lua' },
                    },
                    javascript = {
                        command = { 'node' },
                    },
                    typescript = {
                        command = { 'ts-node' },
                    },
                    bash = {
                        command = { 'bash' },
                    },
                    sh = {
                        command = { 'sh' },
                    },
                },
                -- How the repl window will be displayed
                repl_open_cmd = require('iron.view').right(78),
            },
            -- Iron doesn't set keymaps by default anymore.
            -- You can set them here or manually add keymaps to the features you want
            keymaps = {
                send_motion = '<leader>isc',
                visual_send = '<leader>isc',
                send_file = '<leader>isf',
                send_line = '<leader>isl',
                send_until_cursor = '<leader>su',
                send_mark = '<leader>ism',
                mark_motion = '<leader>imc',
                mark_visual = '<leader>imc',
                remove_mark = '<leader>imd',
                cr = '<leader>is<cr>',
                interrupt = '<leader>is<space>',
                exit = '<leader>isq',
                clear = '<leader>icl',
            },
            -- If the highlight is on, you can change how it looks
            highlight = {
                italic = true,
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })

        -- Additional manual keymaps for REPL management
        vim.keymap.set('n', '<leader>irs', '<cmd>IronRepl<cr>', { desc = '[R]EPL [S]tart/Focus' })
        vim.keymap.set('n', '<leader>irr', '<cmd>IronRestart<cr>', { desc = '[R]EPL [R]estart' })
        vim.keymap.set('n', '<leader>irh', '<cmd>IronHide<cr>', { desc = '[R]EPL [H]ide' })
    end,
}
