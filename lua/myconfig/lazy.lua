-- ~\AppData\Local\nvim\lua\myconfig\lazy.lua
-- =============================================================================
-- LAZY.NVIM PLUGIN MANAGER SETUP
-- =============================================================================
-- Lazy.nvim is the modern, fast plugin manager for Neovim
-- It automatically lazy-loads plugins for better startup time
-- https://github.com/folke/lazy.nvim
-- =============================================================================
-- =============================================================================
-- STEP 1: Bootstrap lazy.nvim
-- =============================================================================
-- This automatically installs lazy.nvim if it's not already installed
-- This is the "one-time setup" that happens on first run
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
if not vim.loop.fs_stat(lazypath) then
    -- If not, clone it from GitHub
    print("Installing lazy.nvim...")
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", -- Don't download unnecessary git history
         "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- Use stable release
         lazypath})
    print("lazy.nvim installed! Please restart Neovim.")
end

-- Add lazy.nvim to runtime path so Neovim can find it
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- STEP 2: Configure lazy.nvim
-- =============================================================================

require("lazy").setup(
    { -- ==========================================================================
    -- PLUGIN SPECIFICATIONS
    -- ==========================================================================
    -- There are two ways to specify plugins:
    --
    -- 1. Direct specification (simple plugins):
    --    { "username/repo" }
    --
    -- 2. Import from separate files (complex plugins):
    --    { import = "myconfig.plugins.telescope" }
    --
    -- We use method #2 for ALL plugins to keep this file clean and modular
    -- Each plugin gets its own file in lua/myconfig/plugins/
    -- ==========================================================================
    -- Import all plugin configurations from lua/myconfig/plugins/
    -- Each file in that directory should return a plugin specification
    {
        import = "myconfig.plugins.colorscheme"
    }, -- Theme
    {
        import = "myconfig.plugins.telescope"
    }, -- Fuzzy finder
    {
        import = "myconfig.plugins.treesitter"
    }, -- Syntax highlighting
    {
        import = "myconfig.plugins.lsp"
    }, -- LSP setup
    {
        import = "myconfig.plugins.completion"
    }, -- Auto-completion
    {
        import = "myconfig.plugins.oil"
    }, -- File explorer
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
    }, -- Keybinding helper
    {
        import = "myconfig.plugins.dap"
    } -- Debug Adapter Protocol
    -- Add more plugins here by creating new files in plugins/ directory
    -- Example: { import = "myconfig.plugins.copilot" },
    }, {
        -- ==========================================================================
        -- LAZY.NVIM OPTIONS
        -- ==========================================================================
        -- These control how lazy.nvim itself behaves

        -- UI settings
        ui = {
            -- Use rounded borders for plugin manager window
            border = "rounded",
            -- Icons for plugin states (requires Nerd Font)
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
            enabled = false -- Don't use luarocks
        },

        -- Performance settings
        performance = {
            rtp = {
                -- Disable some rtp plugins you don't use
                disabled_plugins = {"gzip", "matchit", "matchparen",
                                    "netrwPlugin", -- We're using oil.nvim instead
                                    "tarPlugin", "tohtml", "tutor", "zipPlugin"}
            }
        },

        -- Check for plugin updates on startup (can be slow, disable if needed)
        checker = {
            enabled = true,
            notify = false -- Don't notify about updates (check manually with :Lazy)
        },

        -- Automatically check for config changes and reload
        change_detection = {
            enabled = true,
            notify = false -- Don't notify about config changes
        }
    })

-- =============================================================================
-- LAZY.NVIM KEYBINDINGS
-- =============================================================================
-- Open the lazy.nvim UI to manage plugins

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", {
    desc = "Open Lazy plugin manager"
})

-- =============================================================================
-- USEFUL LAZY.NVIM COMMANDS
-- =============================================================================
-- :Lazy            - Open the lazy.nvim UI
-- :Lazy sync       - Install missing plugins and update existing ones
-- :Lazy clean      - Remove unused plugins
-- :Lazy update     - Update all plugins
-- :Lazy restore    - Restore plugins to lockfile state
-- :Lazy profile    - Show startup profiling
-- :Lazy log        - Show recent updates
-- =============================================================================

-- =============================================================================
-- HOW TO ADD A NEW PLUGIN
-- =============================================================================
-- 1. Create a new file: lua/myconfig/plugins/yourplugin.lua
-- 2. In that file, return a plugin specification (see existing plugins for examples)
-- 3. Add: { import = "myconfig.plugins.yourplugin" } to the list above
-- 4. Restart Neovim or run :Lazy sync
-- =============================================================================
