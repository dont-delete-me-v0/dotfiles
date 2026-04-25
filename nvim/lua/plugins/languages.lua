return {
  -- Run golangci-lint from module root so import resolution works
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        pattern = "*.go",
        callback = function(args)
          local lint = require("lint")
          if not lint.linters.golangcilint then
            return
          end
          local root = vim.fs.root(args.buf, { "go.work", "go.mod" })
          if root then
            lint.linters.golangcilint.cwd = root
          end
        end,
      })
      return opts
    end,
  },

  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "gotmpl",
        "json",
        "jsonc",
        "yaml",
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
        "vimdoc",
      },
    },
  },

  -- Mason configuration for tools (updated name)
  {
    "mason-org/mason.nvim",
    opts = {
      pip = { install_args = {} },
      npm = { install_args = {} },
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
        "goimports",
        "gofumpt",
        "golangci-lint",
        "delve",
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
            "javascriptreact",
            "typescriptreact",
          },
        },
        -- Go
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              gofumpt = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                unusedparams = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
                shadow = true,
                fieldalignment = false,
                nilness = true,
              },
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              semanticTokens = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
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
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        go = { "goimports", "gofumpt" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    },
  },
}
