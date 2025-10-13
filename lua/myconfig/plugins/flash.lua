-- ~\AppData\Local\nvim\lua\myconfig\plugins\flash.lua
-- =============================================================================
-- FLASH.NVIM - Enhanced Navigation (NEW)
-- =============================================================================
-- Jump anywhere in visible text with just a few keystrokes
-- Like vim-sneak/hop/leap but more powerful
-- =============================================================================
return {
    "folke/flash.nvim",
    event = "VeryLazy",

    opts = {
        -- ==========================================================================
        -- LABELS
        -- ==========================================================================
        -- Characters used for jump labels
        labels = "asdfghjklqwertyuiopzxcvbnm",

        -- ==========================================================================
        -- SEARCH
        -- ==========================================================================
        search = {
            -- Multi window search
            multi_window = true,

            -- Search in all windows or just current
            forward = true,
            wrap = true,

            -- Mode: "exact", "search", "fuzzy"
            mode = "exact",

            -- Incremental search
            incremental = false
        },

        -- ==========================================================================
        -- JUMP
        -- ==========================================================================
        jump = {
            -- Jump on partial input
            jumplist = true,

            -- Jump position
            pos = "start", -- "start", "end", "range"

            -- Add to jumplist
            history = false,

            -- Auto jump when only one match
            autojump = false
        },

        -- ==========================================================================
        -- LABEL
        -- ==========================================================================
        label = {
            -- Allow uppercase labels
            uppercase = true,

            -- Position of label
            after = true,
            before = false,

            -- Style
            style = "overlay", -- "inline", "overlay", "eol"

            -- Reuse labels across matches
            reuse = "lowercase" -- "all", "lowercase", "none"
        },

        -- ==========================================================================
        -- HIGHLIGHT
        -- ==========================================================================
        highlight = {
            -- Show backdrop
            backdrop = true,

            -- Highlight matches
            matches = true
        },

        -- ==========================================================================
        -- MODES
        -- ==========================================================================
        modes = {
            -- Search with s
            search = {
                enabled = true
            },

            -- Enhanced f/t motions
            char = {
                enabled = true,

                -- Keys for f/F/t/T
                keys = {"f", "F", "t", "T"},

                -- Character classes for easier targeting
                char_actions = function(motion)
                    return {
                        [";"] = "next", -- Next match
                        [","] = "prev", -- Previous match
                        [motion:lower()] = "next",
                        [motion:upper()] = "prev"
                    }
                end,

                -- Multi-line f/t
                multi_line = true,

                -- Labels for f/t when multiple matches
                label = {
                    exclude = "hjkliardc"
                }
            }
        },

        -- ==========================================================================
        -- PROMPT
        -- ==========================================================================
        prompt = {
            enabled = true,
            prefix = {{"\u{26a1}", "FlashPromptIcon"}} -- ⚡ (lightning bolt)
        }
    },

    -- ==========================================================================
    -- KEYBINDINGS
    -- ==========================================================================
    keys = { -- ======================================================================
    -- CORE FLASH MOTIONS
    -- ======================================================================
    {
        "s",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "\u{26a1} Flash Jump" -- ⚡
    }, {
        "S",
        mode = {"n", "x", "o"},
        function()
            require("flash").treesitter()
        end,
        desc = "\u{f1bb} Flash Treesitter" --  (tree)
    },

    -- ======================================================================
    -- REMOTE OPERATIONS (operator-pending & visual)
    -- ======================================================================
    {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "\u{f1e5} Remote Flash" --  (location arrow)
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "\u{f002} Treesitter Search" --  (search)
    },

    -- ======================================================================
    -- SEARCH INTEGRATION
    -- ======================================================================
    {
        "<c-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "\u{26a1} Toggle Flash Search" -- ⚡
    },

    -- ======================================================================
    -- EXTENDED ACTIONS (Power User Features)
    -- ======================================================================
    -- Jump to any line (like easymotion line jump)
    {
        "<leader>jl",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump({
                search = {
                    mode = "search",
                    max_length = 0
                },
                label = {
                    after = {0, 0}
                },
                pattern = "^"
            })
        end,
        desc = "\u{f0c9} Flash Line" --  (list)
    }, -- Jump to any word (useful for quick word navigation)
    {
        "<leader>jw",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump({
                pattern = ".", -- initialize with any char
                search = {
                    mode = function(pattern)
                        -- remove leading dot
                        if pattern:sub(1, 1) == "." then
                            pattern = pattern:sub(2)
                        end
                        -- return word pattern and proper skip pattern
                        return ([[\<%s\w*\>]]):format(pattern),
                            ([[\<%s]]):format(pattern)
                    end
                },
                -- select the range
                jump = {
                    pos = "range"
                }
            })
        end,
        desc = "\u{f031} Flash Word" --  (text)
    }, -- Continue last flash search
    {
        "<leader>jc",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump({
                continue = true
            })
        end,
        desc = "\u{f021} Flash Continue" --  (refresh/repeat)
    }, -- Jump to diagnostics (show diagnostic without moving permanently)
    {
        "<leader>jd",
        mode = "n",
        function()
            require("flash").jump({
                matcher = function(win)
                    ---@param diag Diagnostic
                    return vim.tbl_map(function(diag)
                        return {
                            pos = {diag.lnum + 1, diag.col},
                            end_pos = {diag.end_lnum + 1, diag.end_col - 1}
                        }
                    end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
                end,
                action = function(match, state)
                    vim.api.nvim_win_call(match.win, function()
                        vim.api.nvim_win_set_cursor(match.win, match.pos)
                        vim.diagnostic.open_float()
                    end)
                    state:restore()
                end
            })
        end,
        desc = "\u{f188} Flash Diagnostic" --  (bug)
    }}
}

-- =============================================================================
-- FLASH.NVIM NOTES
-- =============================================================================
-- What it does:
-- Flash lets you jump to any visible location with minimal keystrokes.
-- It's like a supercharged f/t motion or vim-sneak on steroids.
--
-- Usage:
--
-- 1. BASIC JUMP (s):
--    - Press 's' in normal mode
--    - Type 1-2 characters you want to jump to
--    - Labels appear on matches
--    - Press the label character to jump
--
-- 2. TREESITTER JUMP (S):
--    - Press 'S' in normal mode
--    - Jump to semantic units (functions, classes, etc.)
--    - Based on treesitter nodes
--
-- 3. ENHANCED f/t:
--    - f/F/t/T work like normal
--    - But show labels when multiple matches exist
--    - Press ; for next, , for previous
--    - Works across lines!
--
-- 4. REMOTE FLASH (r in operator-pending):
--    - Example: dr<motion> to delete remotely
--    - Select remote text without moving cursor
--
-- Examples:
-- s he<label>  - Jump to "he" text
-- S            - Jump to function/class
-- f(<label>    - Jump to next "(" (multi-line)
-- dr s wo      - Delete remotely to "wo"
--
-- Why use Flash?
-- - Faster than repeated w/b motions
-- - More precise than /search
-- - Works across windows
-- - Treesitter-aware
-- - Consistent muscle memory
--
-- Tips:
-- 1. Use 's' for quick jumps within visible text
-- 2. Use 'S' to jump to code blocks/functions
-- 3. f/t now work across lines - game changer!
-- 4. Combine with operators: ds<label>, cs<label>
--
-- vs. Other plugins:
-- - hop.nvim: Similar but Flash is more configurable
-- - leap.nvim: Flash has better treesitter integration
-- - vim-sneak: Flash has multi-window support
-- =============================================================================
