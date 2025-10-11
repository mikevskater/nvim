-- ~\AppData\Local\nvim\lua\myconfig\plugins\gitsigns.lua
-- =============================================================================
-- GITSIGNS - Git Decorations
-- =============================================================================
-- Shows git changes in the sign column (added/modified/deleted lines)
-- =============================================================================

return {
  "lewis6991/gitsigns.nvim",
  
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local keymap = vim.keymap.set
      
      -- Navigation
      keymap('n', ']c', gs.next_hunk, { buffer = bufnr, desc = "Next git hunk" })
      keymap('n', '[c', gs.prev_hunk, { buffer = bufnr, desc = "Previous git hunk" })
      
      -- Actions
      keymap('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
      keymap('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
      keymap('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
      keymap('n', '<leader>hb', gs.blame_line, { buffer = bufnr, desc = "Blame line" })
    end,
  },
}
