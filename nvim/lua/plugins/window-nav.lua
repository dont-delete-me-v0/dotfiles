return {
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Window navigation with Alt/Option+WASD
      vim.keymap.set("n", "<M-w>", "<C-w>k", { noremap = true, desc = "Go to window above" })
      vim.keymap.set("n", "<M-a>", "<C-w>h", { noremap = true, desc = "Go to window left" })
      vim.keymap.set("n", "<M-s>", "<C-w>j", { noremap = true, desc = "Go to window below" })
      vim.keymap.set("n", "<M-d>", "<C-w>l", { noremap = true, desc = "Go to window right" })

    end,
  },
}
