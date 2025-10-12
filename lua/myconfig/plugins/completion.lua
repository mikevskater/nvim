-- ~\AppData\Local\nvim\lua\myconfig\plugins\completion.lua
-- =============================================================================
-- COMPLETION - Auto-completion Engine (UPDATED with SQL support)
-- =============================================================================
-- Added: SQL completion support via vim-dadbod-completion
-- =============================================================================
return {
    "saghen/blink.cmp",

    version = "v1.*",

    dependencies = {
        "rafamadriz/friendly-snippets",
        -- SQL completion support (loaded in database.lua)
    },

    opts = {
        -- ==========================================================================
        -- KEYMAP PRESET
        -- ==========================================================================
        keymap = {
            preset = "default"

            -- You can customize individual keys if needed
            -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            -- ['<C-e>'] = { 'hide' },
            -- ['<C-y>'] = { 'select_and_accept' },
            -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
            -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        },

        -- ==========================================================================
        -- APPEARANCE
        -- ==========================================================================
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono"
        },

        -- ==========================================================================
        -- COMPLETION SOURCES (UPDATED)
        -- ==========================================================================
        sources = {
            -- Default sources for most filetypes
            default = {"lsp", "path", "snippets", "buffer"},

            -- Custom provider configurations
            providers = {
                snippets = {
                    opts = {
                        friendly_snippets = true,
                        -- Custom snippet directories
                        search_paths = {vim.fn.stdpath("config") .. "/snippets"},
                        -- Global snippets available in all filetypes
                        global_snippets = {"all"}
                    }
                },

                -- ADDED: vim-dadbod completion provider
                dadbod = {
                    name = "Dadbod",
                    module = "vim_dadbod_completion.blink",
                    -- Only enable for SQL filetypes
                    enabled = function()
                        local ft = vim.bo.filetype
                        return ft == "sql" or ft == "mysql" or ft == "plsql"
                    end,
                },
            },

            -- Per-filetype sources (ADDED)
            per_filetype = {
                sql = { "dadbod", "buffer" },
                mysql = { "dadbod", "buffer" },
                plsql = { "dadbod", "buffer" },
            },
        },

        -- ==========================================================================
        -- COMPLETION BEHAVIOR
        -- ==========================================================================
        completion = {
            -- Automatically show completion menu
            menu = {
                auto_show = true,

                -- ADDED: Rounded border for menu
                border = "rounded",

                draw = {
                    treesitter = {"lsp"},

                    columns = {{"kind_icon"}, {
                        "label",
                        "label_description",
                        gap = 1
                    }}
                }
            },

            -- Documentation window
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,

                -- ADDED: Rounded border for documentation
                window = {
                    border = "rounded"
                }
            },

            -- ADDED: Ghost text (inline suggestions)
            ghost_text = {
                enabled = true -- Show completion as ghost text!
            },

            -- Auto-brackets
            accept = {
                auto_brackets = {
                    enabled = true
                }
            }
        },

        -- ==========================================================================
        -- SIGNATURE HELP
        -- ==========================================================================
        signature = {
            enabled = true,

            -- ADDED: Rounded border for signature help
            window = {
                border = "rounded"
            }
        }
    },

    config = function(_, opts)
        require("blink.cmp").setup(opts)
    end
}

-- =============================================================================
-- COMPLETION NOTES (UPDATED)
-- =============================================================================
-- SQL Completion Features:
-- - Table and column name completion
-- - SQL keyword completion
-- - Function completion
-- - Completion based on current database connection
--
-- SQL Completion Usage:
-- 1. Open or create a .sql file
-- 2. Connect to database via DBUI
-- 3. Start typing - completions will appear automatically
-- 4. Completions are context-aware based on your connection
--
-- Example:
-- SELECT * FROM cus<Tab>  → completes to your 'customers' table
-- SELECT name, em<Tab>    → completes to 'email' column
--
-- Troubleshooting SQL Completion:
-- - No completions? Make sure you're connected to a DB via DBUI
-- - Wrong completions? Check your active connection in DBUI
-- - Slow completions? Large databases may take time to load schema
--
-- New features enabled:
--
-- 1. GHOST TEXT:
--    - Shows completion inline as you type
--    - Appears as dimmed text after cursor
--    - Press <Tab> or <CR> to accept
--
-- 2. ROUNDED BORDERS:
--    - Completion menu has rounded border
--    - Documentation window has rounded border
--    - Signature help has rounded border
--    - Matches modern UI aesthetics
--
-- 3. CUSTOM SNIPPETS:
--    - Add your own snippets to: ~/.config/nvim/snippets/
--    - Format: language.snippets (e.g., lua.snippets)
--    - Use VSCode-style snippet syntax
--
-- Default keybindings:
-- <Tab>      - Select next / accept snippet placeholder
-- <S-Tab>    - Select previous / previous placeholder
-- <CR>       - Accept completion
-- <C-e>      - Close completion menu
-- <C-space>  - Trigger completion manually
-- <C-b>      - Scroll docs up
-- <C-f>      - Scroll docs down
--
-- Example custom snippet file (~/.config/nvim/snippets/lua.snippets):
-- snippet fn "function"
-- function ${1:name}(${2:args})
--   ${0}
-- end
-- endsnippet
--
-- Performance:
-- - blink.cmp is 10-100x faster than nvim-cmp
-- - Updates on every keystroke with minimal lag
-- - Ghost text adds ~0ms overhead
--
-- Troubleshooting:
-- 1. No completions? Check LSP: :LspInfo
-- 2. Ghost text not showing? Make sure enabled = true
-- 3. Manually trigger: <C-space>
-- =============================================================================
