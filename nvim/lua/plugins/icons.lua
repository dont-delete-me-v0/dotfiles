-- Monochrome icons.
--
-- AstroNvim's neo-tree provider does `icon.highlight = hl`, where `hl` is one of
-- mini.icons' own nine color groups. That paints icons from a palette unrelated
-- to the colorscheme — teal folders next to amber folder names, red React icons,
-- near-white "grey" ones. Here we keep mini.icons' glyphs and drop its colors:
-- the icon simply takes the color of the name beside it.

---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      default_component_configs = {
        icon = {
          provider = function(icon, node)
            local mini_icons = require "mini.icons"
            local text
            if node.type == "file" then
              text = mini_icons.get("file", node.name)
              icon.highlight = "NeoTreeFileIcon"
            elseif node.type == "directory" then
              text = mini_icons.get("directory", node.name)
              -- an expanded directory keeps neo-tree's own open-folder glyph
              if node:is_expanded() then text = nil end
              icon.highlight = "NeoTreeDirectoryIcon"
            end
            if text then icon.text = text end
          end,
        },
      },
    },
  },
}
