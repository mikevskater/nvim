-- ~\AppData\Local\nvim\lua\myconfig\plugins\bufferline.lua
-- =============================================================================
-- BUFFERLINE - Better Buffer Tabs
-- =============================================================================
-- Shows open buffers as tabs at the top, like browser tabs
-- =============================================================================
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons"},

    config = function()
        require("bufferline").setup({
            options = {
                -- ==========================================================================
                -- MODE
                -- ==========================================================================
                mode = "buffers", -- or "tabs"

                -- ==========================================================================
                -- STYLE
                -- ==========================================================================
                style_preset = require("bufferline").style_preset.default,
                -- Options: default, minimal, no_italic, no_bold

                -- Buffer close icon
                buffer_close_icon = "\u{f00d}", --  (close/X)
                modified_icon = "\u{f111}", --  (filled circle)
                close_icon = "\u{f00d}", -- 
                left_trunc_marker = "\u{f053}", --  (chevron left)
                right_trunc_marker = "\u{f054}", --  (chevron right)

                -- ==========================================================================
                -- NUMBERS
                -- ==========================================================================
                numbers = "none", -- "none", "ordinal", "buffer_id", "both"
                -- numbers = function(opts)
                --   return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
                -- end,

                -- ==========================================================================
                -- DIAGNOSTICS
                -- ==========================================================================
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict,
                    context)
                    local icons = {
                        error = "\u{f658}", --  (times circle)
                        warning = "\u{f071}" --  (warning triangle)
                    }
                    local icon = icons[level] or "\u{f05a}" --  (info)
                    return " " .. icon .. " " .. count
                end,

                -- ==========================================================================
                -- OFFSETS (for file explorers)
                -- ==========================================================================
                offsets = {{
                    filetype = "oil",
                    text = "\u{f115} File Explorer", --  (folder open)
                    text_align = "center",
                    separator = true
                }},

                -- ==========================================================================
                -- BEHAVIOR
                -- ==========================================================================
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,

                -- Persist buffer sort order
                persist_buffer_sort = true,

                -- Separator style
                separator_style = "thin", -- "slant", "slope", "thick", "thin", "padded_slant"

                -- Enforce regular tabs
                enforce_regular_tabs = false,
                always_show_bufferline = true,

                -- ==========================================================================
                -- SORTING
                -- ==========================================================================
                sort_by = "insert_after_current"
                -- Options: "insert_after_current", "insert_at_end", "id", "extension", 
                --          "relative_directory", "directory", "tabs"
            }

            -- ==========================================================================
            -- HIGHLIGHTS (optional custom colors)
            -- ==========================================================================
            -- highlights = {
            --   buffer_selected = {
            --     italic = false,
            --     bold = true,
            --   },
            -- },
        })

        -- ==========================================================================
        -- KEYBINDINGS
        -- ==========================================================================
        local keymap = vim.keymap.set

        -- Navigate buffers
        keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", {
            desc = "\u{f053} Previous buffer" --  (chevron left)
        })
        keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", {
            desc = "\u{f054} Next buffer" --  (chevron right)
        })

        -- Move buffers
        keymap("n", "<leader>bp", "<cmd>BufferLineMovePrev<cr>", {
            desc = "\u{f060} Move buffer left" --  (arrow left)
        })
        keymap("n", "<leader>bn", "<cmd>BufferLineMoveNext<cr>", {
            desc = "\u{f061} Move buffer right" --  (arrow right)
        })

        -- Pick buffer
        keymap("n", "<leader>bb", "<cmd>BufferLinePick<cr>", {
            desc = "\u{f002} Pick buffer" --  (search)
        })

        -- Close buffers
        keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", {
            desc = "\u{f00d} Pick buffer to close" --  (close)
        })
        keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", {
            desc = "\u{f060} Close buffers to left" --  (arrow left)
        })
        keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", {
            desc = "\u{f061} Close buffers to right" --  (arrow right)
        })

        -- Sort buffers
        keymap("n", "<leader>be", "<cmd>BufferLineSortByExtension<cr>", {
            desc = "\u{f0c9} Sort by extension" --  (align justify)
        })
        keymap("n", "<leader>bd", "<cmd>BufferLineSortByDirectory<cr>", {
            desc = "\u{f07b} Sort by directory" --  (folder)
        })
    end
}

-- =============================================================================
-- BUFFERLINE NOTES
-- =============================================================================
-- What it does:
-- - Shows all open buffers as tabs at the top
-- - Visual indicators for modified buffers (●)
-- - Shows LSP diagnostics in buffer tabs
-- - Can pick buffers with keyboard
--
-- Keybindings:
-- Shift+h / Shift+l   - Navigate to prev/next buffer
-- <leader>bb          - Pick a buffer (shows letters)
-- <leader>bc          - Pick buffer to close
-- <leader>bp/bn       - Move current buffer left/right
-- <leader>bh/bl       - Close all buffers to left/right
-- <leader>be/bd       - Sort by extension/directory
--
-- Visual features:
-- - Modified buffers show a dot (●)
-- - Active buffer is highlighted
-- - Diagnostics show in tabs (errors/warnings)
-- - File icons from nvim-web-devicons
--
-- Customization:
-- 1. Change separator style: separator_style = "slant"
-- 2. Show buffer numbers: numbers = "ordinal"
-- 3. Different style: style_preset = minimal
-- 4. Hide icons: show_buffer_icons = false
--
-- Notes:
-- - Works great with telescope for finding buffers
-- - Can be combined with lualine tabline (choose one)
-- - Integrates with Oil (offset when Oil is open)
-- =============================================================================
