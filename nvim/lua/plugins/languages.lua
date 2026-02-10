return {
  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "jsx",
        "html",
        "css",
        "go",
        "json",
        "yaml",
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- Mason configuration for tools (updated name)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript/JavaScript
        "typescript-language-server",
        "prettier",
        "eslint_d",
        -- HTML/CSS
        "emmet-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        -- Go
        "gopls",
        "golangci-lint",
        -- Formatting
        "stylua",
        "shfmt",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Emmet (HTML completions in JSX/TSX)
        emmet_language_server = {
          filetypes = {
            "html",
            "css",
            "javascriptreact",
            "typescriptreact",
          },
        },
        -- HTML
        html = {},
        -- CSS
        cssls = {
          settings = {
            css = {
              lint = {
                compatibleVendorPrefixes = "warning",
                vendorPrefix = "warning",
                duplicateProperties = "warning",
              },
            },
          },
        },
        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "javascript",
            "typescript",
            "jsx",
            "tsx",
          },
        },
        -- Go
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
            },
          },
        },
      },
    },
  },

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        jsx = { "prettier" },
        tsx = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        go = { "gofmt", "goimports" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    },
  },
}
