-- ~\AppData\Local\nvim\init.lua
-- =============================================================================
-- MULTI-MODE NEOVIM CONFIGURATION
-- =============================================================================
-- Supports both:
--   1. Standalone Neovim (full-featured IDE)
--   2. VSCode-Neovim (minimal, VSCode-compatible)
--
-- The configuration automatically detects the environment and loads
-- the appropriate modules
-- =============================================================================

-- Detect if running inside VSCode
if vim.g.vscode then
  -- ==========================================================================
  -- VSCODE MODE
  -- ==========================================================================
  -- When running inside VSCode, we load a minimal config
  -- VSCode handles: LSP, completion, file explorer, fuzzy finding, etc.
  -- Neovim handles: Modal editing, text objects, motions
  
  require("myconfig.vscode")
  
else
  -- ==========================================================================
  -- STANDALONE MODE
  -- ==========================================================================
  -- Full-featured Neovim configuration with all plugins
  
  require("myconfig")
  
end

-- =============================================================================
-- NOTES
-- =============================================================================
-- Why separate configs?
-- - VSCode provides its own LSP, completion, file explorer, etc.
-- - Many Neovim plugins conflict with VSCode or are redundant
-- - Different keybindings are needed (some keys must go to VSCode)
-- - Performance: VSCode mode should be lightweight
--
-- What's shared?
-- - Basic options (line numbers, indentation, etc.)
-- - Core keymaps (motions, text manipulation)
-- - Compatible plugins (surround, commentary, flash)
--
-- What's different?
-- - Standalone: Full plugin suite (LSP, Telescope, Oil, etc.)
-- - VSCode: Minimal plugins, VSCode-specific keybindings
-- =============================================================================

