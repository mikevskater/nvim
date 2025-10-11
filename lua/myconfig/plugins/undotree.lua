-- ~\AppData\Local\nvim\lua\myconfig\plugins\undotree.lua
-- =============================================================================
-- UNDOTREE - Visualize Undo History
-- =============================================================================
-- Shows undo history as a tree, travel through time in your file
-- =============================================================================

return {
  "mbbill/undotree",
  
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle,
      { desc = "Toggle undotree" })
  end,
}

-- Usage: <leader>u to toggle undotree panel
