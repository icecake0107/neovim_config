return {
    "MSmaili/wiremux.nvim",
    dependencies = {
        "ibhagwan/fzf-lua",  -- optional
        "folke/snacks.nvim", -- optional
    },
    opts = {
        picker = {
            adapter = "fzf-lua",
            instances = {
            filter = nil,
          },
        },
        targets = {
            definitions = {
                -- Define your Cursor agent CLI target here
                cursor = {
                    cmd = "agent",        -- Replace with the exact command you use to launch the agent
                    kind = "pane",
                    split = "horizontal", -- Opens side-by-side
                    shell = false,        -- Set to true if you need to run it inside a shell environment
                },
            },
        },
    },
    keys = {
        -- Send file path + cursor line + visual selection (automatically formatted)
        {
            "<leader>aS",
            function()
                require("wiremux").send("@{this}", { target = "cursor",behavior = "last", post_keys = "C-j" })
            end,
            mode = { "n", "x" },
            desc = "Send context to Cursor agent"
        },

        -- Toggle visibility of the cursor agent pane
        {
            "<leader>aT",
            function()
                require("wiremux").toggle({
                    target = "cursor"
                })
            end,
            desc = "Toggle Cursor Agent Pane"
        },

        -- Adopt an existing tmux pane as the cursor target
        {
            "<leader>aA",
            function()
                require("wiremux").adopt({ target = "cursor" })
            end,
            desc = "Adopt pane as Cursor agent"
        },

        -- Pass a list of items to get a menu:
        {
            "<leader>aP",
            function()
                require("wiremux").send({
                    { label = "Explain this",   value = "Explain {this}",behavior = "last", post_keys = "C-j" },
                    { label = "Review changes", value = "Review my changes:\n{changes}",behavior = "last", post_keys = "C-j" },
                })
            end,
            desc = "Toggle Cursor Agent Pane"
        },
    }
}
