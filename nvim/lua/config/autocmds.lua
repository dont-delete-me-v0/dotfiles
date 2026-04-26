-- Autocmds are automatically loaded on the VeryLazy event

-- Go: organize imports + format on save (через gopls code action)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params(0, "utf-8")
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
        end
      end
    end
  end,
})

local function apply_theme_overrides()
  -- Прозрачность для всех плавающих/Snacks окон
  local groups = {
    "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
    "SignColumn", "EndOfBuffer", "StatusLine", "StatusLineNC",
    "SnacksNormal", "SnacksNormalNC", "SnacksWinBar", "SnacksBackdrop",
    "SnacksDashboardNormal",
    "SnacksPickerNormal", "SnacksPickerBorder", "SnacksPickerTitle",
    "SnacksPickerInput", "SnacksPickerInputBorder", "SnacksPickerInputTitle",
    "SnacksPickerList", "SnacksPickerPreview", "SnacksPickerPreviewBorder",
    "SnacksPickerPreviewTitle",
    "NeoTreeNormal", "NeoTreeNormalNC",
    "TelescopeNormal", "TelescopeBorder",
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "NONE" })
  end

  -- Snacks accents — palette per kanagawa variant
  local palettes = {
    ["kanagawa-wave"] = {
      untracked = "#98BB6C", ignored = "#727169", modified = "#E6C384",
      added = "#98BB6C", deleted = "#E46876",
      title = "#7E9CD8", input = "#E6C384", preview = "#98BB6C",
      border = "#54546D", match = "#FFA066",
      dash_header = "#7E9CD8", dash_icon = "#E6C384",
      dash_key = "#FFA066", dash_desc = "#DCD7BA",
    },
    ["kanagawa-dragon"] = {
      untracked = "#87A987", ignored = "#625E5A", modified = "#C4B28A",
      added = "#87A987", deleted = "#C4746E",
      title = "#8BA4B0", input = "#C4B28A", preview = "#87A987",
      border = "#625E5A", match = "#B6927B",
      dash_header = "#8BA4B0", dash_icon = "#C4B28A",
      dash_key = "#B6927B", dash_desc = "#C5C9C5",
    },
    ["kanagawa-lotus"] = {
      untracked = "#6F894E", ignored = "#8A8980", modified = "#77713F",
      added = "#6F894E", deleted = "#C84053",
      title = "#4D699B", input = "#77713F", preview = "#6F894E",
      border = "#CFC8B6", match = "#E98A00",
      dash_header = "#4D699B", dash_icon = "#77713F",
      dash_key = "#E98A00", dash_desc = "#43436C",
    },
  }
  local p = palettes[vim.g.colors_name] or palettes["kanagawa-wave"]

  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = p.untracked })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = p.ignored })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = p.modified })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded", { fg = p.added })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted", { fg = p.deleted })

  vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = p.title, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerInputTitle", { fg = p.input, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPreviewTitle", { fg = p.preview, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = p.border })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = p.border })
  vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { fg = p.border })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = p.match, bold = true })
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = p.dash_header })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = p.dash_icon })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = p.dash_key })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = p.dash_desc })
end

-- Re-apply on any colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_theme_overrides,
})

-- Apply now (autocmd registers AFTER kanagawa already loaded on startup)
apply_theme_overrides()
