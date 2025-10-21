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

        -- ==========================================================================
        -- NAVIGATION
        -- ==========================================================================
        -- Cycle through buffers (respects custom sort order)
        keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", {
            desc = "\u{f053} Previous buffer" --  (chevron left)
        })
        keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", {
            desc = "\u{f054} Next buffer" --  (chevron right)
        })

        -- Go to buffer by visible position (1-9, $ for last)
        keymap("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", {
            desc = "\u{f1c0} Go to buffer 1" --  (database/number)
        })
        keymap("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", {
            desc = "\u{f1c0} Go to buffer 2"
        })
        keymap("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", {
            desc = "\u{f1c0} Go to buffer 3"
        })
        keymap("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", {
            desc = "\u{f1c0} Go to buffer 4"
        })
        keymap("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", {
            desc = "\u{f1c0} Go to buffer 5"
        })
        keymap("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", {
            desc = "\u{f1c0} Go to buffer 6"
        })
        keymap("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", {
            desc = "\u{f1c0} Go to buffer 7"
        })
        keymap("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", {
            desc = "\u{f1c0} Go to buffer 8"
        })
        keymap("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", {
            desc = "\u{f1c0} Go to buffer 9"
        })
        keymap("n", "<leader>b$", "<cmd>BufferLineGoToBuffer -1<cr>", {
            desc = "\u{f061} Go to last buffer" --  (arrow right/end)
        })

        -- ==========================================================================
        -- BUFFER MANAGEMENT
        -- ==========================================================================
        -- Close current buffer without closing window
        keymap("n", "<leader>bd", "<cmd>bdelete!<cr>", {
            desc = "\u{f00d} Delete (close) buffer" --  (close/X)
        })
       
        -- Open new empty buffer
        keymap("n", "<leader>bn", "<cmd>enew<cr>", {
            desc = "\u{f0fe} New empty buffer" --  (file/new)
        })
 
        -- Open new empty buffer in a split window (vertically)
        keymap("n", "<leader>bN", "<cmd>vnew<cr>", {
            desc = "\u{f0fe} New empty buffer (split)" --  (file/new)
        })
        
        -- Move buffers (reorder in bufferline)
        keymap("n", "<leader>bmp", "<cmd>BufferLineMovePrev<cr>", {
            desc = "\u{f060} Move buffer left" --  (arrow left)
        })

        keymap("n", "<leader>bmn", "<cmd>BufferLineMoveNext<cr>", {
            desc = "\u{f061} Move buffer right" --  (arrow right)
        })

        -- Move to first/last position
        keymap("n", "<leader>bm1", function()
            require("bufferline").move_to(1)
        end, {
            desc = "\u{f04b} Move buffer to first" --  (play/first)
        })
        keymap("n", "<leader>bm$", function()
            require("bufferline").move_to(-1)
        end, {
            desc = "\u{f04e} Move buffer to last" --  (forward/last)
        })

        -- ==========================================================================
        -- PICKING (Interactive Selection)
        -- ==========================================================================
        keymap("n", "<leader>bb", "<cmd>BufferLinePick<cr>", {
            desc = "\u{f002} Pick buffer" --  (search)
        })
        keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", {
            desc = "\u{f00d} Pick buffer to close" --  (close)
        })

        -- ==========================================================================
        -- CLOSING BUFFERS
        -- ==========================================================================
        keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", {
            desc = "\u{f060} Close buffers to left" --  (arrow left)
        })
        keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", {
            desc = "\u{f061} Close buffers to right" --  (arrow right)
        })
        keymap("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", {
            desc = "\u{f24d} Close other buffers" --  (times circle/close all)
        })

        -- ==========================================================================
        -- PINNING
        -- ==========================================================================
        keymap("n", "<leader>bP", "<cmd>BufferLineTogglePin<cr>", {
            desc = "\u{f08d} Toggle pin buffer" --  (thumbtack/pin)
        })

        -- ==========================================================================
        -- SORTING
        -- ==========================================================================
        keymap("n", "<leader>be", "<cmd>BufferLineSortByExtension<cr>", {
            desc = "\u{f0c9} Sort by extension" --  (align justify)
        })
        keymap("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", {
            desc = "\u{f07b} Sort by directory" --  (folder)
        })
        keymap("n", "<leader>br", "<cmd>BufferLineSortByRelativeDirectory<cr>",
            {
                desc = "\u{f07c} Sort by relative directory" --  (folder open)
            })
        keymap("n", "<leader>bt", "<cmd>BufferLineSortByTabs<cr>", {
            desc = "\u{f009} Sort by tabs" --  (th-list)
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
-- - Pin important buffers to keep them visible
--
-- Keybindings:
-- NAVIGATION:
--   Shift+h / Shift+l     - Navigate to prev/next buffer (cycle)
--   <leader>b1-9          - Go to buffer by position (1st-9th visible)
--   <leader>b$            - Go to last visible buffer
--
-- MANAGEMENT:
--   <leader>bp/bn         - Move current buffer left/right
--   <leader>bm1/bm$       - Move buffer to first/last position
--   <leader>bP            - Toggle pin buffer (keeps it at start)
--
-- PICKING:
--   <leader>bb            - Pick a buffer (shows letters)
--   <leader>bc            - Pick buffer to close
--
-- CLOSING:
--   <leader>bh            - Close all buffers to left
--   <leader>bl            - Close all buffers to right
--   <leader>bo            - Close all other buffers
--
-- SORTING:
--   <leader>be            - Sort by extension
--   <leader>bd            - Sort by directory
--   <leader>br            - Sort by relative directory
--   <leader>bt            - Sort by tabs
--
-- Visual features:
-- - Modified buffers show a dot (●)
-- - Active buffer is highlighted
-- - Diagnostics show in tabs (errors/warnings)
-- - File icons from nvim-web-devicons
-- - Pinned buffers show at start with pin icon
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
-- - Pinned buffers persist across sessions (if sessionoptions+=globals)
-- - Go to buffer commands use visible position, not absolute buffer numbers
-- =============================================================================
