-- Mystery Shack — generated from theme/palette.json, the same source as
-- ghostty/themes/mystery-shack, so nvim and its terminal share one palette.
--
-- The palette follows the two published rules from Selenized (Jan Warchol),
-- the only widely used theme that states its numbers:
--   * every accent sits > 33 CIELAB L* above the background   (ours: 55.1)
--   * darkest and brightest accent differ by < 20 L*          (ours:  2.7)
-- All accents share one OKLCH lightness and chroma, so no hue outshouts the
-- rest -- amber used to be both lighter AND ~1.7x more saturated than
-- turquoise, which is why it kept taking over the screen.
--
-- Three passes:
--   1. mini.base16 paints syntax + every plugin it knows about
--   2. rebalance  — frequent things get calm colors, rare things get loud ones
--   3. transparency — let the terminal background through

local p = {
  bg      = "#1e1815",
  bg_alt  = "#2f2721",
  sel     = "#40352e",
  muted   = "#9b8a7d",   -- 5.29:1 — clears WCAG AA, unlike most themes' comments
  dim     = "#c4b4a3",
  fg      = "#e3d3bf",
  terra   = "#d08a79",
  ember   = "#eea695",
  amber   = "#c69261",
  flame   = "#e4af7d",
  gold    = "#b69b5a",
  pine    = "#8baa6e",
  moss    = "#a7c789",
  turq    = "#53b1a8",
  turq_lt = "#71cec4",
  teal    = "#53adc1",
  flower  = "#c788ac",
}

require("mini.base16").setup {
  palette = {
    base00 = p.bg,      -- default bg
    base01 = p.bg_alt,  -- lighter bg (statusline, folds)
    base02 = p.sel,     -- selection bg
    base03 = p.muted,   -- comments, invisibles
    base04 = p.dim,     -- dark fg (statusline text)
    base05 = p.fg,      -- default fg
    base06 = "#eee2d1", -- light fg
    base07 = "#f6ece0", -- light bg
    base08 = p.terra,   -- variables, diff deleted
    base09 = p.amber,   -- numbers, constants
    base0A = p.gold,    -- classes, types, search bg
    base0B = p.pine,    -- strings, diff added
    base0C = p.turq,    -- support, escapes
    base0D = p.teal,    -- functions, headings  (was 8° from base0C — one wasted slot)
    base0E = p.flower,  -- keywords
    base0F = p.ember,   -- deprecated
  },
  use_cterm = true,
}

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- ─── 2. Rebalance ────────────────────────────────────────────────────────
-- base16 routes every UI title through base0D, which drowned the editor in
-- turquoise. Painting all of it amber instead just swapped one flood for
-- another. Color is assigned by FREQUENCY: whatever appears most often gets
-- the calm accent, so cream carries the bulk and turquoise marks structure
-- (tree root, titles, folder icons, functions). Amber is spent only on things
-- that are rare AND mean "act on me": warnings, an open buffer, numbers.
hl("Directory",             { fg = p.fg })
hl("Title",                 { fg = p.turq_lt, bold = true })
hl("@markup.heading",       { fg = p.turq_lt, bold = true })

-- Icons go monochrome: mini.icons' nine color groups all collapse to one quiet
-- tone, so pickers and completion stop speckling. neo-tree gets its own two
-- (see lua/plugins/icons.lua): folders amber like their names, files cream.
for _, g in ipairs {
  "MiniIconsAzure", "MiniIconsBlue", "MiniIconsCyan", "MiniIconsGreen",
  "MiniIconsGrey", "MiniIconsOrange", "MiniIconsPurple", "MiniIconsRed",
  "MiniIconsYellow",
} do
  hl(g, { fg = p.dim })
end
hl("NeoTreeFileIcon",      { fg = p.dim })
hl("NeoTreeDirectoryIcon", { fg = p.turq_lt })

hl("NeoTreeRootName",       { fg = p.turq_lt, bold = true })
hl("NeoTreeDirectoryName",  { fg = p.fg })
hl("NeoTreeFileName",       { fg = p.dim })
hl("NeoTreeFileNameOpened", { fg = p.flame, bold = true })
hl("NeoTreeIndentMarker",   { fg = p.muted })
hl("NeoTreeGitModified",    { fg = p.flower })
hl("NeoTreeGitAdded",       { fg = p.moss })
hl("NeoTreeGitDeleted",     { fg = p.ember })
hl("NeoTreeGitUntracked",   { fg = p.turq_lt })
hl("NeoTreeGitConflict",    { fg = p.terra, bold = true })
hl("NeoTreeTabActive",      { fg = p.turq_lt, bold = true })
hl("NeoTreeTabInactive",    { fg = p.muted })

