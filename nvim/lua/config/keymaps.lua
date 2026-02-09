-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Window navigation with Alt/Option+WASD
vim.keymap.set("n", "<M-w>", "<C-w>k", { noremap = true, desc = "Go to window above" })
vim.keymap.set("n", "<M-a>", "<C-w>h", { noremap = true, desc = "Go to window left" })
vim.keymap.set("n", "<M-s>", "<C-w>j", { noremap = true, desc = "Go to window below" })
vim.keymap.set("n", "<M-d>", "<C-w>l", { noremap = true, desc = "Go to window right" })

-- Jump 10 lines up/down with Shift+J/K
vim.keymap.set("n", "<S-j>", "10j", { noremap = true, desc = "Jump 10 lines down" })
vim.keymap.set("n", "<S-k>", "10k", { noremap = true, desc = "Jump 10 lines up" })

-- Jump to start/end of line with Alt+H/L
vim.keymap.set({ "n", "v" }, "<M-h>", "^", { noremap = true, desc = "Jump to line start" })
vim.keymap.set({ "n", "v" }, "<M-l>", "$", { noremap = true, desc = "Jump to line end" })

-- Deletions go to black hole register (don't overwrite clipboard)
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, desc = "Delete without yank" })
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, desc = "Delete to end without yank" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, desc = "Change without yank" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, desc = "Change to end without yank" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, desc = "Delete char without yank" })

-- Navigation in Insert mode with Ctrl+HJKL
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, desc = "Move up", remap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, desc = "Move right" })
