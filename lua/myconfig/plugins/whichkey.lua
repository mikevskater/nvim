-- ~\AppData\Local\nvim\lua\myconfig\plugins\whichkey.lua
-- =============================================================================
-- WHICH-KEY - Keybinding Helper
-- =============================================================================
-- Shows available keybindings in a popup as you type
-- Perfect for learning your own keymaps!
-- =============================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    
    -- Add custom key group names
    spec = {
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>w", group = "Workspace" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>c", group = "Code" },
      { "<leader>b", group = "Buffer" },
    },
  },
}

-- =============================================================================
-- WHICH-KEY USAGE
-- =============================================================================
-- Just start typing a key sequence (like <leader>) and wait a moment
-- A popup will show all available keybindings!
-- =============================================================================
