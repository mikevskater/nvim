-- ~\AppData\Local\nvim\lua\myconfig\standalone\options.lua
-- =============================================================================
-- STANDALONE-ONLY OPTIONS
-- =============================================================================
-- Additional options that only apply to standalone Neovim
-- Core options are in myconfig/core/options.lua
-- =============================================================================

-- These are already set in core/options.lua when not in VSCode,
-- but we can add any additional standalone-specific options here

-- Example: Neovim-specific GUI options
if vim.fn.exists('g:neovide') == 1 then
  -- Neovide-specific settings
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_length = 0.8
end

-- Any other standalone-specific options can go here