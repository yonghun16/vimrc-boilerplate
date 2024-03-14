---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "gruvchad",
  theme_toggle = { "gruvchad", "one_light" },
  nvdash = {
    load_on_startup = true,
  }
}

if M.ui.theme == string.lower("GRUVCHAD") then
  M.ui.hl_override = {
    CursorLine = { bg = "#232728" }
  }
elseif M.ui.theme == string.lower("GRUVBOX") then
  M.ui.hl_override = {
    CursorLine = { bg = "#2e2e2e" }
  }
end

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
