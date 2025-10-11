-- ~\AppData\Local\nvim\lua\myconfig\plugins\surround.lua
-- =============================================================================
-- NVIM-SURROUND - Surround Text Objects (NEW)
-- =============================================================================
-- Add, delete, change surrounding pairs (parentheses, brackets, quotes, tags)
-- =============================================================================
return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",

    config = function()
        require("nvim-surround").setup({
            -- ==========================================================================
            -- KEYMAPS
            -- ==========================================================================
            keymaps = {
                insert = "<C-g>s", -- Insert mode: <C-g>s
                insert_line = "<C-g>S", -- Insert mode: <C-g>S (whole line)
                normal = "ys", -- Normal mode: ys{motion}{char}
                normal_cur = "yss", -- Normal mode: yss{char} (whole line)
                normal_line = "yS", -- Normal mode: yS{motion}{char} (new line)
                normal_cur_line = "ySS", -- Normal mode: ySS{char} (whole line, new line)
                visual = "S", -- Visual mode: S{char}
                visual_line = "gS", -- Visual mode: gS{char} (new line)
                delete = "ds", -- Delete: ds{char}
                change = "cs", -- Change: cs{old}{new}
                change_line = "cS" -- Change line: cS{old}{new}
            },

            -- ==========================================================================
            -- SURROUNDS
            -- ==========================================================================
            surrounds = {
                -- Default surrounds (can be customized)
                -- () {} [] <> '' "" `` 
                -- HTML tags: t or < for <div>text</div>
                -- Function call: f for func(text)

                -- Custom surround examples:
                -- ["*"] = {
                --   add = { "**", "**" },
                --   find = "%*%*.-%*%*",
                --   delete = "^(%*%*)().-(%*%*)()$",
                -- },
            },

            -- ==========================================================================
            -- ALIASES
            -- ==========================================================================
            aliases = {
                ["a"] = ">", -- a = angle brackets
                ["b"] = ")", -- b = parentheses
                ["B"] = "}", -- B = braces
                ["r"] = "]", -- r = square brackets
                ["q"] = {'"', "'", "`"}, -- q = any quote
                ["s"] = {"}", "]", ")", ">", '"', "'", "`"} -- s = any surround
            },

            -- ==========================================================================
            -- HIGHLIGHT
            -- ==========================================================================
            highlight = {
                duration = 0 -- 0 = disable, or time in ms
            },

            -- ==========================================================================
            -- MOVE CURSOR
            -- ==========================================================================
            move_cursor = "begin", -- "begin" or "end" of inserted surround

            -- ==========================================================================
            -- INDENT
            -- ==========================================================================
            indent_lines = function(start, stop)
                local b = vim.bo
                -- Only indent if 'si' is true
                return b.autoindent or b.smartindent
            end
        })
    end
}

-- =============================================================================
-- NVIM-SURROUND NOTES
-- =============================================================================
-- What it does:
-- Manipulate surrounding pairs of characters (quotes, brackets, tags, etc.)
--
-- Three main operations:
-- 1. ADD surrounds     - ys{motion}{char}
-- 2. DELETE surrounds  - ds{char}
-- 3. CHANGE surrounds  - cs{old}{new}
--
-- =============================================================================
-- EXAMPLES
-- =============================================================================
--
-- ADD SURROUNDS (ys):
-- ───────────────────
-- Old text:         hello world
-- Command:          ysiw"        (ys + inner word + ")
-- New text:         "hello" world
--
-- Old text:         hello world
-- Command:          yss)         (yss + ) to surround line)
-- New text:         (hello world)
--
-- Old text:         hello world
-- Command:          ySS}         (ySS + } to surround line with newlines)
-- New text:         {
--                     hello world
--                   }
--
-- VISUAL MODE:
-- Old text:         select "this text" visually
-- Command:          S'           (visual select + S + ')
-- New text:         select 'this text' visually
--
-- DELETE SURROUNDS (ds):
-- ──────────────────────
-- Old text:         "hello world"
-- Command:          ds"          (delete surrounding ")
-- New text:         hello world
--
-- Old text:         (hello world)
-- Command:          ds)          (delete surrounding ())
-- New text:         hello world
--
-- Old text:         <div>hello</div>
-- Command:          dst          (delete surrounding tag)
-- New text:         hello
--
-- CHANGE SURROUNDS (cs):
-- ──────────────────────
-- Old text:         "hello world"
-- Command:          cs"'         (change " to ')
-- New text:         'hello world'
--
-- Old text:         (hello world)
-- Command:          cs){         (change () to {} with space)
-- New text:         { hello world }
--
-- Old text:         <div>hello</div>
-- Command:          cst<span>    (change tag to span)
-- New text:         <span>hello</span>
--
-- =============================================================================
-- COMMON SURROUNDS
-- =============================================================================
-- "  '  `    - Quotes
-- (  )       - Parentheses (with space when opening: ( vs ))
-- [  ]       - Square brackets
-- {  }       - Curly braces
-- <  >       - Angle brackets
-- t          - HTML/XML tags
-- f          - Function call
--
-- ALIASES (shortcuts):
-- b = )      - Parentheses
-- B = }      - Braces
-- r = ]      - Brackets
-- a = >      - Angle brackets
-- q = any quote
-- s = any surround
--
-- =============================================================================
-- ADVANCED EXAMPLES
-- =============================================================================
-- 1. Surround word with function call:
--    Old: number
--    Command: yswf  then type: print<CR>
--    New: print(number)
--
-- 2. Surround in quotes and change them:
--    Command: ysiw"  → "word"
--    Command: cs"'   → 'word'
--    Command: ds'    → word
--
-- 3. Surround line in block:
--    Command: ySS}
--    Result: {
--              line
--            }
--
-- 4. HTML tags:
--    Old: hello
--    Command: ysiwtdiv<CR>  (or ysiw<div><CR>)
--    New: <div>hello</div>
--
-- Tips:
-- - Use 'b' instead of ')' for quick parentheses
-- - Use 'B' instead of '}' for quick braces
-- - Use 'dst' to delete any HTML tag quickly
-- - Visual select + S is super powerful
-- - Combine with other text objects: cs"} → change quotes to braces
-- =============================================================================
