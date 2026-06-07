-- local colorscheme = "github_dark_dimmed"
local colorscheme = "astrodark"

---@type LazySpec
return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
  },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
