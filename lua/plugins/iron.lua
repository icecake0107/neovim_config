return {
    'Vigemus/iron.nvim',
    config = function()
        local iron = require('iron.core')
        local view = require('iron.view')

        iron.setup({
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    python = {
                        command = { 'python' },
                        block_dividers = { "# %%", "#%%" },
                    },
                    lua = {
                        command = { 'lua' },
                        block_dividers = { "-- %%", "#%%" },
                    },
                    javascript = {
                        command = { 'node' },
                        block_dividers = { "// %%", "#%%" },
                    },
                    typescript = {
                        command = { 'ts-node' },
                    },
                    bash = {
                        command = { 'bash' },
                        block_dividers = { "# %%", "#%%" },
                    },
                    sh = {
                        command = { 'sh' },
                        block_dividers = { "# %%", "#%%" },
                    },
                },
                -- How the repl window will be displayed
                repl_open_cmd = view.split.vertical.botright(0.5)
            },
            -- Iron doesn't set keymaps by default anymore.
            -- You can set them here or manually add keymaps to the features you want
            keymaps = {
                restart_repl = "<leader>irr", -- calls `IronRestart` to restart the repl
                toggle_repl = "<leader>iri",
                send_motion = '<leader>isc',
                visual_send = '<leader>isv',
                send_file = '<leader>isf',
                send_line = '<leader>isl',
                send_code_block = '<leader>isb',
                send_code_block_and_move = "<space>isn",
                send_paragraph = "<space>isp",
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
    end,
}

