local colorscheme = "mystery-shack"

---@type LazySpec
return {
  {
    "echasnovski/mini.base16",
    lazy = false,
    priority = 1000,
    version = false,
    init = function() vim.o.background = "dark" end,
  },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
