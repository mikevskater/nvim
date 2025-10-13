-- ~\AppData\Local\nvim\lua\myconfig\plugins\gitsigns.lua
-- =============================================================================
-- GITSIGNS - Git Decorations
-- =============================================================================
-- Shows git changes in the sign column (added/modified/deleted lines)
-- =============================================================================
return {
    "lewis6991/gitsigns.nvim",

    opts = {
        signs = {
            add = {
                text = "┃" -- │
            },
            change = {
                text = "┃" -- │
            },
            delete = {
                text = "▁" -- ▁
            },
            topdelete = {
                text = "▔" -- ▔
            },
            changedelete = {
                text = "┃" -- │
            },
            untracked = {
                text = "┇" -- ┇ (dotted vertical line)
            }
        },

        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local keymap = vim.keymap.set

            -- ==========================================================================
            -- NAVIGATION
            -- ==========================================================================

            -- Next/Previous hunk (with diff mode support)
            keymap('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({
                        ']c',
                        bang = true
                    })
                else
                    gs.nav_hunk('next')
                end
            end, {
                buffer = bufnr,
                desc = "\u{f063} Next git hunk" -- ↓
            })

            keymap('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({
                        '[c',
                        bang = true
                    })
                else
                    gs.nav_hunk('prev')
                end
            end, {
                buffer = bufnr,
                desc = "\u{f062} Previous git hunk" -- ↑
            })

            -- First/Last hunk
            keymap('n', ']H', function()
                gs.nav_hunk('last')
            end, {
                buffer = bufnr,
                desc = "\u{f063} Last git hunk"
            })

            keymap('n', '[H', function()
                gs.nav_hunk('first')
            end, {
                buffer = bufnr,
                desc = "\u{f062} First git hunk"
            })

            -- ==========================================================================
            -- HUNK ACTIONS (Changed from <leader>h to gh)
            -- ==========================================================================

            -- Stage hunk (normal mode)
            keymap('n', 'ghs', gs.stage_hunk, {
                buffer = bufnr,
                desc = "\u{f067} Stage hunk" -- +
            })

            -- Stage hunk (visual mode - stage selected lines)
            keymap('v', 'ghs', function()
                gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
            end, {
                buffer = bufnr,
                desc = "\u{f067} Stage hunk"
            })

            -- Reset hunk (normal mode)
            keymap('n', 'ghr', gs.reset_hunk, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset hunk" -- ↻
            })

            -- Reset hunk (visual mode - reset selected lines)
            keymap('v', 'ghr', function()
                gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
            end, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset hunk"
            })

            -- Undo stage hunk
            keymap('n', 'ghu', gs.undo_stage_hunk, {
                buffer = bufnr,
                desc = "\u{f0e2} Undo stage hunk" -- ↻
            })

            -- ==========================================================================
            -- BUFFER ACTIONS
            -- ==========================================================================

            -- Stage entire buffer
            keymap('n', 'ghS', gs.stage_buffer, {
                buffer = bufnr,
                desc = "\u{f067} Stage buffer" -- +
            })

            -- Reset entire buffer
            keymap('n', 'ghR', gs.reset_buffer, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset buffer" -- ↻
            })

            -- Reset buffer index (unstage all)
            keymap('n', 'ghU', gs.reset_buffer_index, {
                buffer = bufnr,
                desc = "\u{f0e2} Unstage buffer" -- ↻
            })

            -- ==========================================================================
            -- PREVIEW & DIFF
            -- ==========================================================================

            -- Preview hunk (popup)
            keymap('n', 'ghp', gs.preview_hunk, {
                buffer = bufnr,
                desc = "\u{f06e} Preview hunk" -- 👁
            })

            -- Preview hunk inline
            keymap('n', 'ghi', gs.preview_hunk_inline, {
                buffer = bufnr,
                desc = "\u{f06e} Preview hunk inline"
            })

            -- Diff this (split view)
            keymap('n', 'ghd', gs.diffthis, {
                buffer = bufnr,
                desc = "\u{f1e5} Diff this" -- 
            })

            -- Diff against previous revision
            keymap('n', 'ghD', function()
                gs.diffthis('~')
            end, {
                buffer = bufnr,
                desc = "\u{f1e5} Diff against ~"
            })

            -- ==========================================================================
            -- BLAME
            -- ==========================================================================

            -- Show blame line (popup with full info)
            keymap('n', 'ghb', function()
                gs.blame_line({
                    full = true
                })
            end, {
                buffer = bufnr,
                desc = "\u{f1d3} Blame line" -- 
            })

            -- Toggle current line blame (inline virtual text)
            keymap('n', 'ght', gs.toggle_current_line_blame, {
                buffer = bufnr,
                desc = "\u{f1d3} Toggle line blame"
            })

            -- ==========================================================================
            -- TOGGLES
            -- ==========================================================================

            -- Toggle deleted lines view
            keymap('n', 'ghx', gs.toggle_deleted, {
                buffer = bufnr,
                desc = "\u{f06e} Toggle deleted" -- 👁
            })

            -- ==========================================================================
            -- QUICKFIX / LOCATION LIST
            -- ==========================================================================

            -- Load all hunks into quickfix list
            keymap('n', 'ghq', function()
                gs.setqflist('all')
            end, {
                buffer = bufnr,
                desc = "\u{f03a} Hunks to quickfix" -- ≡
            })

            -- Load all hunks into location list
            keymap('n', 'ghl', function()
                gs.setloclist('all')
            end, {
                buffer = bufnr,
                desc = "\u{f03a} Hunks to loclist"
            })

            -- ==========================================================================
            -- TEXT OBJECTS
            -- ==========================================================================

            -- Select hunk as text object (use with: dih, vih, yih, etc.)
            keymap({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
                buffer = bufnr,
                desc = "\u{f1e5} Select hunk"
            })
        end
    }
}

-- =============================================================================
-- GITSIGNS NOTES (UPDATED - gh prefix)
-- =============================================================================
-- Navigation:
-- ]c / [c     - Next/Previous hunk
-- ]H / [H     - Last/First hunk
--
-- Hunk Actions (gh prefix):
-- ghs         - Stage hunk (works in visual mode too!)
-- ghr         - Reset hunk (works in visual mode too!)
-- ghu         - Undo stage hunk
-- ghp         - Preview hunk (popup)
-- ghi         - Preview hunk inline
--
-- Buffer Actions:
-- ghS         - Stage entire buffer
-- ghR         - Reset entire buffer (discard all changes)
-- ghU         - Unstage entire buffer (reset index)
--
-- Diff:
-- ghd         - View diff in split
-- ghD         - Diff against previous commit (~)
--
-- Blame:
-- ghb         - Show git blame for line (popup)
-- ght         - Toggle inline blame for current line
--
-- Toggles:
-- ghx         - Toggle deleted lines visibility
--
-- Quickfix:
-- ghq         - Load all hunks into quickfix list
-- ghl         - Load all hunks into location list
--
-- Text Objects:
-- ih          - Hunk text object (use: dih, vih, yih, cih)
--
-- Workflow Examples:
-- 1. Stage specific lines: Select in visual mode → ghs
-- 2. Review changes: ghd (split diff) or ghp (popup)
-- 3. Undo mistake: ghu (after staging) or ghr (before staging)
-- 4. Delete a hunk: dih
-- 5. Stage entire file: ghS
-- 6. Find who changed line: ghb
-- =============================================================================