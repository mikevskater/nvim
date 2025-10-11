-- ~\AppData\Local\nvim\lua\myconfig\plugins\harpoon.lua
-- =============================================================================
-- HARPOON - Quick File Navigation
-- =============================================================================
-- Why Harpoon? ThePrimeagen's plugin for marking and jumping to files
-- Perfect for working with 4-5 main files in a project
-- =============================================================================

return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    
    -- Keybindings
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
      { desc = "Harpoon: Add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon: Toggle menu" })
    
    -- Quick jump to files 1-4
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end,
      { desc = "Harpoon: File 1" })
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end,
      { desc = "Harpoon: File 2" })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end,
      { desc = "Harpoon: File 3" })
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end,
      { desc = "Harpoon: File 4" })
  end,
}

-- =============================================================================
-- HARPOON USAGE
-- =============================================================================
-- <leader>a  - Mark current file
-- <C-e>      - Open harpoon menu
-- <C-h/t/n/s> - Jump to marked files 1-4
-- =============================================================================
