-- ~\AppData\Local\nvim\lua\myconfig\lazy.lua
-- =============================================================================
-- LAZY.NVIM PLUGIN MANAGER SETUP (UPDATED)
-- =============================================================================
-- Added: New plugin imports for lualine, bufferline, flash, surround, indent
-- =============================================================================
-- =============================================================================
-- STEP 1: Bootstrap lazy.nvim
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({"git", "clone", "--filter=blob:none",
                   "https://github.com/folke/lazy.nvim.git", "--branch=stable",
                   lazypath})
    print("lazy.nvim installed! Please restart Neovim.")
end

vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- STEP 2: Configure lazy.nvim
-- =============================================================================

require("lazy").setup(
    { -- ==========================================================================
    -- EXISTING PLUGINS (Updated)
    -- ==========================================================================
    {
        import = "myconfig.plugins.colorscheme"
    }, -- Theme
    {
        import = "myconfig.plugins.telescope"
    }, -- ✓ UPDATED: Added fzf-native
    {
        import = "myconfig.plugins.treesitter"
    }, -- ✓ UPDATED: Added autotag, context, rainbow
    {
        import = "myconfig.plugins.lsp"
    }, -- LSP setup
    {
        import = "myconfig.plugins.completion"
    }, -- ✓ UPDATED: Added ghost text, borders
    {
        import = "myconfig.plugins.oil"
    }, -- ✓ UPDATED: Added git, columns
    {
        import = "myconfig.plugins.harpoon"
    }, -- Quick file navigation
    {
        import = "myconfig.plugins.undotree"
    }, -- Undo history visualizer
    {
        import = "myconfig.plugins.fugitive"
    }, -- Git integration
    {
        import = "myconfig.plugins.gitsigns"
    }, -- Git decorations
    {
        import = "myconfig.plugins.comment"
    }, -- Smart commenting
    {
        import = "myconfig.plugins.autopairs"
    }, -- Auto-close brackets
    {
        import = "myconfig.plugins.whichkey"
    }, -- ✓ UPDATED: Modern spec format
    {
        import = "myconfig.plugins.dap"
    }, -- Debug Adapter Protocol
    -- ==========================================================================
    -- NEW PLUGINS
    -- ==========================================================================
    {
        import = "myconfig.plugins.lualine"
    }, -- ✨ NEW: Statusline
    {
        import = "myconfig.plugins.bufferline"
    }, -- ✨ NEW: Buffer tabs
    {
        import = "myconfig.plugins.flash"
    }, -- ✨ NEW: Enhanced navigation
    {
        import = "myconfig.plugins.surround"
    }, -- ✨ NEW: Surround text objects
    {
        import = "myconfig.plugins.indent-blankline"
    } -- ✨ NEW: Indent guides
    }, {
        -- ==========================================================================
        -- LAZY.NVIM OPTIONS
        -- ==========================================================================
        ui = {
            border = "rounded",
            icons = {
                cmd = "⌘",
                config = "🛠",
                event = "📅",
                ft = "📂",
                init = "⚙",
                keys = "🗝",
                plugin = "🔌",
                runtime = "💻",
                source = "📄",
                start = "🚀",
                task = "📌",
                lazy = "💤 "
            }
        },

        rocks = {
            enabled = false
        },

        performance = {
            rtp = {
                disabled_plugins = {"gzip", "matchit", "matchparen",
                                    "netrwPlugin", "tarPlugin", "tohtml",
                                    "tutor", "zipPlugin"}
            }
        },

        checker = {
            enabled = true,
            notify = false
        },

        change_detection = {
            enabled = true,
            notify = false
        }
    })

-- =============================================================================
-- LAZY.NVIM KEYBINDINGS
-- =============================================================================
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", {
    desc = "Open Lazy plugin manager"
})

-- =============================================================================
-- SUMMARY OF UPDATES
-- =============================================================================
-- Updated plugins (with new features):
-- ✓ telescope.lua      - Added fzf-native for 6x performance boost
-- ✓ treesitter.lua     - Added autotag, context, rainbow delimiters, folding
-- ✓ completion.lua     - Added ghost text, rounded borders, custom snippets
-- ✓ whichkey.lua       - Updated to modern spec format with icons
-- ✓ oil.lua            - Added git integration, size/mtime columns
-- ✓ options.lua        - Added treesitter folding configuration
--
-- New plugins added:
-- ✨ lualine.lua        - Beautiful statusline with mode, git, LSP, diagnostics
-- ✨ bufferline.lua     - Browser-style buffer tabs at top
-- ✨ flash.lua          - Enhanced jump navigation (better than f/t)
-- ✨ surround.lua       - Add/change/delete surrounding pairs
-- ✨ indent-blankline   - Visual indent guides
--
-- Installation:
-- 1. Save all plugin files to lua/myconfig/plugins/
-- 2. Restart Neovim
-- 3. Run :Lazy sync
-- 4. Enjoy your enhanced setup! 🎉
-- =============================================================================
