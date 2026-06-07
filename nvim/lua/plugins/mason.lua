---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-language-server",
        "json-lsp",
        "yaml-language-server",
        "bash-language-server",
        "gopls",
        "goimports",
        "gofumpt",
        "golangci-lint",
        "delve",
        "prettier",
        "stylua",
        "shfmt",
      },
    },
  },
}
