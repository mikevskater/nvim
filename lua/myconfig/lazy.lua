-- ~\AppData\Local\nvim\lua\myconfig\lazy.lua
-- =============================================================================
-- LAZY.NVIM PLUGIN MANAGER SETUP (UPDATED with Database Support)
-- =============================================================================
-- Added: Database plugins (vim-dadbod suite)
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
    -- EXISTING PLUGINS
    -- ==========================================================================
    {
        import = "myconfig.plugins.colorscheme"
    }, {
        import = "myconfig.plugins.telescope"
    }, {
        import = "myconfig.plugins.treesitter"
    }, {
        import = "myconfig.plugins.lsp"
    }, {
        import = "myconfig.plugins.completion"
    }, {
        import = "myconfig.plugins.oil"
    }, {
        import = "myconfig.plugins.harpoon"
    }, {
        import = "myconfig.plugins.undotree"
    }, {
        import = "myconfig.plugins.fugitive"
    }, {
        import = "myconfig.plugins.gitsigns"
    }, {
        import = "myconfig.plugins.comment"
    }, {
        import = "myconfig.plugins.whichkey"
    }, {
        import = "myconfig.plugins.dap"
    }, {
        import = "myconfig.plugins.lualine"
    }, {
        import = "myconfig.plugins.bufferline"
    }, {
        import = "myconfig.plugins.flash"
    }, {
        import = "myconfig.plugins.surround"
    }, {
        import = "myconfig.plugins.indent-blankline"
    }, 
    --{import = "myconfig.plugins.database"},
    {
        import = "myconfig.plugins.plenary"
    }, {
        import = "myconfig.plugins.sheet_todo"
    }, {
        import = "myconfig.plugins.nvim-float"
    }, {
		import = "myconfig.plugins.nvim-colorpicker"
	},{
        import = "myconfig.plugins.nvim-favdir"
    }

	}, {
        -- ==========================================================================
        -- LAZY.NVIM OPTIONS
        -- ==========================================================================
        ui = {
            border = "rounded",
            icons = {
                cmd = "\u{f120} ", -- fa-terminal
                config = "\u{f013} ", -- fa-cog/gear
                event = "\u{f0e7} ", -- fa-bolt
                ft = "\u{f016} ", -- fa-file-o
                init = "\u{f013} ", -- fa-cog
                keys = "\u{f084} ", -- fa-key
                plugin = "\u{f1e6} ", -- fa-plug
                runtime = "\u{f085} ", -- fa-cogs
                require = "\u{f1c9} ", -- fa-file-code-o
                source = "\u{f121} ", -- fa-code
                start = "\u{f135} ", -- fa-rocket
                task = "\u{f058} ", -- fa-check-circle
                lazy = "\u{f186} " -- fa-moon-o
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
    desc = "\u{eb29} Open Lazy plugin manager"
})

-- =============================================================================
-- SUMMARY OF DATABASE ADDITIONS
-- =============================================================================
-- New plugins added:
-- âœ¨ vim-dadbod          - Core database interface
-- âœ¨ vim-dadbod-ui       - Database UI (browse, execute queries)
-- âœ¨ vim-dadbod-completion - SQL completion for blink.cmp
-- âœ¨ sql-lsp (optional)  - SQL LSP server (disabled by default)
--
-- Updated plugins:
-- âœ" completion.lua     - Added SQL completion source
--
-- Supported Databases:
-- âœ" MSSQL / SQL Server  - via sqlcmd
-- âœ" MySQL               - via mysql client
-- âœ" Azure SQL Database  - via sqlcmd
-- âœ" BigQuery            - via bq CLI
-- âœ" PostgreSQL          - via psql (bonus!)
-- âœ" SQLite              - via sqlite3 (bonus!)
--
-- Quick Start:
-- 1. Install CLI tools (sqlcmd, mysql, bq)
-- 2. Restart Neovim
-- 3. Press <leader>db to open Database UI
-- 4. Add connection with :DBUIAddConnection
-- 5. Start querying!
--
-- Example Connection URLs:
-- MSSQL:    sqlserver://user:pass@localhost:1433/dbname
-- MySQL:    mysql://root:pass@localhost:3306/dbname
-- BigQuery: bigquery:project-id:dataset-id
-- Azure:    sqlserver://user:pass@server.database.windows.net:1433/db
-- =============================================================================

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
-- ✨ plenary.lua        - Testing framework & utility library for Neovim
--
-- Test keybindings (plenary):
-- <leader>tt - Run tests in current file
-- <leader>ta - Run all tests in test/ directory
-- <leader>ts - Run SSNS QueryParser tests (plenary)
-- <leader>tm - Run SSNS manual tests (standalone)
--
-- Installation:
-- 1. Save all plugin files to lua/myconfig/plugins/
-- 2. Restart Neovim
-- 3. Run :Lazy sync
-- 4. Enjoy your enhanced setup! 🎉
-- =============================================================================
