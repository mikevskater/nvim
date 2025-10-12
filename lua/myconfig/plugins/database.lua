-- ~\AppData\Local\nvim\lua\myconfig\plugins\database.lua
-- =============================================================================
-- DATABASE PLUGINS - SQL IDE Setup
-- =============================================================================
-- Turns Neovim into a SQL database IDE similar to SSMS
-- Supports: MSSQL, MySQL, Azure DB, BigQuery
-- =============================================================================
return
    { -- ==========================================================================
    -- CORE DATABASE INTERFACE
    -- ==========================================================================
    {
        "tpope/vim-dadbod",
        lazy = true
    },

    -- ==========================================================================
    -- DATABASE UI
    -- ==========================================================================
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {{
            "tpope/vim-dadbod",
            lazy = true
        }, {
            "kristijanhusak/vim-dadbod-completion",
            ft = {"sql", "mysql", "plsql"},
            lazy = true
        }},

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

            local data_path = vim.fn.stdpath("data")
            vim.g.db_ui_save_location = data_path .. "/dadbod_ui"

            -- ==========================================================================
            -- ICONS
            -- ==========================================================================
            vim.g.db_ui_icons = {
                expanded = {
                    db = "\u{25be} \u{f1c0}", -- ▾  (database)
                    buffers = "\u{25be} \u{f0c5}", -- ▾  (files)
                    saved_queries = "\u{25be} \u{f0f6}", -- ▾  (file-text)
                    schemas = "\u{25be} \u{f1c0}", -- ▾  (database)
                    schema = "\u{25be} \u{e5ff}", -- ▾  (folder)
                    tables = "\u{25be} \u{f0ce}", -- ▾  (table)
                    table = "\u{25be} \u{f0ce}" -- ▾  (table)
                },
                collapsed = {
                    db = "\u{25b8} \u{f1c0}", -- ▸ 
                    buffers = "\u{25b8} \u{f0c5}", -- ▸ 
                    saved_queries = "\u{25b8} \u{f0f6}", -- ▸ 
                    schemas = "\u{25b8} \u{f1c0}", -- ▸ 
                    schema = "\u{25b8} \u{e5ff}", -- ▸ 
                    tables = "\u{25b8} \u{f0ce}", -- ▸ 
                    table = "\u{25b8} \u{f0ce}" -- ▸ 
                },
                saved_query = "\u{f0f6}", --  (file-text)
                new_query = "\u{f067}", --  (plus)
                tables = "\u{f0ce}", --  (table)
                buffers = "\u{f0c5}", --  (files)
                add_connection = "\u{f067}", --  (plus)
                connection_ok = "\u{2713}", -- ✓ (checkmark)
                connection_error = "\u{2715}" -- ✕ (X)
            }

            -- ==========================================================================
            -- TABLE HELPERS
            -- ==========================================================================
            vim.g.db_ui_table_helpers = {
                sqlserver = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Columns = [[
                        SELECT 
                            COLUMN_NAME,
                            DATA_TYPE,
                            CHARACTER_MAXIMUM_LENGTH,
                            IS_NULLABLE
                        FROM INFORMATION_SCHEMA.COLUMNS 
                        WHERE TABLE_NAME = '{table}'
                    ]],
                    Indexes = [[
                        SELECT 
                            i.name AS IndexName,
                            i.type_desc AS IndexType,
                            COL_NAME(ic.object_id, ic.column_id) AS ColumnName
                        FROM sys.indexes i
                        INNER JOIN sys.index_columns ic 
                            ON i.object_id = ic.object_id 
                            AND i.index_id = ic.index_id
                        WHERE OBJECT_NAME(i.object_id) = '{table}'
                    ]],
                    Top100 = "SELECT TOP 100 * FROM {table}"
                },
                mysql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Describe = "DESCRIBE {table}",
                    Indexes = "SHOW INDEXES FROM {table}",
                    Limit100 = "SELECT * FROM {table} LIMIT 100"
                },
                bigquery = {
                    Count = "SELECT COUNT(*) FROM `{table}`",
                    Schema = "SELECT * FROM `{table}` LIMIT 0",
                    Sample = "SELECT * FROM `{table}` LIMIT 100"
                }
            }
        end,

        keys = {{
            "<leader>db",
            "<cmd>DBUIToggle<cr>",
            desc = "\u{f1c0} Toggle Database UI"
        }, {
            "<leader>df",
            "<cmd>DBUIFindBuffer<cr>",
            desc = "\u{f002} Find Database Buffer"
        }, {
            "<leader>dr",
            "<cmd>DBUIRenameBuffer<cr>",
            desc = "\u{f040} Rename Database Buffer"
        }, {
            "<leader>dl",
            "<cmd>DBUILastQueryInfo<cr>",
            desc = "\u{f05a} Last Query Info"
        }}
    },

    -- ==========================================================================
    -- SQL COMPLETION
    -- ==========================================================================
    {
        "kristijanhusak/vim-dadbod-completion",
        ft = {"sql", "mysql", "plsql"},
        lazy = true,

        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"sql", "mysql", "plsql"},
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = {
                        buffer = true,
                        silent = true
                    }

                    keymap("n", "<leader>dw", "<Plug>(DBUI_SaveQuery)",
                        vim.tbl_extend("force", opts, {
                            desc = "\u{f0c7} Save Query"
                        }))
                    keymap("n", "<leader>de", "<Plug>(DBUI_EditBindParameters)",
                        vim.tbl_extend("force", opts, {
                            desc = "\u{f040} Edit Bind Parameters"
                        }))
                    keymap("v", "<leader>dx", "<Plug>(DBUI_ExecuteQuery)",
                        vim.tbl_extend("force", opts, {
                            desc = "\u{f04b} Execute Selected Query"
                        }))
                end
            })
        end
    }}

-- =============================================================================
-- DADBOD USAGE GUIDE
-- =============================================================================
-- Getting Started:
-- 1. Install required CLI tools (sqlcmd, mysql, bq)
-- 2. Add connections via :DBUIAddConnection or configure vim.g.dbs above
-- 3. Open DBUI with <leader>db
--
-- DBUI Navigation:
-- o / <CR>    - Open/Toggle database, schema, or table
-- S          - Open in vertical split
-- R          - Redraw UI
-- A          - Add connection
-- d          - Delete connection/query
-- r          - Rename connection/query
-- q          - Quit DBUI
--
-- Query Execution:
-- :w in query buffer - Execute query and show results
-- <leader>dx (visual) - Execute selected query
-- <leader>dw         - Save query permanently
-- <leader>de         - Edit bind parameters
--
-- Results Navigation:
-- <           - Previous page
-- >           - Next page
-- R           - Toggle expanded view
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
-- 4. Bind parameters with :param_name in queries, edit with <leader>de
-- 5. For Azure AD auth, you may need go-sqlcmd instead of standard sqlcmd
--
-- Troubleshooting:
-- - No adapter found: Ensure CLI tools are installed and in PATH
-- - Connection fails: Test connection with CLI tool directly first
-- - MSSQL quotes issue: Set 'noshellslash' on Windows
-- - BigQuery: Ensure gcloud auth is configured
-- =============================================================================
