-- ~\AppData\Local\nvim\lua\myconfig\plugins\database.lua
-- =============================================================================
-- DATABASE PLUGINS - SSNS (SQL Server NeoVim Studio)
-- =============================================================================
-- Pure Lua database management plugin with SSMS-style UI
-- Supports: SQL Server (complete), MySQL (adapter ready), PostgreSQL (future)
-- Features: Class-based architecture, real connections, lazy loading
-- =============================================================================
return {
    -- ==========================================================================
    -- SSNS - PURE LUA DATABASE UI
    -- ==========================================================================
    {
        name = "ssns",
        --dir = "E:\\nvim\\plugin_dev\\ssns",
        "mikevskater/ssns",
        dependencies = {
            {"mikevskater/nvim-xlsx", lazy = true},
            {"mikevskater/nvim-float", lazy = true},
            {"mikevskater/nvim-colorpicker", lazy = true},
        },
        -- Load immediately (not lazy) for remote plugin registration
        lazy = true,

        -- Auto-register remote plugin on install/update
        build = ":UpdateRemotePlugins",

        cmd = {
            "SSNS",
            "SSNSOpen",
            "SSNSClose",
            "SSNSConnect",
            "SSNSRefresh",
            "SSNSStats",
            "SSNSDebug"
        },
        
        opts = {
            completion = {
                debug = false,
            },
            ui = {
                position = "float",  -- "left", "right", "float"
                --width = 45,
                ssms_style = true,
                show_schema_prefix = true,

                -- Result set divider configuration
                -- Format: supports repeat patterns (N<char>), raw strings, variables, and auto-width
                -- Repeat: "20#" = 20 hashes, "10-" = 10 dashes
                -- Auto-width: "%fit%" = matches longest line width
                -- Multi-line: use \n (newline character, e.g., "20#\n20#\n20#")
                -- Variables: %row_count%, %col_count%, %run_time%, %result_set_num%, %total_result_sets%, %date%, %time%, %fit%
                -- Examples:
                --   "5-(%row_count% rows)5-" → "-----(11 rows)-----"
                --   "%fit%=\n---- Result Set %result_set_num% (%row_count% rows, %run_time%) ----\n%fit%="
                --     → auto-sizes "=" to match the middle line width
                --   "Query executed at %time% on %date% - %row_count% rows returned"
                result_set_divider = "%fit%=\n---- Result Set %result_set_num% (%row_count% rows, %run_time%) ----\n%fit%=",
                show_result_set_info = true,  -- Show divider/info before first result set and single result sets
            },

            cache = {
                ttl = 300,  -- 5 minutes
            },
        },

        keys = {
            -- ==========================================================================
            -- SSNS KEYMAPS
            -- ==========================================================================
            {
                "<leader>qb",
                "<cmd>SSNS<cr>",
                desc = " Toggle SSNS Database UI"
            },
            {
                "<leader>qf",
                "<cmd>SSNSFloat<cr>",
                desc = " Toggle SSNS Database UI"
            },
            {
                "<leader>qr",
                "<cmd>SSNSRefresh<cr>",
                desc = " Refresh All Servers"
            },
            {
                "<leader>qs",
                "<cmd>SSNSStats<cr>",
                desc = " Show SSNS Statistics"
            },
        }
    },
}
-- =============================================================================
-- SSNS USAGE GUIDE
-- =============================================================================
-- Getting Started:
-- 1. Ensure vim-dadbod is installed
-- 2. Configure connections in setup() above
-- 3. Open SSNS with <leader>qb
--
-- Global Keymaps (<leader>q prefix):
-- <leader>qb - Toggle SSNS UI
-- <leader>qr - Refresh all servers
-- <leader>qs - Show cache statistics
--
-- SSNS Tree Navigation (in SSNS buffer):
-- <CR> / o   - Expand/collapse node or execute action
-- q          - Close SSNS window
-- r          - Refresh current node
-- R          - Refresh all servers
-- d          - Toggle server/database connection
-- ?          - Show help
--
-- Available Commands:
-- :SSNS                    - Toggle SSNS window
-- :SSNSOpen                - Open SSNS window
-- :SSNSClose               - Close SSNS window
-- :SSNSConnect <name>      - Connect to a configured server
-- :SSNSRefresh             - Refresh all servers
-- :SSNSStats               - Show cache statistics
-- :SSNSDebug               - Print cache contents
--
-- Connection String Formats:
--
-- SQL Server:
--   Server-level (browse all databases):
--     sqlserver://.\\SQLEXPRESS/master
--     sqlserver://localhost\\INSTANCE/database
--     sqlserver://server/database
--
--   With authentication:
--     sqlserver://user:pass@server/database
--     sqlserver://user:pass@server\\INSTANCE/database
--
-- MySQL:
--   mysql://username:password@localhost:3306/database
--   mysql://root:password@localhost:3306/mysql
--
-- Tree Structure:
-- ▸ Server Name ✓           (✓ = connected, ✗ = error)
--   ▸ Database Name ✓        (✓ = active database)
--     ▸ Schema Name
--       ▸ TABLES (10)
--         ▸ [schema].[TableName]
--             SELECT           (generates SELECT query)
--           ▸ Columns
--               ColumnName | type | NULL/NOT NULL | PK/FK
--           ▸ Indexes
--           ▸ Keys
--             DROP             (generates DROP with confirmation)
--       ▸ VIEWS (5)
--       ▸ PROCEDURES (3)
--       ▸ FUNCTIONS (2)
--
-- Features:
-- - Real-time database connections via vim-dadbod
-- - SSMS-style hierarchical navigation
-- - Lazy loading (columns/indexes load on expand)
-- - Connection pooling
-- - SQL generation (SELECT, INSERT, DROP, EXEC)
-- - Expand/collapse with ▸ ▾ indicators
-- - Connection status with ✓ ✗ icons
-- - Schema-prefixed names: [dbo].[TableName]
-- - View definitions, procedure parameters
-- - Foreign key detection
-- - Primary key detection
--
-- Tips:
-- 1. Connect to 'master' database to see all databases on SQL Server
-- 2. Expand server → database → schema → tables to browse structure
-- 3. Press <CR> on "SELECT" action to generate SQL
-- 4. Press 'r' on a node to refresh from database
-- 5. Press 'd' on server to connect/disconnect
-- 6. All data loads lazily - only fetches when you expand
--
-- Troubleshooting:
-- - Commands not found: Restart Neovim after installing
-- - Connection fails: Ensure server is running and connection string is correct
-- - No tables showing: Make sure database is connected (✓ icon)
-- - vim-dadbod not found: Ensure vim-dadbod plugin is installed
-- =============================================================================
