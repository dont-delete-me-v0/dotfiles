return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      -- Resize with Alt + arrow keys
      { "<M-Up>", function() require("smart-splits").resize_up() end, desc = "Resize up" },
      { "<M-Down>", function() require("smart-splits").resize_down() end, desc = "Resize down" },
      { "<M-Left>", function() require("smart-splits").resize_left() end, desc = "Resize left" },
      { "<M-Right>", function() require("smart-splits").resize_right() end, desc = "Resize right" },
    },
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
        "neo-tree",
      },
    },
  },
}
