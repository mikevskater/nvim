-- ~\AppData\Local\nvim\lua\myconfig\plugins\bufferline.lua
-- =============================================================================
-- BUFFERLINE - Better Buffer Tabs (NEW)
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
                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",

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
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,

                -- ==========================================================================
                -- OFFSETS (for file explorers)
                -- ==========================================================================
                offsets = {{
                    filetype = "oil",
                    text = "File Explorer",
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
            desc = "Previous buffer"
        })
        keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", {
            desc = "Next buffer"
        })

        -- Move buffers
        keymap("n", "<leader>bp", "<cmd>BufferLineMovePrev<cr>", {
            desc = "Move buffer left"
        })
        keymap("n", "<leader>bn", "<cmd>BufferLineMoveNext<cr>", {
            desc = "Move buffer right"
        })

        -- Pick buffer
        keymap("n", "<leader>bb", "<cmd>BufferLinePick<cr>", {
            desc = "Pick buffer"
        })

        -- Close buffers
        keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", {
            desc = "Pick buffer to close"
        })
        keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", {
            desc = "Close buffers to left"
        })
        keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", {
            desc = "Close buffers to right"
        })

        -- Sort buffers
        keymap("n", "<leader>be", "<cmd>BufferLineSortByExtension<cr>", {
            desc = "Sort by extension"
        })
        keymap("n", "<leader>bd", "<cmd>BufferLineSortByDirectory<cr>", {
            desc = "Sort by directory"
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
