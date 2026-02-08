return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "<c-k>", false, mode = "i" },
            { "<c-f>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
            { "<S-f>", vim.lsp.buf.hover, desc = "Hover" },
          },
        },
      },
    },
  },
}
