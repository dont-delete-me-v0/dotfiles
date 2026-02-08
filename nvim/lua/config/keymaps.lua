-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override default explorer binding to use neo-tree instead
vim.keymap.set("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "Toggle Neo-tree" })


-- Jump 10 lines up/down with Shift+J/K
vim.keymap.set("n", "<S-j>", "10j", { noremap = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<S-k>", "10k", { noremap = true, desc = "Jump 10 lines up" })

-- Jump to start/end of line with Shift+H/L
vim.keymap.set("n", "<S-h>", "^", { noremap = true, desc = "Jump to line start" })
vim.keymap.set("n", "<S-l>", "$", { noremap = true, desc = "Jump to line end" })
