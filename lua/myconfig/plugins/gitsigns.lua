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
                text = "\u{2503}" -- ┃ (thick vertical line)
            },
            change = {
                text = "\u{2503}" -- ┃
            },
            delete = {
                text = "\u{2581}" -- ▁ (lower block)
            },
            topdelete = {
                text = "\u{2594}" -- ▔ (upper block)
            },
            changedelete = {
                text = "\u{2503}" -- ┃
            },
            untracked = {
                text = "\u{2507}" -- ┇ (dotted vertical line)
            }
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local keymap = vim.keymap.set

            -- Navigation
            keymap('n', ']c', gs.next_hunk, {
                buffer = bufnr,
                desc = "\u{f063} Next git hunk" --  (arrow down)
            })
            keymap('n', '[c', gs.prev_hunk, {
                buffer = bufnr,
                desc = "\u{f062} Previous git hunk" --  (arrow up)
            })

            -- Actions
            keymap('n', '<leader>hs', gs.stage_hunk, {
                buffer = bufnr,
                desc = "\u{f067} Stage hunk" --  (plus)
            })
            keymap('n', '<leader>hr', gs.reset_hunk, {
                buffer = bufnr,
                desc = "\u{f0e2} Reset hunk" --  (undo)
            })
            keymap('n', '<leader>hp', gs.preview_hunk, {
                buffer = bufnr,
                desc = "\u{f06e} Preview hunk" --  (eye)
            })
            keymap('n', '<leader>hb', gs.blame_line, {
                buffer = bufnr,
                desc = "\u{f1d3} Blame line" --  (git)
            })
        end
    }
}
