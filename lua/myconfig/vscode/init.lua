-- ~\AppData\Local\nvim\lua\myconfig\vscode\init.lua
-- =============================================================================
-- VSCODE MODE CONFIGURATION
-- =============================================================================
-- Minimal configuration for VSCode-Neovim integration
-- VSCode handles: LSP, completion, file explorer, fuzzy finding
-- Neovim handles: Modal editing, text objects, motions
-- =============================================================================

-- Load shared core configuration
require("myconfig.core.options")
require("myconfig.core.keymaps")

-- Load VSCode-specific keymaps
require("myconfig.vscode.keymaps")

-- Load VSCode-compatible plugins (if using lazy.nvim)
-- These plugins enhance Neovim's text editing without conflicting with VSCode
require("myconfig.vscode.plugins")

-- =============================================================================
-- VSCODE-SPECIFIC SETTINGS
-- =============================================================================

-- Notify user that VSCode mode is active
vim.notify("Neovim loaded in VSCode mode", vim.log.levels.INFO)

-- =============================================================================
-- NOTES
-- =============================================================================
-- Plugins that work well in VSCode:
-- - flash.nvim (enhanced navigation)
-- - nvim-surround (surround text objects)
-- - vim-commentary or Comment.nvim (commenting)
-- - nvim-treesitter (better syntax understanding)
-- - targets.vim (additional text objects)
--
-- Plugins to AVOID in VSCode:
-- - nvim-cmp, blink.cmp (VSCode has its own completion)
-- - telescope.nvim (VSCode has Ctrl+P)
-- - oil.nvim, nvim-tree (VSCode has file explorer)
-- - lualine.nvim (VSCode has statusbar)
-- - All LSP plugins (VSCode has LSP)
-- - gitsigns (VSCode has GitLens)
-- =============================================================================
