---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<M-w>"] = { "<C-w>k", desc = "Go to window above" },
          ["<M-a>"] = { "<C-w>h", desc = "Go to window left" },
          ["<M-s>"] = { "<C-w>j", desc = "Go to window below" },
          ["<M-d>"] = { "<C-w>l", desc = "Go to window right" },
          ["<S-j>"] = { "10j", desc = "Jump 10 lines down" },
          ["<S-k>"] = { "10k", desc = "Jump 10 lines up" },
          H = { "^", desc = "Jump to line start" },
          L = { "$", desc = "Jump to line end" },
          d = { '"_d', desc = "Delete without yank" },
          D = { '"_D', desc = "Delete to end without yank" },
          c = { '"_c', desc = "Change without yank" },
          C = { '"_C', desc = "Change to end without yank" },
          x = { '"_x', desc = "Delete char without yank" },
        },
        v = {
          H = { "^", desc = "Jump to line start" },
          L = { "$", desc = "Jump to line end" },
          d = { '"_d', desc = "Delete without yank" },
          D = { '"_D', desc = "Delete to end without yank" },
          c = { '"_c', desc = "Change without yank" },
          C = { '"_C', desc = "Change to end without yank" },
          x = { '"_x', desc = "Delete char without yank" },
          ["<C-j>"] = { ":move '>+1<CR>gv=gv", desc = "Move selection down" },
          ["<C-k>"] = { ":move '<-2<CR>gv=gv", desc = "Move selection up" },
          ["<C-h>"] = { "<gv", desc = "Move selection left (dedent)" },
          ["<C-l>"] = { ">gv", desc = "Move selection right (indent)" },
        },
        i = {
          ["<C-h>"] = { "<Left>", desc = "Move left" },
          ["<C-j>"] = { "<Down>", desc = "Move down" },
          ["<C-k>"] = { "<Up>", desc = "Move up" },
          ["<C-l>"] = { "<Right>", desc = "Move right" },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "md" },
        callback = function(args)
          vim.keymap.set("n", "<S-k>", "10k", { buffer = args.buf, desc = "Jump 10 lines up" })
          vim.keymap.set("n", "K", "10k", { buffer = args.buf, desc = "Jump 10 lines up" })
        end,
      })
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          K = false,
          ["<S-f>"] = { function() vim.lsp.buf.hover() end, desc = "Hover" },
        },
        i = {
          ["<C-k>"] = false,
          ["<C-f>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature Help" },
        },
      },
    },
  },
}
