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
        -- Loaded automatically by vim-dadbod-ui
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

            -- Use Nerd Fonts for icons
            vim.g.db_ui_use_nerd_fonts = 1

            -- Show database icons
            vim.g.db_ui_show_database_icon = 1

            -- UI layout
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            -- Notifications
            vim.g.db_ui_use_nvim_notify = true

            -- Don't auto-execute queries on save (safer for large queries)
            vim.g.db_ui_execute_on_save = false

            -- Auto-execute table helpers (COUNT, DESCRIBE, etc.)
            vim.g.db_ui_auto_execute_table_helpers = 1

            -- Save location for queries
            local data_path = vim.fn.stdpath("data")
            vim.g.db_ui_save_location = data_path .. "/dadbod_ui"

            -- Disable some buffer mappings if desired
            -- vim.g.db_ui_disable_mappings = 0

            -- ==========================================================================
            -- DATABASE CONNECTIONS
            -- ==========================================================================
            -- IMPORTANT: Don't commit credentials to git!
            -- Options for managing connections:
            -- 1. Use :DBUIAddConnection command (stores in ~/.local/share/db_ui/)
            -- 2. Use environment variables (shown below)
            -- 3. Use vim.g.dbs dictionary (shown below, commented out)
            -- ==========================================================================

            -- METHOD 1: Environment Variables (Recommended for security)
            -- Set these in your shell profile (.bashrc, .zshrc, etc.)
            -- export DBUI_URL_PROD_MSSQL="sqlserver://user:pass@server.database.windows.net:1433/dbname"
            -- Neovim will automatically detect $DBUI_URL_* variables

            -- METHOD 2: Define connections directly (USE WITH CAUTION)
            -- Uncomment and configure for your databases
            -- SECURITY WARNING: Add this file to .gitignore if using this method!

            -- vim.g.dbs = {
            --     -- ==========================================================================
            --     -- MSSQL CONNECTIONS
            --     -- ==========================================================================
            --     {
            --         name = "local_mssql",
            --         url = "sqlserver://localhost:1433/master?integratedSecurity=true"
            --         -- For integrated security (Windows Auth), omit user/password
            --         -- For SQL Auth: sqlserver://username:password@localhost:1433/dbname
            --     },
            --     {
            --         name = "azure_db_prod",
            --         url = "sqlserver://username:password@yourserver.database.windows.net:1433/yourdb"
            --     },
            --
            --     -- ==========================================================================
            --     -- MYSQL CONNECTIONS
            --     -- ==========================================================================
            --     {
            --         name = "local_mysql",
            --         url = "mysql://root:password@localhost:3306/mydb"
            --         -- No password: mysql://root@localhost:3306/mydb
            --     },
            --
            --     -- ==========================================================================
            --     -- BIGQUERY CONNECTIONS
            --     -- ==========================================================================
            --     {
            --         name = "bigquery_project",
            --         url = "bigquery:your-project-id:your-dataset?use_legacy_sql=false"
            --         -- Uses gcloud authentication automatically
            --         -- Make sure you've run: gcloud auth application-default login
            --     },
            -- }

            -- ==========================================================================
            -- TABLE HELPERS (Custom queries for database objects)
            -- ==========================================================================
            vim.g.db_ui_table_helpers = {
                -- MSSQL/SQL Server helpers
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

                -- MySQL helpers
                mysql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Describe = "DESCRIBE {table}",
                    Indexes = "SHOW INDEXES FROM {table}",
                    Limit100 = "SELECT * FROM {table} LIMIT 100"
                },

                -- BigQuery helpers
                bigquery = {
                    Count = "SELECT COUNT(*) FROM `{table}`",
                    Schema = "SELECT * FROM `{table}` LIMIT 0",
                    Sample = "SELECT * FROM `{table}` LIMIT 100"
                }
            }

            -- ==========================================================================
            -- ICONS (Optional customization)
            -- ==========================================================================
            vim.g.db_ui_icons = {
                expanded = {
                    -- Font Awesome server icon (nf-fa-server)
                    db = "\u{25be} \u{f233}",
                    -- Codicons files icon (nf-cod-files)
                    buffers = "\u{25be} \u{eae7}",
                    -- Font Awesome file-code icon (nf-fa-file_code_o)
                    saved_queries = "\u{25be} \u{f1c9}",
                    -- Font Awesome sitemap (layers) icon
                    schemas = "\u{25be} \u{f0e8}",
                    schema = "\u{25be} \u{f0e8}",
                    -- Font Awesome th (grid) icon
                    tables = "\u{25be} \u{f00a}",
                    table = "\u{25be} \u{f00a}",
                },
                collapsed = {
                    db = "\u{25b8} \u{f233}",
                    buffers = "\u{25b8} \u{eae7}",
                    saved_queries = "\u{25b8} \u{f1c9}",
                    schemas = "\u{25b8} \u{f0e8}",
                    schema = "\u{25b8} \u{f0e8}",
                    tables = "\u{25b8} \u{f00a}",
                    table = "\u{25b8} \u{f00a}",
                },
                saved_query = "\u{f1c9}",
                new_query = "\u{f067}",
                tables = "\u{f1c0}",
                buffers = "\u{eae7}",
                -- Font Awesome link icon (nf-fa-link)
                add_connection = "\u{f0c1}",
                -- Font Awesome check-circle icon
                connection_ok = "\u{f058}",
                -- Font Awesome times-circle icon
                connection_error = "\u{f057}",
            }
        end,

        keys = {{
            "<leader>db",
            "<cmd>DBUIToggle<cr>",
            desc = "Toggle Database UI"
        }, {
            "<leader>df",
            "<cmd>DBUIFindBuffer<cr>",
            desc = "Find Database Buffer"
        }, {
            "<leader>dr",
            "<cmd>DBUIRenameBuffer<cr>",
            desc = "Rename Database Buffer"
        }, {
            "<leader>dl",
            "<cmd>DBUILastQueryInfo<cr>",
            desc = "Last Query Info"
        }}
    },

    -- ==========================================================================
    -- SQL COMPLETION (Integrates with blink.cmp)
    -- ==========================================================================
    {
        "kristijanhusak/vim-dadbod-completion",
        ft = {"sql", "mysql", "plsql"},
        lazy = true,

        init = function()
            -- Integrate with blink.cmp
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"sql", "mysql", "plsql"},
                callback = function()
                    -- Check if blink.cmp is available
                    local ok, blink = pcall(require, "blink.cmp")
                    if ok then
                        -- Add vim-dadbod-completion as a source
                        -- This will be handled by the blink.cmp config update below
                    end

                    -- Set up SQL-specific keymaps
                    local keymap = vim.keymap.set
                    local opts = {
                        buffer = true,
                        silent = true
                    }

                    -- Execute current query
                    keymap("n", "<leader>dw", "<Plug>(DBUI_SaveQuery)",
                        vim.tbl_extend("force", opts, {
                            desc = "Save Query"
                        }))
                    keymap("n", "<leader>de", "<Plug>(DBUI_EditBindParameters)",
                        vim.tbl_extend("force", opts, {
                            desc = "Edit Bind Parameters"
                        }))
                    keymap("v", "<leader>dx", "<Plug>(DBUI_ExecuteQuery)",
                        vim.tbl_extend("force", opts, {
                            desc = "Execute Selected Query"
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
