---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      features = {
        codelens = true,
        inlay_hints = true,
        semantic_tokens = true,
      },
      formatting = {
        format_on_save = {
          enabled = true,
          allow_filetypes = {
            "bash",
            "css",
            "go",
            "html",
            "javascript",
            "javascriptreact",
            "json",
            "jsonc",
            "lua",
            "sh",
            "typescript",
            "typescriptreact",
            "yaml",
          },
        },
        disabled = { "ts_ls" },
        timeout_ms = 2000,
      },
      servers = {
        "bashls",
        "cssls",
        "emmet_language_server",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "tailwindcss",
        "ts_ls",
        "yamlls",
      },
      config = {
        emmet_language_server = {
          filetypes = {
            "css",
            "html",
            "javascriptreact",
            "typescriptreact",
          },
        },
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
                fieldalignment = false,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
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
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        tailwindcss = {
          filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        },
      },
    },
  },
}
