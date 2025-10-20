-- ~\AppData\Local\nvim\lua\myconfig\plugins\database.lua
-- =============================================================================
-- DATABASE PLUGINS - SQL IDE Setup (Enhanced with Phase 2)
-- =============================================================================
-- Turns Neovim into a SQL database IDE similar to SSMS
-- Supports: MSSQL, MySQL, Azure DB, BigQuery
-- New Features: Database-level navigation, stored procedures, functions, views
-- =============================================================================
return {
    -- ==========================================================================
    -- CORE DATABASE INTERFACE
    -- ==========================================================================
    {
        "mikevskater/vim-dadbod",
        lazy = true
    },

    -- ==========================================================================
    -- DATABASE UI
    -- ==========================================================================
    {
        "mikevskater/vim-dadbod-ui",
        dependencies = {
            {
                "mikevskater/vim-dadbod",
                lazy = true
            },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = {"sql", "mysql", "plsql"},
                lazy = true
            }
        },

        cmd = {"DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer"},

        init = function()
            -- ==========================================================================
            -- UI CONFIGURATION
            -- ==========================================================================
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40
            vim.g.db_ui_use_nvim_notify = true
            vim.g.db_ui_execute_on_save = false
            vim.g.db_ui_auto_execute_table_helpers = 1

            -- Enable SSMS-style mode (server-level connections with database navigation)
            vim.g.db_ui_use_ssms_style = 1

            local data_path = vim.fn.stdpath("data")
            vim.g.db_ui_save_location = data_path .. "/dadbod_ui"

            -- ==========================================================================
            -- SSMS-STYLE CONFIGURATION
            -- ==========================================================================

            -- Show schema prefix in object names [schema].[object]
            vim.g.db_ui_show_schema_prefix = 1

            -- Control which structural groups to show for tables
            vim.g.db_ui_ssms_show_columns = 1
            vim.g.db_ui_ssms_show_indexes = 1
            vim.g.db_ui_ssms_show_keys = 1
            vim.g.db_ui_ssms_show_constraints = 1
            vim.g.db_ui_ssms_show_dependencies = 1

            -- Hide specific schemas from object lists
            vim.g.db_ui_hide_schemas = {'sys', 'INFORMATION_SCHEMA'}

            -- ==========================================================================
            -- PERFORMANCE OPTIMIZATION
            -- ==========================================================================

            -- Enable query result caching
            vim.g.db_ui_cache_enabled = 1

            -- Cache TTL in seconds (default: 5 minutes)
            vim.g.db_ui_cache_ttl = 300

            -- Pagination threshold (0 = disabled, >0 = paginate when exceeded)
            vim.g.db_ui_max_items_per_page = 500

            -- Show loading indicator for slow queries
            vim.g.db_ui_show_loading_indicator = 1

            -- ==========================================================================
            -- FILTER SYSTEM
            -- ==========================================================================

            -- Case-insensitive filtering by default
            vim.g.db_ui_filter_case_sensitive = 0

            -- Enable regex pattern support in filters
            vim.g.db_ui_filter_use_regex = 1

            -- Filter indicator icon
            vim.g.db_ui_filter_icon = '🔍'

            -- ==========================================================================
            -- ICONS (Extended for Phase 2)
            -- ==========================================================================
            vim.g.db_ui_icons = {
                expanded = {
                    db = "▾ \u{f1c0}",              -- ▾  (database)
                    buffers = "▾ \u{f0c5}",         -- ▾  (files)
                    saved_queries = "▾ \u{f0f6}",   -- ▾  (file-text)
                    schemas = "▾ \u{f1c0}",         -- ▾  (database)
                    schema = "▾ \u{e5ff}",          -- ▾  (folder)
                    tables = "▾ \u{f0ce}",          -- ▾  (table)
                    table = "▾ \u{f0ce}",           -- ▾  (table)
                    
                    -- Phase 2: New object types
                    database = "▾ \u{f1c0}",        -- ▾  (single database)
                    databases = "▾ \u{f1c0}",       -- ▾  (database list)
                    views = "▾ \u{f06e}",           -- ▾  (eye/view)
                    view = "▾ \u{f06e}",            -- ▾  (eye/view)
                    procedures = "▾ \u{f013}",      -- ▾  (cog/procedure)
                    procedure = "▾ \u{f013}",       -- ▾  (cog/procedure)
                    functions = "▾ \u{0192}",       -- ▾ ƒ (function)
                    ['function'] = "▾ \u{0192}",    -- ▾ ƒ (function) - escaped keyword
                    types = "▾ \u{f1c0}",           -- ▾  (type)
                    type = "▾ \u{f1c0}",            -- ▾  (type)
                    synonyms = "▾ \u{f0c1}",        -- ▾  (link)
                    synonym = "▾ \u{f0c1}"          -- ▾  (link)
                },
                collapsed = {
                    db = "▸ \u{f1c0}",              -- ▸ 
                    buffers = "▸ \u{f0c5}",         -- ▸ 
                    saved_queries = "▸ \u{f0f6}",   -- ▸ 
                    schemas = "▸ \u{f1c0}",         -- ▸ 
                    schema = "▸ \u{e5ff}",          -- ▸ 
                    tables = "▸ \u{f0ce}",          -- ▸ 
                    table = "▸ \u{f0ce}",           -- ▸ 
                    
                    -- Phase 2: New object types
                    database = "▸ \u{f1c0}",        -- ▸ 
                    databases = "▸ \u{f1c0}",       -- ▸ 
                    views = "▸ \u{f06e}",           -- ▸ 
                    view = "▸ \u{f06e}",            -- ▸ 
                    procedures = "▸ \u{f013}",      -- ▸ 
                    procedure = "▸ \u{f013}",       -- ▸ 
                    functions = "▸ \u{0192}",       -- ▸ ƒ
                    ['function'] = "▸ \u{0192}",    -- ▸ ƒ - escaped keyword
                    types = "▸ \u{f1c0}",           -- ▸ 
                    type = "▸ \u{f1c0}",            -- ▸ 
                    synonyms = "▸ \u{f0c1}",        -- ▸ 
                    synonym = "▸ \u{f0c1}"          -- ▸ 
                },
                saved_query = "\u{f0f6}",           --  (file-text)
                new_query = "\u{f067}",             --  (plus)
                tables = "\u{f0ce}",                --  (table)
                buffers = "\u{f0c5}",               --  (files)
                add_connection = "\u{f067}",        --  (plus)
                connection_ok = "\u{2713}",         -- ✓ (checkmark)
                connection_error = "\u{2715}",      -- ✕ (X)
                
                -- Phase 2: New static icons
                database = "\u{f1c0}",              --  (database)
                databases = "\u{f1c0}",             --  (databases)
                views = "\u{f06e}",                 --  (eye/view)
                procedures = "\u{f013}",            --  (cog/procedure)
                functions = "\u{0192}",             -- ƒ (function symbol)
                types = "\u{f1c0}",                 --  (type)
                synonyms = "\u{f0c1}",              --  (link)
                action = "\u{f0a4}"                 --  (arrow/action)
            }

            -- ==========================================================================
            -- TABLE HELPERS (Extended for Phase 2)
            -- ==========================================================================
            vim.g.db_ui_table_helpers = {
                sqlserver = {
                    Count = "SELECT COUNT(*) FROM {optional_schema}{table}",
                    Top100 = "SELECT TOP 100 * FROM {optional_schema}{table}",
                    
                    -- Existing detailed queries
                    Columns = [[
                        SELECT 
                            COLUMN_NAME,
                            DATA_TYPE,
                            CHARACTER_MAXIMUM_LENGTH,
                            IS_NULLABLE
                        FROM INFORMATION_SCHEMA.COLUMNS 
                        WHERE TABLE_SCHEMA = '{schema}'
                          AND TABLE_NAME = '{table}'
                        ORDER BY ORDINAL_POSITION
                    ]],
                    
                    Indexes = [[
                        SELECT 
                            i.name AS IndexName,
                            i.type_desc AS IndexType,
                            COL_NAME(ic.object_id, ic.column_id) AS ColumnName,
                            ic.is_included_column AS IsIncluded
                        FROM sys.indexes i
                        INNER JOIN sys.index_columns ic 
                            ON i.object_id = ic.object_id 
                            AND i.index_id = ic.index_id
                        WHERE i.object_id = OBJECT_ID('{schema}.{table}')
                        ORDER BY i.name, ic.key_ordinal
                    ]],
                    
                    -- Phase 2: Additional helpers
                    ["Foreign Keys"] = [[
                        SELECT 
                            fk.name AS ForeignKeyName,
                            OBJECT_NAME(fk.parent_object_id) AS TableName,
                            COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ColumnName,
                            OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ReferencedSchema,
                            OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
                            COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ReferencedColumn
                        FROM sys.foreign_keys AS fk
                        INNER JOIN sys.foreign_key_columns AS fkc 
                            ON fk.object_id = fkc.constraint_object_id
                        WHERE fk.parent_object_id = OBJECT_ID('{schema}.{table}')
                    ]],
                    
                    ["Primary Key"] = [[
                        SELECT 
                            i.name AS PrimaryKeyName,
                            COL_NAME(ic.object_id, ic.column_id) AS ColumnName
                        FROM sys.indexes i
                        INNER JOIN sys.index_columns ic 
                            ON i.object_id = ic.object_id 
                            AND i.index_id = ic.index_id
                        WHERE i.is_primary_key = 1
                          AND i.object_id = OBJECT_ID('{schema}.{table}')
                    ]],
                    
                    ["Row Count"] = [[
                        SELECT 
                            SUM(p.rows) AS RowCount
                        FROM sys.partitions p
                        WHERE p.object_id = OBJECT_ID('{schema}.{table}')
                          AND p.index_id IN (0, 1)
                    ]]
                },
                
                mysql = {
                    Count = "SELECT COUNT(*) FROM {optional_schema}{table}",
                    Describe = "DESCRIBE {optional_schema}{table}",
                    Indexes = "SHOW INDEXES FROM {optional_schema}{table}",
                    Limit100 = "SELECT * FROM {optional_schema}{table} LIMIT 100",
                    
                    -- Phase 2: Additional helpers
                    ["Foreign Keys"] = [[
                        SELECT 
                            CONSTRAINT_NAME,
                            COLUMN_NAME,
                            REFERENCED_TABLE_SCHEMA,
                            REFERENCED_TABLE_NAME,
                            REFERENCED_COLUMN_NAME
                        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE TABLE_SCHEMA = '{schema}'
                          AND TABLE_NAME = '{table}'
                          AND REFERENCED_TABLE_NAME IS NOT NULL
                    ]],
                    
                    ["Table Status"] = "SHOW TABLE STATUS LIKE '{table}'"
                },
                
                bigquery = {
                    Count = "SELECT COUNT(*) FROM `{table}`",
                    Schema = "SELECT * FROM `{table}` LIMIT 0",
                    Sample = "SELECT * FROM `{table}` LIMIT 100"
                }
            }
        end,

        keys = {
            -- ==========================================================================
            -- DATABASE UI COMMANDS
            -- ==========================================================================
            {
                "<leader>qb",
                "<cmd>DBUIToggle<cr>",
                desc = "\u{f1c0} Toggle Database UI"
            },
            {
                "<leader>qa",
                "<cmd>DBUIAddConnection<cr>",
                desc = "\u{f067} Add Database Connection"
            },
            {
                "<leader>qf",
                "<cmd>DBUIFindBuffer<cr>",
                desc = "\u{f002} Find Database Buffer"
            },
            {
                "<leader>qr",
                "<cmd>DBUIRenameBuffer<cr>",
                desc = "\u{f040} Rename Database Buffer"
            },
            {
                "<leader>ql",
                "<cmd>DBUILastQueryInfo<cr>",
                desc = "\u{f05a} Last Query Info"
            }
        }
    },

    -- ==========================================================================
    -- SQL COMPLETION
    -- ==========================================================================
    {
        "kristijanhusak/vim-dadbod-completion",
        ft = {"sql", "mysql", "plsql"},
        lazy = true,

        init = function()
            -- ==========================================================================
            -- SQL FILETYPE KEYMAPS (Query Editing)
            -- ==========================================================================
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"sql", "mysql", "plsql"},
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = {buffer = true, silent = true}

                    -- Query Execution
                    keymap("n", "<leader>qw", "<Plug>(DBUI_SaveQuery)",
                        vim.tbl_extend("force", opts, {desc = "\u{f0c7} Save Query"}))
                    keymap("n", "<leader>qe", "<Plug>(DBUI_EditBindParameters)",
                        vim.tbl_extend("force", opts, {desc = "\u{f040} Edit Bind Parameters"}))
                    keymap("n", "<leader>qx", "<Plug>(DBUI_ExecuteQuery)",
                        vim.tbl_extend("force", opts, {desc = "\u{f04b} Execute Query"}))
                    keymap("v", "<leader>qx", "<Plug>(DBUI_ExecuteQuery)",
                        vim.tbl_extend("force", opts, {desc = "\u{f04b} Execute Selected Query"}))

                    -- Navigation & Selection
                    keymap("n", "<leader>qv", "<Plug>(DBUI_SelectLineVsplit)",
                        vim.tbl_extend("force", opts, {desc = "\u{f338} Open in Vertical Split"}))
                    keymap("n", "<leader>qj", "<Plug>(DBUI_JumpToForeignKey)",
                        vim.tbl_extend("force", opts, {desc = "\u{f0c1} Jump to Foreign Key"}))
                end
            })

            -- ==========================================================================
            -- DBUI DRAWER KEYMAPS (Navigation)
            -- ==========================================================================
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbui",
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = {buffer = true, silent = true}

                    -- Core navigation
                    keymap("n", "o", "<Plug>(DBUI_SelectLine)",
                        vim.tbl_extend("force", opts, {desc = "\u{f0c1} Open/Toggle"}))
                    keymap("n", "S", "<Plug>(DBUI_SelectLineVsplit)",
                        vim.tbl_extend("force", opts, {desc = "\u{f338} Open in Vertical Split"}))
                    keymap("n", "R", "<Plug>(DBUI_Redraw)",
                        vim.tbl_extend("force", opts, {desc = "\u{f021} Redraw"}))
                    keymap("n", "d", "<Plug>(DBUI_DeleteLine)",
                        vim.tbl_extend("force", opts, {desc = "\u{f1f8} Delete"}))
                    keymap("n", "A", "<Plug>(DBUI_AddConnection)",
                        vim.tbl_extend("force", opts, {desc = "\u{f067} Add Connection"}))
                    keymap("n", "H", "<Plug>(DBUI_ToggleDetails)",
                        vim.tbl_extend("force", opts, {desc = "\u{f05a} Toggle Details"}))

                    -- Filter system keymaps
                    keymap("n", "f", "<Plug>(DBUI_ApplyFilter)",
                        vim.tbl_extend("force", opts, {desc = "🔍 Apply/Edit Filter"}))
                    keymap("n", "F", "<Plug>(DBUI_ClearFilter)",
                        vim.tbl_extend("force", opts, {desc = "❌ Clear Current Filter"}))
                    keymap("n", "<leader>qc", "<Plug>(DBUI_ClearAllFilters)",
                        vim.tbl_extend("force", opts, {desc = "🗑️ Clear All Filters"}))
                    keymap("n", "<leader>qs", "<Plug>(DBUI_ShowFilters)",
                        vim.tbl_extend("force", opts, {desc = "📋 Show Active Filters"}))
                end
            })

            -- ==========================================================================
            -- DBOUT BUFFER KEYMAPS (Result Window)
            -- ==========================================================================
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = {buffer = true, silent = true}

                    keymap("n", "R", ":DB<CR>",
                        vim.tbl_extend("force", opts, {desc = "\u{f021} Rerun Query"}))
                    keymap("n", "gq", ":bdelete<CR>",
                        vim.tbl_extend("force", opts, {desc = "\u{f2d1} Close Results"}))
                end
            })
        end
    }
}
-- =============================================================================
-- DADBOD USAGE GUIDE (SSMS-Style with Filtering)
-- =============================================================================
-- Getting Started:
-- 1. Install required CLI tools (sqlcmd, mysql, bq)
-- 2. Add connections via :DBUIAddConnection or <leader>qa
-- 3. Open DBUI with <leader>qb
--
-- Global Keymaps (<leader>q prefix):
-- <leader>qb - Toggle Database UI drawer
-- <leader>qa - Add new database connection
-- <leader>qf - Find database buffer
-- <leader>qr - Rename database buffer
-- <leader>ql - Show last query info
-- <leader>qw - Save query permanently
-- <leader>qe - Edit bind parameters
-- <leader>qx - Execute query (normal or visual)
-- <leader>qv - Open in vertical split
-- <leader>qj - Jump to foreign key
-- <leader>qc - Clear all filters (in DBUI drawer)
-- <leader>qs - Show active filters (in DBUI drawer)
--
-- DBUI Drawer Navigation (buffer-local):
-- o / <CR>   - Open/Toggle database, schema, or table
-- S          - Open in vertical split
-- R          - Redraw UI
-- A          - Add connection
-- d          - Delete connection/query
-- H          - Toggle database details
-- ?          - Toggle help
--
-- DBUI Filter System (NEW! - buffer-local):
-- f          - Apply/edit filter on current item (TABLES, VIEWS, Columns, etc.)
-- F          - Clear filter for current item
-- <leader>qc - Clear all active filters
-- <leader>qs - Show list of all active filters
--
-- Filter Usage Examples:
-- 1. Filter tables by schema:
--    - Navigate to TABLES group, press 'f'
--    - Select 's' for schema, enter pattern: dbo
--
-- 2. Filter tables by name:
--    - Navigate to TABLES group, press 'f'
--    - Select 'o' for object, enter pattern: Employee.*
--
-- 3. Filter both schema and name:
--    - Navigate to TABLES group, press 'f'
--    - Select 'b' for both, enter patterns
--
-- 4. Filter columns:
--    - Expand a table, navigate to Columns, press 'f'
--    - Enter pattern: .*ID (finds all ID columns)
--
-- Filter supports regex patterns:
-- - Employee.*     - Tables starting with "Employee"
-- - .*_view        - Tables ending with "_view"
-- - ^dbo\.         - Objects in dbo schema
-- - \d+           - Objects with numbers
--
-- Query Execution:
-- :w in query buffer  - Execute query and show results
-- <leader>qx (normal) - Execute entire query buffer
-- <leader>qx (visual) - Execute selected query
--
-- Results Window (dbout buffer):
-- R          - Rerun last query
-- gq         - Close results window
-- <C-c>      - Cancel running query
--
-- Connection URL Formats:
--
-- MSSQL (SQL Server):
--   Server-level (browse all databases):
--     sqlserver://server
--     sqlserver://.\SQLEXPRESS (local instance)
--
--   Database-specific:
--     sqlserver://server/database
--     sqlserver://username:password@server:port/database
--
-- Azure SQL:
--   sqlserver://username:password@yourserver.database.windows.net:1433/dbname
--
-- MySQL:
--   Server-level:
--     mysql://username:password@localhost:3306
--   Database-specific:
--     mysql://username:password@localhost:3306/database
--
-- BigQuery:
--   bigquery:project-id:dataset-id
--   bigquery:?project_id=proj&dataset_id=dataset
--
-- SSMS-Style Features:
-- - Server-level connections (browse all databases from one connection)
-- - Schema-prefixed object names: [dbo].[TableName]
-- - Expandable structural groups (Columns, Indexes, Keys, Constraints)
-- - Actions per object type (SELECT, ALTER, DROP, EXEC, DEPENDENCIES)
-- - Query caching with 5-minute TTL
-- - Pagination for large object lists (>500 items)
-- - Real-time filtering by schema, object name, or column name
--
-- Tips:
-- 1. Use server-level connections to browse multiple databases
-- 2. Filters work on cached data (no database queries)
-- 3. Multiple independent filters can coexist (tables vs views)
-- 4. Saved queries stored in ~/.local/share/db_ui/
-- 5. Use table helpers for quick queries
-- 6. Bind parameters with :param_name in queries, edit with <leader>qe
-- 7. For Azure AD auth, use go-sqlcmd instead of standard sqlcmd
--
-- Troubleshooting:
-- - No adapter found: Ensure CLI tools are installed and in PATH
-- - Connection fails: Test connection with CLI tool directly first
-- - MSSQL quotes issue: Set 'noshellslash' on Windows
-- - BigQuery: Ensure gcloud auth is configured
-- - Empty tables list: Check if using database-specific vs server-level connection
-- =============================================================================