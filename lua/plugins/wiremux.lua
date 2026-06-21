return {
    "MSmaili/wiremux.nvim",
    dependencies = {
        "ibhagwan/fzf-lua",  -- optional
        "folke/snacks.nvim", -- optional
    },
    opts = {
        targets = {
            definitions = {
                -- Define your Cursor agent CLI target here
                cursor_agent = {
                    cmd = "agent",        -- Replace with the exact command you use to launch the agent
                    kind = { "pane" },
                    split = "horizontal", -- Opens side-by-side
                    shell = false,        -- Set to true if you need to run it inside a shell environment
                },
            },
        },
    },
    keys = {
        -- Send file path + cursor line + visual selection (automatically formatted)
        {
            "<leader>aT",
            function()
                require("wiremux").send("@{this}", { target = "cursor_agent", post_keys = "C-j" })
            end,
            mode = { "n", "x" },
            desc = "Send context to Cursor agent"
        },

        -- Toggle visibility of the cursor agent pane
        {
            "<leader>aA",
            function()
                require("wiremux").toggle({
                    target = "cursor_agent"
                })
            end,
            desc = "Toggle Cursor Agent Pane"
        },

        -- Pass a list of items to get a menu:
        {
            "<leader>aP",
            function()
                require("wiremux").send({
                    { label = "Explain this",   value = "Explain {this}",                post_keys = "C-j" },
                    { label = "Review changes", value = "Review my changes:\n{changes}", post_keys = "C-j" },
                })
            end,
            desc = "Toggle Cursor Agent Pane"
        },
    }
}
