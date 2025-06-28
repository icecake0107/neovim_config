
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      volar = {
        filetypes = { "vue", "javascript", "typescript" }
      },
    },
    ensure_installed = {
      "volar",
    },
  },
}
