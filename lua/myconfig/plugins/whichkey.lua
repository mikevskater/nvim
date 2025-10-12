-- ~\AppData\Local\nvim\lua\myconfig\plugins\whichkey.lua
-- =============================================================================
-- WHICH-KEY - Keybinding Helper (UPDATED)
-- =============================================================================
-- Updated: Modern spec format, icons, presets, better layout
-- =============================================================================
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        -- ==========================================================================
        -- PRESET LAYOUT
        -- ==========================================================================
        -- "classic" - Traditional which-key layout
        -- "modern"  - Cleaner, more spacious layout
        -- "helix"   - Helix-editor style layout
        preset = "modern",

        -- ==========================================================================
        -- DELAY CONFIGURATION
        -- ==========================================================================
        -- Delay before showing popup (in ms)
        delay = function(ctx)
            return ctx.plugin and 0 or 200 -- No delay for plugins, 200ms for user
        end,

        -- ==========================================================================
        -- ICONS
        -- ==========================================================================
        icons = {
            breadcrumb = "\u{00bb}", -- »
            separator = " ", --"\u{27a1}", -- ➡
            group = "\u{002b}" -- +
        },

        -- ==========================================================================
        -- PLUGINS & PRESETS
        -- ==========================================================================
        plugins = {
            marks = true, -- Show marks in which-key
            registers = true, -- Show registers in which-key

            spelling = {
                enabled = true,
                suggestions = 20
            },

            -- Built-in help for common Vim bindings
            presets = {
                operators = true, -- Help for d, y, c, etc.
                motions = true, -- Help for w, b, e, etc.
                text_objects = true, -- Help for i, a text objects
                windows = true, -- Help for <C-w> bindings
                nav = true, -- Misc window navigation
                z = true, -- Bindings for folds, spelling, etc.
                g = true -- Bindings starting with g
            }
        },

        -- ==========================================================================
        -- WINDOW OPTIONS
        -- ==========================================================================
        win = {
            border = "rounded", -- rounded, single, double, shadow, none
            padding = {1, 2}, -- [top/bottom, left/right]
            title = true, -- Show title
            title_pos = "center", -- left, center, right
            zindex = 1000

            -- Window transparency (0-100)
            -- wo = {
            --   winblend = 10,
            -- },
        },

        -- ==========================================================================
        -- LAYOUT
        -- ==========================================================================
        layout = {
            width = {
                min = 20
            },
            spacing = 3 -- Spacing between columns
        },

        -- ==========================================================================
        -- KEY GROUP DEFINITIONS (NEW SPEC FORMAT)
        -- ==========================================================================
        spec = { -- File/Find operations (Telescope)
        {
            "<leader>f",
            group = "Find (Telescope)",
            icon = {
                icon = "\u{f002}", --  (search)
                color = "blue"
            }
        }, -- Git operations
        {
            "<leader>g",
            group = "Git",
            icon = {
                icon = "\u{f1d3}", --  (git logo)
                color = "orange"
            }
        }, -- Git hunks (from gitsigns)
        {
            "<leader>h",
            group = "Git Hunks",
            icon = {
                icon = "\u{f126}", --  (branch/fork)
                color = "orange"
            }
        }, -- Debug/Diagnostics
        {
            "<leader>d",
            group = "Debug/Diagnostics",
            icon = {
                icon = "\u{f1c0}", --  (database)
                color = "blue"
            }
        }, -- Code actions
        {
            "<leader>c",
            group = "Code",
            icon = {
                icon = "\u{f121}", --  (code)
                color = "cyan"
            }
        }, -- Buffer operations
        {
            "<leader>b",
            group = "Buffer",
            icon = {
                icon = "\u{f0c5}", --  (files)
                color = "yellow"
            }
        }, -- Window/split operations
        {
            "<leader>w",
            group = "Window",
            icon = {
                icon = "\u{f2d0}", --  (window)
                color = "green"
            }
        }, -- LSP operations
        {
            "<leader>l",
            group = "LSP",
            icon = {
                icon = "\u{f085}", --  (gears)
                color = "purple"
            }
        }, -- Individual key descriptions
        {
            mode = {"n", "v"},
            {
                "<leader>y",
                desc = "\u{f0c5} Yank to clipboard" --  (copy)
            },
            {
                "<leader>d",
                desc = "\u{f00d} Delete without yank" --  (delete)
            }
        }, -- Quick actions
        {
            "<leader><leader>",
            desc = "\u{f021} Source file" --  (refresh)
        }, {
            "<leader>q",
            desc = "\u{f2d1} Quit" --  (window close)
        }, {
            "<leader>w",
            desc = "\u{f0c7} Save file" --  (save)
        }, {
            "<leader>u",
            desc = "\u{f1da} Toggle undotree" --  (history)
        }, {
            "<leader>-",
            desc = "\u{f07c} Oil float" --  (folder open)
        }, {
            "-",
            desc = "\u{f115} Parent directory" --  (folder open outline)
        }}
    },

    -- ==========================================================================
    -- ADDITIONAL KEYBINDINGS
    -- ==========================================================================
    keys = {{
        "<leader>?",
        function()
            require("which-key").show({
                global = false
            })
        end,
        desc = "\u{f059} Buffer Local Keymaps" --  (question circle)
    }}
}

-- =============================================================================
-- WHICH-KEY NOTES (UPDATED)
-- =============================================================================
-- What's new in this configuration:
--
-- 1. MODERN SPEC FORMAT:
--    - Uses new table-based spec instead of old register() function
--    - More intuitive and easier to read
--    - Better integration with lazy.nvim
--
-- 2. ICONS:
--    - Custom icons for each key group
--    - Color-coded for visual distinction
--    - Requires a Nerd Font to display properly
--
-- 3. PRESETS:
--    - Built-in help for common Vim operators
--    - Help for text objects (i/a)
--    - Window management hints (<C-w>)
--    - Fold and spelling hints (z, g)
--
-- 4. MODERN LAYOUT:
--    - Cleaner, more spacious design
--    - Rounded borders
--    - Better readability
--
-- Usage:
-- - Press <leader> and wait - which-key shows options
-- - Type any partial key sequence to see completions
-- - Press <leader>? to see buffer-local keymaps
--
-- Available icons/colors:
-- - Colors: azure, blue, cyan, green, grey, orange, purple, red, yellow
-- - Icons: Any Nerd Font icon or emoji
--
-- To add your own groups:
-- Just add to the spec table:
-- {
--   "<leader>x",
--   group = "My Group",
--   icon = { icon = "⚡", color = "red" },
-- },
-- =============================================================================