-- Snacks dashboard: defined here so our colors win over the plugin's
-- `default = true` links when it loads later.
hl("SnacksDashboardHeader", { fg = p.muted })
hl("SnacksDashboardIcon",   { fg = p.turq_lt })
hl("SnacksDashboardDesc",   { fg = p.dim })
hl("SnacksDashboardKey",    { fg = p.flame })
hl("SnacksDashboardFooter", { fg = p.muted, italic = true })
hl("SnacksDashboardTitle",  { fg = p.turq_lt, bold = true })
hl("SnacksDashboardDir",    { fg = p.muted })
hl("SnacksPickerMatch",     { fg = p.flame, bold = true })
hl("SnacksPickerDir",       { fg = p.muted })

hl("TelescopeTitle",        { fg = p.turq_lt, bold = true })
hl("TelescopeMatching",     { fg = p.flame, bold = true })
hl("TelescopeSelection",    { bg = p.sel, fg = p.fg })

-- git + diagnostics keep the shell's language: pine adds, ember deletes
hl("GitSignsAdd",           { fg = p.pine })
hl("GitSignsChange",        { fg = p.amber })
hl("GitSignsDelete",        { fg = p.ember })
hl("DiagnosticError",       { fg = p.terra })
hl("DiagnosticWarn",        { fg = p.amber })
hl("DiagnosticInfo",        { fg = p.turq_lt })
hl("DiagnosticHint",        { fg = p.flower })
hl("DiagnosticOk",          { fg = p.moss })

-- which-key / lazy / mason / blink: floats, so only the accents are retinted —
-- their backgrounds stay opaque (see the transparency note below).
hl("WhichKey",              { fg = p.turq_lt })
hl("WhichKeyGroup",         { fg = p.turq_lt })
hl("WhichKeyDesc",          { fg = p.fg })
hl("WhichKeySeparator",     { fg = p.muted })
hl("WhichKeyTitle",         { fg = p.turq_lt, bold = true })

hl("LazyH1",                { fg = p.bg, bg = p.amber, bold = true })
hl("LazyButtonActive",      { fg = p.bg, bg = p.amber, bold = true })
hl("LazySpecial",           { fg = p.turq_lt })
hl("LazyProgressDone",      { fg = p.moss })
hl("LazyProgressTodo",      { fg = p.muted })

hl("MasonHeader",           { fg = p.bg, bg = p.amber, bold = true })
hl("MasonHighlight",        { fg = p.turq_lt })
hl("MasonHighlightBlock",   { fg = p.bg, bg = p.turq })
hl("MasonMuted",            { fg = p.muted })

hl("BlinkCmpLabelMatch",    { fg = p.flame, bold = true })
hl("BlinkCmpKind",          { fg = p.turq_lt })
hl("BlinkCmpSource",        { fg = p.muted })
hl("BlinkCmpDocBorder",     { fg = p.muted })

hl("SnacksIndent",          { fg = p.bg_alt })
hl("SnacksIndentScope",     { fg = p.amber })
hl("MiniIndentscopeSymbol", { fg = p.amber })


-- Punctuation carries no meaning worth a hue, and red reads as "error".
-- Catppuccin's style guide maps braces/delimiters to a neutral for the same reason.
for _, g in ipairs {
  "@punctuation.bracket", "@punctuation.delimiter", "@punctuation.special",
  "@operator", "@tag.delimiter", "Delimiter",
} do
  hl(g, { fg = p.dim })
end


-- ─── 3. Transparency ─────────────────────────────────────────────────────
-- Surfaces that sit directly on the terminal go transparent. Anything that
-- floats ON TOP of buffer text (popups, completion, telescope results) stays
-- opaque — terminal blur only softens the desktop behind the window, not the
-- text behind a float, so a see-through popup is just unreadable.
local transparent = {
  "Normal", "NormalNC", "EndOfBuffer", "NonText",
  "SignColumn", "FoldColumn", "LineNr", "CursorLineNr", "Folded",
  "MsgArea", "MsgSeparator", "WinSeparator", "VertSplit",
  "StatusLine", "StatusLineNC", "WinBar", "WinBarNC",
  "TabLine", "TabLineFill", "TabLineSel",
  "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
  "NeoTreeWinSeparator", "NeoTreeStatusLine", "NeoTreeTabSeparatorActive",
  "NeoTreeTabSeparatorInactive",
  "SnacksDashboardNormal", "SnacksDashboardTerminal",
  "SnacksNormal", "SnacksBackdrop",
  "DiagnosticSignError", "DiagnosticSignWarn",
  "DiagnosticSignInfo", "DiagnosticSignHint",
}
for _, group in ipairs(transparent) do
  local cur = vim.api.nvim_get_hl(0, { name = group, link = false })
  cur.bg, cur.ctermbg = nil, nil
  hl(group, cur)
end

vim.g.colors_name = "mystery-shack"
