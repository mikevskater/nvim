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
            -- HUNK ACTIONS
            -- ==========================================================================

            -- Stage hunk (normal mode)
            keymap('n', '<leader>hs', gs.stage_hunk, {
                buffer = bufnr,
                desc = "\u{f067} Stage hunk" -- +
            })

            -- Stage hunk (visual mode - stage selected lines)
            keymap('v', '<leader>hs', function()
                gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
            end, {
                buffer = bufnr,
                desc = "\u{f067} Stage hunk"
            })

            -- Reset hunk (normal mode)
            keymap('n', '<leader>hr', gs.reset_hunk, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset hunk" -- ↻
            })

            -- Reset hunk (visual mode - reset selected lines)
            keymap('v', '<leader>hr', function()
                gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
            end, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset hunk"
            })

            -- Undo stage hunk
            keymap('n', '<leader>hu', gs.undo_stage_hunk, {
                buffer = bufnr,
                desc = "\u{f0e2} Undo stage hunk" -- ↻
            })

            -- ==========================================================================
            -- BUFFER ACTIONS
            -- ==========================================================================

            -- Stage entire buffer
            keymap('n', '<leader>hS', gs.stage_buffer, {
                buffer = bufnr,
                desc = "\u{f067} Stage buffer" -- +
            })

            -- Reset entire buffer
            keymap('n', '<leader>hR', gs.reset_buffer, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset buffer" -- ↻
            })

            -- Reset buffer index (unstage all)
            keymap('n', '<leader>hU', gs.reset_buffer_index, {
                buffer = bufnr,
                desc = "\u{f0e2} Unstage buffer" -- ↻
            })

            -- ==========================================================================
            -- PREVIEW & DIFF
            -- ==========================================================================

            -- Preview hunk (popup)
            keymap('n', '<leader>hp', gs.preview_hunk, {
                buffer = bufnr,
                desc = "\u{f06e} Preview hunk" -- 👁
            })

            -- Preview hunk inline
            keymap('n', '<leader>hi', gs.preview_hunk_inline, {
                buffer = bufnr,
                desc = "\u{f06e} Preview hunk inline"
            })

            -- Diff this (split view)
            keymap('n', '<leader>hd', gs.diffthis, {
                buffer = bufnr,
                desc = "\u{f1e5} Diff this" -- 
            })

            -- Diff against previous revision
            keymap('n', '<leader>hD', function()
                gs.diffthis('~')
            end, {
                buffer = bufnr,
                desc = "\u{f1e5} Diff against ~"
            })

            -- ==========================================================================
            -- BLAME
            -- ==========================================================================

            -- Show blame line (popup with full info)
            keymap('n', '<leader>hb', function()
                gs.blame_line({
                    full = true
                })
            end, {
                buffer = bufnr,
                desc = "\u{f1d3} Blame line" -- 
            })

            -- Toggle current line blame (inline virtual text)
            keymap('n', '<leader>tb', gs.toggle_current_line_blame, {
                buffer = bufnr,
                desc = "\u{f1d3} Toggle line blame"
            })

            -- ==========================================================================
            -- TOGGLES
            -- ==========================================================================

            -- Toggle deleted lines view
            keymap('n', '<leader>td', gs.toggle_deleted, {
                buffer = bufnr,
                desc = "\u{f06e} Toggle deleted" -- 👁
            })

            -- ==========================================================================
            -- QUICKFIX / LOCATION LIST
            -- ==========================================================================

            -- Load all hunks into quickfix list
            keymap('n', '<leader>hq', function()
                gs.setqflist('all')
            end, {
                buffer = bufnr,
                desc = "\u{f03a} Hunks to quickfix" -- ≡
            })

            -- Load all hunks into location list
            keymap('n', '<leader>hl', function()
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
-- GITSIGNS NOTES
-- =============================================================================
-- Navigation:
-- ]c / [c     - Next/Previous hunk
-- ]H / [H     - Last/First hunk
--
-- Hunk Actions:
-- <leader>hs  - Stage hunk (works in visual mode too!)
-- <leader>hr  - Reset hunk (works in visual mode too!)
-- <leader>hu  - Undo stage hunk
-- <leader>hp  - Preview hunk (popup)
-- <leader>hi  - Preview hunk inline
--
-- Buffer Actions:
-- <leader>hS  - Stage entire buffer
-- <leader>hR  - Reset entire buffer (discard all changes)
-- <leader>hU  - Unstage entire buffer (reset index)
--
-- Diff:
-- <leader>hd  - View diff in split
-- <leader>hD  - Diff against previous commit (~)
--
-- Blame:
-- <leader>hb  - Show git blame for line (popup)
-- <leader>tb  - Toggle inline blame for current line
--
-- Toggles:
-- <leader>td  - Toggle deleted lines visibility
--
-- Quickfix:
-- <leader>hq  - Load all hunks into quickfix list
-- <leader>hl  - Load all hunks into location list
--
-- Text Objects:
-- ih          - Hunk text object (use: dih, vih, yih, cih)
--
-- Workflow Examples:
-- 1. Stage specific lines: Select in visual mode → <leader>hs
-- 2. Review changes: <leader>hd (split diff) or <leader>hp (popup)
-- 3. Undo mistake: <leader>hu (after staging) or <leader>hr (before staging)
-- 4. Delete a hunk: dih
-- 5. Stage entire file: <leader>hS
-- 6. Find who changed line: <leader>hb
-- =============================================================================
