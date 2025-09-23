return {
  { 'savq/melange-nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Ensure it loads early
    opts = {
      flavour = 'latte', -- Or "latte", "frappe", "macchiato"
      color_overrides = {
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {},
      },
      custom_highlights = function(colors)
        return {}
      end,
    },
  },
}
