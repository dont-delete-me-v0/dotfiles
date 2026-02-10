return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "b", desc = "Buffers", action = ":lua Snacks.picker.buffers()" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          -- left pane
          { section = "keys", gap = 1, padding = 1, pane = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, pane = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, pane = 1 },
          -- right pane
          {
            title = "Keymaps",
            padding = 1,
            pane = 2,
            text = {
              { "  Picker          ", hl = "SnacksDashboardDesc" },
              { "SPC ff  fg  fb  fh  fr  fd  fc\n", hl = "SnacksDashboardKey" },
              { "  Navigation      ", hl = "SnacksDashboardDesc" },
              { "M-wasd splits     H/L start/end\n", hl = "SnacksDashboardKey" },
              { "  Splits          ", hl = "SnacksDashboardDesc" },
              { "C-w v vertical    C-w s horizontal\n", hl = "SnacksDashboardKey" },
              { "  Buffers         ", hl = "SnacksDashboardDesc" },
              { "SPC bd delete     [b ]b prev/next\n", hl = "SnacksDashboardKey" },
              { "  Git             ", hl = "SnacksDashboardDesc" },
              { "SPC gg lazygit    gl log  gs status\n", hl = "SnacksDashboardKey" },
              { "  Tools           ", hl = "SnacksDashboardDesc" },
              { "SPC z zen   . scratch   C-/ term\n", hl = "SnacksDashboardKey" },
              { "  AeroSpace       ", hl = "SnacksDashboardDesc" },
              { "  Focus/Move      ", hl = "SnacksDashboardDesc" },
              { "M-hjkl focus      M-S-hjkl move\n", hl = "SnacksDashboardKey" },
              { "  Workspaces      ", hl = "SnacksDashboardDesc" },
              { "M-1..9 workspace  M-S-1..9 to ws\n", hl = "SnacksDashboardKey" },
              { "  Modes           ", hl = "SnacksDashboardDesc" },
              { "M-f full          M-S-SPC tile\n", hl = "SnacksDashboardKey" },
              { "  Control         ", hl = "SnacksDashboardDesc" },
              { "M-r resize        M-S-c reload\n", hl = "SnacksDashboardKey" },
            },
          },
          { section = "startup" },
        },
      },
      explorer = {
        enabled = true,
        win = {
          style = {
            bg = "NONE",
          },
        },
      },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<a-d>"] = false, -- disable inspect, conflicts with window nav
              ["<a-w>"] = false, -- disable cycle_win, conflicts with window nav
              ["<a-a>"] = false, -- conflicts with window nav
              ["<a-s>"] = false, -- conflicts with window nav
            },
          },
          list = {
            keys = {
              ["<a-d>"] = false,
              ["<a-w>"] = false,
              ["<a-a>"] = false,
              ["<a-s>"] = false,
            },
          },
        },
      },
      notifier = { enabled = true, timeout = 3000 },
      indent = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      dim = { enabled = false },
      zen = { enabled = true },
      input = { enabled = true },
      toggle = { enabled = true },
      rename = { enabled = true },
    },
    keys = {
      -- find
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>fs", function() Snacks.picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },
      { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      -- top-level
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      -- explorer
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- git
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
      -- buffers
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      -- zen
      { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
      -- scratch
      { "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
      -- notifications
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
      -- rename
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      -- terminal
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
      -- words (LSP references)
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- toggles
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
