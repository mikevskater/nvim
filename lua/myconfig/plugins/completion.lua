-- ~\AppData\Local\nvim\lua\myconfig\plugins\completion.lua
-- =============================================================================
-- COMPLETION - Auto-completion Engine
-- =============================================================================
-- Why blink.cmp? Much faster than nvim-cmp (0.5-4ms vs 60ms+)
-- Modern, batteries-included, works out of the box
-- https://github.com/Saghen/blink.cmp
-- =============================================================================
return {
    "saghen/blink.cmp",

    -- Use a release tag to download pre-built binaries (faster)
    version = "v1.*",

    -- Dependencies
    dependencies = {"rafamadriz/friendly-snippets" -- Collection of snippets
    },

    -- Configuration
    opts = {
        -- ==========================================================================
        -- KEYMAP PRESET
        -- ==========================================================================
        -- 'default': <Tab> to select, <Enter> to accept
        -- 'super-tab': <Tab> for everything
        -- 'enter': <Enter> to accept, <Tab> for snippets
        keymap = {
            preset = "default"

            -- Custom keymaps (optional)
            -- Uncomment to customize
            -- ["<Tab>"] = { "select_next", "fallback" },
            -- ["<S-Tab>"] = { "select_prev", "fallback" },
            -- ["<CR>"] = { "accept", "fallback" },
        },

        -- ==========================================================================
        -- APPEARANCE
        -- ==========================================================================
        appearance = {
            -- Use nvim-cmp's highlight groups (for theme compatibility)
            use_nvim_cmp_as_default = true,

            -- Nerd Font variant: 'mono' or 'normal'
            nerd_font_variant = "mono"
        },

        -- ==========================================================================
        -- COMPLETION SOURCES
        -- ==========================================================================
        -- Where completion suggestions come from
        sources = {
            default = {"lsp", -- From language servers
            "path", -- File paths
            "snippets", -- Code snippets
            "buffer" -- Words from open buffers
            }

            -- Per-filetype sources (optional)
            -- providers = {
            --   lsp = { fallback_for = { "lazydev" } },
            -- },
        },

        -- ==========================================================================
        -- COMPLETION BEHAVIOR
        -- ==========================================================================
        completion = {
            -- Automatically show completion menu
            menu = {
                auto_show = true,

                -- Draw behavior
                draw = {
                    -- Show treesitter context
                    treesitter = {"lsp"},

                    -- Columns to display
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
                auto_show_delay_ms = 200
            },

            -- Ghost text (inline suggestions)
            ghost_text = {
                enabled = false -- Disable by default (can be distracting)
            },

            -- Auto-brackets
            accept = {
                auto_brackets = {
                    enabled = true -- Auto-insert closing brackets
                }
            }
        },

        -- ==========================================================================
        -- SIGNATURE HELP
        -- ==========================================================================
        -- Show function signatures while typing
        signature = {
            enabled = true
        }
    },

    -- ==========================================================================
    -- ADDITIONAL SETUP
    -- ==========================================================================
    config = function(_, opts)
        require("blink.cmp").setup(opts)
    end
}

-- =============================================================================
-- COMPLETION NOTES
-- =============================================================================
-- blink.cmp comes with sensible defaults, minimal config needed!
--
-- Default keybindings:
-- <Tab>      - Select next item
-- <S-Tab>    - Select previous item
-- <CR>       - Accept completion
-- <C-e>      - Close completion menu
-- <C-space>  - Trigger completion manually
--
-- Completion sources explained:
-- - lsp: From language servers (functions, variables, etc.)
-- - path: File and directory paths
-- - buffer: Words from currently open files
-- - snippets: Code templates
--
-- Performance notes:
-- - blink.cmp is 10-100x faster than nvim-cmp
-- - Updates on every keystroke with minimal lag
-- - Uses Rust for fuzzy matching (compiled to WASM)
--
-- Troubleshooting:
-- 1. No completions? Check LSP is running: :LspInfo
-- 2. Check blink.cmp is loaded: :Lazy
-- 3. Manually trigger: <C-space>
-- =============================================================================
