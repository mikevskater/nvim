-- ~\AppData\Local\nvim\lua\myconfig\plugins\completion.lua
-- =============================================================================
-- COMPLETION - Auto-completion Engine (UPDATED with comprehensive keymaps)
-- =============================================================================
-- Updated: Added explicit keymaps, Enter to accept, signature help scrolling
-- =============================================================================
return {
    "saghen/blink.cmp",

    version = "v1.*",

    dependencies = {"rafamadriz/friendly-snippets"},

    opts = {
        -- ==========================================================================
        -- KEYMAP CONFIGURATION
        -- ==========================================================================
        keymap = {
            -- Start with default preset, then override/add specific keys
            preset = "default",

            -- ==========================================================================
            -- ACCEPT KEYMAPS
            -- ==========================================================================
            -- Enter to accept completion (most requested feature!)
            ['<C-y>'] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.accept()
                    else
                        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'n', true)
                    end
                end
            },

            -- Alternative accept (doesn't conflict with shell/tmux Ctrl+Y)
            ['<C-l>'] = {'accept'},

            -- ==========================================================================
            -- CANCEL KEYMAP
            -- ==========================================================================
            -- Cancel completion and revert auto_insert
            ['<C-g>'] = {'cancel'},

            -- ==========================================================================
            -- SIGNATURE HELP SCROLLING
            -- ==========================================================================
            -- Scroll signature help up (4 lines)
            ['<M-k>'] = {function(cmp)
                cmp.scroll_signature_up(4)
            end, 'fallback'},

            -- Scroll signature help down (4 lines)  
            ['<M-j>'] = {function(cmp)
                cmp.scroll_signature_down(4)
            end, 'fallback'}

            -- ==========================================================================
            -- ADVANCED: ACCEPT SPECIFIC ITEMS
            -- ==========================================================================
            -- Quickly accept first item without selecting
            -- ['<C-1>'] = { 
            --     function(cmp) 
            --         cmp.accept({ index = 1 }) 
            --     end 
            -- },

            -- ==========================================================================
            -- ADVANCED: SHOW SPECIFIC PROVIDERS
            -- ==========================================================================
            -- Show only snippets
            -- ['<C-s>'] = { 
            --     function(cmp) 
            --         cmp.show({ providers = { 'snippets' } }) 
            --     end 
            -- },

            -- ==========================================================================
            -- DEFAULT PRESET KEYMAPS (INHERITED)
            -- ==========================================================================
            -- These are automatically included from preset = "default":
            -- 
            -- <C-space>  - Show/toggle documentation
            -- <C-e>      - Hide completion menu
            -- <C-y>      - Select and accept
            -- <Up>       - Select previous item
            -- <Down>     - Select next item
            -- <C-p>      - Select previous (fallback to mappings)
            -- <C-n>      - Select next (fallback to mappings)
            -- <C-b>      - Scroll documentation up
            -- <C-f>      - Scroll documentation down
            -- <Tab>      - Snippet forward / fallback
            -- <S-Tab>    - Snippet backward / fallback
            -- <C-k>      - Show/hide signature help (NORMAL MODE ONLY - no conflict)
            -- ==========================================================================
        },

        -- ==========================================================================
        -- APPEARANCE
        -- ==========================================================================
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        -- ==========================================================================
        -- COMPLETION SOURCES (UPDATED)
        -- ==========================================================================
        sources = {
            -- Default sources for most filetypes
            default = {"lsp", "path", "snippets", "buffer"},

            -- Custom provider configurations
            providers = {
                ssns = {
                    name = 'ssns',
                    module = 'ssns.completion.source',
                    score_offset = 10,  -- Prioritize SSNS completions
                },
                snippets = {                    
                    opts = {
                        friendly_snippets = true,
                        search_paths = {vim.fn.stdpath("config") .. "/snippets"},
                        global_snippets = {"all"}
                    }
                },
            },

            per_filetype = {
                -- Disable dadbod for now (using SSNS instead)
                sql = {"buffer", "ssns"},
                mysql = {"buffer", "ssns"},
                plsql = {"buffer", "ssns"}
            }
        },

        -- ==========================================================================
        -- COMPLETION BEHAVIOR
        -- ==========================================================================
        completion = {
            menu = {
                auto_show = true,
                border = "rounded",
                winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

                draw = {
                    treesitter = {"lsp"},
                    columns = {{"kind_icon"}, {
                        "label",
                        "label_description",
                        gap = 1
                    }}
                }
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                    border = "rounded",
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder"
                }
            },

            ghost_text = {
                enabled = true
            },

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
            window = {
                border = "rounded",
                winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder"
            }
        }
    },

    config = function(_, opts)
        require("blink.cmp").setup(opts)
    end
}

-- =============================================================================
-- COMPLETION KEYMAPS REFERENCE (UPDATED)
-- =============================================================================
-- 
-- ACCEPT COMPLETIONS:
-- <CR>       - Accept selected item (or fallback)
-- <C-y>      - Select and accept (default preset)
-- <C-l>      - Alternative accept key
--
-- NAVIGATION:
-- <Tab>      - Next snippet placeholder / fallback
-- <S-Tab>    - Previous snippet placeholder / fallback
-- <C-n>      - Select next item
-- <C-p>      - Select previous item
-- <Down>     - Select next item
-- <Up>       - Select previous item
--
-- DOCUMENTATION:
-- <C-space>  - Show/toggle documentation
-- <C-b>      - Scroll documentation up
-- <C-f>      - Scroll documentation down
--
-- SIGNATURE HELP:
-- <C-k>      - Show/hide signature help (NORMAL MODE - no conflict with window nav)
-- <M-k>      - Scroll signature up (Alt+k)
-- <M-j>      - Scroll signature down (Alt+j)
--
-- MENU CONTROL:
-- <C-e>      - Hide completion menu
-- <C-g>      - Cancel and revert changes
--
-- NOTE: Insert mode signature help removed (<C-s> conflicts with save)
--       Use <C-k> in normal mode or LSP's signature help instead
--
-- =============================================================================
-- TIPS & TRICKS
-- =============================================================================
--
-- 1. ENTER vs CTRL-Y:
--    - <CR> accepts and continues to next line (natural flow)
--    - <C-y> accepts without newline (vim traditional)
--
-- 2. SIGNATURE HELP SCROLLING:
--    - Use Alt+j/k when function has many parameters
--    - Works great with complex APIs
--
-- 3. CANCEL vs HIDE:
--    - <C-g> cancels and reverts auto_insert changes
--    - <C-e> just hides the menu
--
-- 4. GHOST TEXT:
--    - Shows completion inline as you type
--    - Press Tab or Enter to accept
--    - Set `ghost_text.enabled = false` to disable
--
-- 5. CUSTOM PROVIDER TRIGGERS:
--    - Uncomment <C-s> to show only snippets
--    - Great for snippet-heavy workflows
--
-- 6. SQL COMPLETION:
--    - Automatically enabled in .sql files
--    - Requires vim-dadbod-ui connection
--
-- =============================================================================
-- TROUBLESHOOTING
-- =============================================================================
--
-- Enter not working?
-- - Check if you have conflicting <CR> mappings
-- - Try <C-y> as alternative
--
-- Signature help not showing?
-- - Ensure signature.enabled = true
-- - Press <C-k> (in normal mode) to toggle
-- - Some LSPs don't support signatures
--
-- Snippets not working?
-- - Check if friendly-snippets is installed
-- - Verify snippet files exist
-- - Try triggering manually with <C-space>
--
-- =============================================================================