---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "kanagawa",
  theme_toggle = { "catppuccin", "kanagawa" },
  lsp_semantic_tokens = true,
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
