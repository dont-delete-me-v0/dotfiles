-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- Jump 10 lines up/down with Shift+J/K
vim.keymap.set("n", "<S-j>", "10j", { noremap = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<S-k>", "10k", { noremap = true, desc = "Jump 10 lines up" })

-- Jump to start/end of line with Shift+H/L
vim.keymap.set("n", "<S-h>", "^", { noremap = true, desc = "Jump to line start" })
vim.keymap.set("n", "<S-l>", "$", { noremap = true, desc = "Jump to line end" })

-- Navigation in Insert mode with Ctrl+HJKL
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, desc = "Move up", remap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, desc = "Move right" })
