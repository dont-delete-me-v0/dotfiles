---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      treesitter = {
        highlight = true,
        indent = true,
        auto_install = true,
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "gotmpl",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "regex",
          "sql",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
      },
    },
  },
}
