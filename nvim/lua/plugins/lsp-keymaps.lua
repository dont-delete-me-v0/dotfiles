return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false }, -- disable default hover
            { "<S-f>", vim.lsp.buf.hover, desc = "Hover" },
          },
        },
      },
    },
  },
}
