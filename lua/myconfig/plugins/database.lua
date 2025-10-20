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
			vim.g.db_ui_use_ssms_style = 1

            local data_path = vim.fn.stdpath("data")
            vim.g.db_ui_save_location = data_path .. "/dadbod_ui"

            -- ==========================================================================
            -- PHASE 2: DATABASE-LEVEL BROWSING
            -- ==========================================================================
            
            -- Enable multi-database navigation (browse all databases from one connection)
            vim.g.db_ui_show_database_level = 1
            
            -- Hide system databases from the database list
            vim.g.db_ui_ignored_databases = {
                sqlserver = {'master', 'tempdb', 'model', 'msdb'},
                mysql = {'information_schema', 'mysql', 'performance_schema', 'sys'}
            }
            
            -- ==========================================================================
            -- PHASE 2: SYSTEM OBJECTS
            -- ==========================================================================
            
            -- Hide system stored procedures, views, etc. (set to 1 to show them)
            vim.g.db_ui_show_system_objects = 0
            
            -- Prefix for system objects when shown
            vim.g.db_ui_system_object_prefix = "[SYS] "
            
            -- ==========================================================================
            -- PHASE 2: OBJECT SECTIONS
            -- ==========================================================================
            
            -- Define which object types to display and in what order
            -- Available: 'tables', 'views', 'procedures', 'functions', 'types', 'synonyms'
            vim.g.db_ui_object_sections = {
                'tables',
                'views', 
                'procedures',
                'functions',
                'types',
                'synonyms'
            }
            
            -- Control drawer section order
            vim.g.db_ui_drawer_sections = {
                'new_query',
                'buffers',
                'saved_queries',
                'database_objects'  -- This replaces 'schemas' for the new system
            }
            
            -- ==========================================================================
            -- PHASE 2: USE STATEMENT GENERATION
            -- ==========================================================================
            
            -- Automatically add USE <database> statement to generated queries
            vim.g.db_ui_add_use_statement = 1
            
            -- Templates for USE statements by database type
            vim.g.db_ui_use_statement_template = {
                sqlserver = "USE [{database}];\nGO\n\n",
                mysql = "USE `{database}`;\n\n",
                mariadb = "USE `{database}`;\n\n",
                postgresql = "\\c {database}\n\n",
                postgres = "\\c {database}\n\n"
            }
            
            -- ==========================================================================
            -- PHASE 2: OBJECT ACTIONS
            -- ==========================================================================
            
            -- Available actions when expanding procedures/functions
            vim.g.db_ui_object_actions = {
                'view_definition',
                'script_create',
                'script_alter',
                'script_drop',
                'script_execute'
            }
            
            -- Custom labels for actions (optional)
            vim.g.db_ui_object_action_labels = {
                view_definition = "View Definition",
                script_create = "Script as CREATE",
                script_alter = "Script as ALTER", 
                script_drop = "Script as DROP",
                script_execute = "Script as EXECUTE"
            }
            
            -- ==========================================================================
            -- PHASE 2: PERFORMANCE & CACHING
            -- ==========================================================================
            
            -- Cache object lists to improve performance
            vim.g.db_ui_cache_object_lists = 1
            
            -- Cache timeout in seconds (300 = 5 minutes)
            vim.g.db_ui_cache_timeout = 300

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
-- DADBOD USAGE GUIDE (UPDATED - <leader>q prefix)
-- =============================================================================
-- Getting Started:
-- 1. Install required CLI tools (sqlcmd, mysql, bq)
-- 2. Add connections via :DBUIAddConnection or <leader>qa
-- 3. Open DBUI with <leader>qb
--
-- Custom Keymaps (Leader-based) - NOW USING <leader>q:
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
--   sqlserver://username:password@server:port/database
--   sqlserver://server/database?integratedSecurity=true  (Windows Auth)
--
-- Azure SQL:
--   sqlserver://username:password@yourserver.database.windows.net:1433/dbname
--
-- MySQL:
--   mysql://username:password@localhost:3306/database
--
-- BigQuery:
--   bigquery:project-id:dataset-id
--   bigquery:?project_id=proj&dataset_id=dataset
--
-- Tips:
-- 1. Use :DBUIAddConnection to avoid committing credentials
-- 2. Saved queries are stored in ~/.local/share/db_ui/
-- 3. Use table helpers (right-click tables) for quick queries
-- 4. Bind parameters with :param_name in queries, edit with <leader>qe
-- 5. For Azure AD auth, you may need go-sqlcmd instead of standard sqlcmd
--
-- Troubleshooting:
-- - No adapter found: Ensure CLI tools are installed and in PATH
-- - Connection fails: Test connection with CLI tool directly first
-- - MSSQL quotes issue: Set 'noshellslash' on Windows
-- - BigQuery: Ensure gcloud auth is configured
-- =============================================================================