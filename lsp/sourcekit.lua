---@brief
---
--- https://github.com/swiftlang/sourcekit-lsp
---
--- SourceKit-LSP provides language server support for Swift.
--- It is included with recent Swift toolchains and can be checked with:
--- ```sh
--- sourcekit-lsp --version
--- ```

---@type vim.lsp.Config
return {
    cmd = { 'sourcekit-lsp' },
    filetypes = { 'swift' },
    root_markers = {
        'Package.swift',
        'package.py',
        '.git',
    },
    capabilities = {
        textDocument = {
            diagnostic = {
                dynamicRegistration = true,
                relatedDocumentSupport = true,
            },
        },
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
