-- ~\AppData\Local\nvim\lua\myconfig\plugins\colorscheme.lua
-- =============================================================================
-- COLORSCHEME - Rose Pine Theme
-- =============================================================================
-- Why Rose Pine? Clean, easy on the eyes, has dark/light variants
-- ThePrimeagen uses this one
-- Alternatives: tokyonight, catppuccin, gruvbox, onedark
-- =============================================================================

return {
  "rose-pine/neovim",
  name = "rose-pine",
  
  -- Load this plugin immediately (before other plugins)
  -- Colorschemes should load first to avoid flashing
  priority = 1000,
  
  -- Configuration function runs when plugin is loaded
  config = function()
    require("rose-pine").setup({
      -- Variant: "main" (default), "moon", "dawn" (light mode)
      variant = "main",
      
      -- Disable italics if you don't like them
      disable_italics = false,
      
      -- Make background transparent (shows terminal background)
      -- Uncomment if you want transparency
      -- disable_background = true,
      
      -- Custom colors and highlights
      highlight_groups = {
        -- Make the background transparent
        -- Uncomment these if you want a transparent background
        Normal = { bg = "none" },
        NormalFloat = { bg = "none" },
        
        -- Or customize specific highlight groups
        -- CursorLine = { bg = "#2a2837" },
      },
    })
    
    -- Apply the colorscheme
    vim.cmd("colorscheme rose-pine")
  end,
}

-- =============================================================================
-- COLORSCHEME NOTES
-- =============================================================================
-- To change colorscheme:
-- 1. Change the plugin spec above (e.g., "folke/tokyonight.nvim")
-- 2. Update the config function to use the new colorscheme
-- 3. Run :Lazy sync to install
-- 4. Restart Neovim
--
-- Popular alternatives:
-- - folke/tokyonight.nvim (modern, clean)
-- - catppuccin/nvim (pastel, many variants)
-- - ellisonleao/gruvbox.nvim (retro, warm)
-- - navarasu/onedark.nvim (VS Code style)
-- =============================================================================
