-- ~\AppData\Local\nvim\lua\myconfig\plugins\autopairs.lua
-- =============================================================================
-- AUTO-PAIRS - Auto-close Brackets/Quotes
-- =============================================================================

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
}

-- Automatically closes (, [, {, ', ", etc.
