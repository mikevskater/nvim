-- ~\AppData\Local\nvim\lua\myconfig\plugins\indent-blankline.lua
-- =============================================================================
-- INDENT-BLANKLINE - Visual Indent Guides (NEW)
-- =============================================================================
-- Shows vertical lines for each indentation level
-- Helps visualize code structure
-- =============================================================================
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = {"BufReadPre", "BufNewFile"},

    opts = {
        -- ==========================================================================
        -- INDENT
        -- ==========================================================================
        indent = {
            -- Character to use for indent line
            char = "│", -- or "▏", "┊", "┆", "¦", "│"

            -- Highlight groups for each indent level
            -- highlight = {
            --   "IndentBlanklineIndent1",
            --   "IndentBlanklineIndent2",
            --   "IndentBlanklineIndent3",
            --   "IndentBlanklineIndent4",
            --   "IndentBlanklineIndent5",
            --   "IndentBlanklineIndent6",
            -- },

            -- Tab character
            tab_char = "│",

            -- Smart indent detection
            smart_indent_cap = true
        },

        -- ==========================================================================
        -- WHITESPACE
        -- ==========================================================================
        whitespace = {
            remove_blankline_trail = true
        },

        -- ==========================================================================
        -- SCOPE (current code block highlighting)
        -- ==========================================================================
        scope = {
            enabled = false -- Disable scope highlighting (can be distracting)

            -- If enabled, these options apply:
            -- char = "▎",
            -- show_start = true,
            -- show_end = false,
            -- highlight = "IblScope",
        },

        -- ==========================================================================
        -- EXCLUDE
        -- ==========================================================================
        exclude = {
            -- Filetypes to exclude
            filetypes = {"help", "alpha", "dashboard", "neo-tree", "Trouble",
                         "trouble", "lazy", "mason", "notify", "toggleterm",
                         "lazyterm"},

            -- Buffer types to exclude
            buftypes = {"terminal", "nofile", "quickfix", "prompt"}
        }
    },

    config = function(_, opts)
        require("ibl").setup(opts)
    end
}

-- =============================================================================
-- INDENT-BLANKLINE NOTES
-- =============================================================================
-- What it does:
-- Shows vertical lines at each indentation level, making it easier to see
-- code structure and nesting depth.
--
-- Features:
-- 1. Shows indent guides for all indentation levels
-- 2. Works with spaces and tabs
-- 3. Respects your colorscheme
-- 4. Minimal performance impact
--
-- Customization:
--
-- 1. DIFFERENT CHARACTER:
--    Change indent.char to:
--    - "│"  - Solid line (default)
--    - "▏"  - Thin line
--    - "┊"  - Dotted line
--    - "┆"  - Dashed line
--    - "¦"  - Broken line
--
-- 2. ENABLE SCOPE HIGHLIGHTING:
--    Set scope.enabled = true to highlight the current code block
--    (function, if statement, etc.)
--
-- 3. RAINBOW INDENTS:
--    Uncomment the highlight section in indent to get different colors
--    for each indent level (requires setting up highlight groups)
--
-- 4. DIFFERENT TAB CHARACTER:
--    Change indent.tab_char to use a different character for tabs
--
-- Performance:
-- - Very lightweight, uses extmarks
-- - Only renders visible lines
-- - Automatically updates on text changes
--
-- Comparison with other plugins:
-- - vs indentLine: indent-blankline is faster and has more features
-- - vs mini.indentscope: indent-blankline is more configurable
--
-- Tips:
-- 1. Works great with treesitter context (shows what block you're in)
-- 2. Pair with rainbow-delimiters for maximum code clarity
-- 3. If guides are too bright, adjust highlight colors in colorscheme
-- 4. Enable scope highlighting temporarily when navigating complex code
--
-- Troubleshooting:
-- - Lines not showing? Check if filetype is excluded
-- - Performance issues? Disable scope highlighting
-- - Want colored guides? Set up rainbow indent highlights
-- =============================================================================
