-- ~\AppData\Local\nvim\lua\myconfig\init.lua
-- =============================================================================
-- MAIN CONFIGURATION LOADER
-- =============================================================================
-- This file loads all configuration modules in the correct order
-- Think of this as the "table of contents" for your config
-- =============================================================================

-- STEP 1: Set leader keys FIRST before anything else
-- Leader key is like a namespace for custom commands
-- Space is popular because it's easy to reach and not used by default
vim.g.mapleader = " "        -- Main leader (space bar)
vim.g.maplocalleader = "\\"  -- Local leader for filetype-specific mappings

-- STEP 2: Load basic Vim settings
-- These are editor behaviors (line numbers, tabs, search, etc.)
require("myconfig.options")

-- STEP 3: Load keymaps
-- Custom keyboard shortcuts for navigation and editing
require("myconfig.keymaps")

-- STEP 4: Bootstrap and configure lazy.nvim plugin manager
-- This must come last because plugins might depend on options/keymaps
require("myconfig.lazy")

-- =============================================================================
-- That's it! The lazy.nvim setup will automatically load all plugins
-- from the lua/myconfig/plugins/ directory
-- =============================================================================

-- Optional: Add autocommands here if you need them
-- Example: Auto-format on save, highlight yanked text, etc.
-- For now, we'll keep it simple and add these as needed
