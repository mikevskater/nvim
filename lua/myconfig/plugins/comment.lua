-- ~\AppData\Local\nvim\lua\myconfig\plugins\comment.lua
-- =============================================================================
-- COMMENT.NVIM - Smart Commenting
-- =============================================================================
-- Powerful commenting plugin with treesitter support, motions, and text objects
-- Repository: https://github.com/numToStr/Comment.nvim
-- =============================================================================
return {
    "numToStr/Comment.nvim",
    event = {"BufReadPost", "BufNewFile"},

    opts = {
        -- ==========================================================================
        -- BASIC CONFIGURATION
        -- ==========================================================================

        -- Add a space between comment and the line
        padding = true,

        -- Whether the cursor should stay at its position
        sticky = true,

        -- Lines to be ignored while (un)comment (lua regex)
        -- Example: ignore = '^$' (ignores empty lines)
        ignore = nil,

        -- ==========================================================================
        -- TOGGLE MAPPINGS (NORMAL MODE)
        -- ==========================================================================
        toggler = {
            ---Line-comment toggle keymap
            line = 'gcc', --  Toggle current line (linewise)

            ---Block-comment toggle keymap
            block = 'gbc' --  Toggle current line (blockwise)
        },

        -- ==========================================================================
        -- OPERATOR-PENDING MAPPINGS (NORMAL + VISUAL MODE)
        -- ==========================================================================
        opleader = {
            ---Line-comment keymap
            line = 'gc', --  gc{motion} - Comment with motion (gcw, gc$, gcip, etc.)

            ---Block-comment keymap
            block = 'gb' --  gb{motion} - Block comment with motion (gb2j, gbaf, etc.)
        },

        -- ==========================================================================
        -- EXTRA MAPPINGS (INSERT COMMENTS + ENTER INSERT MODE)
        -- ==========================================================================
        extra = {
            ---Add comment on the line above
            above = 'gcO', --  Comment above and enter INSERT

            ---Add comment on the line below
            below = 'gco', --  Comment below and enter INSERT

            ---Add comment at the end of line
            eol = 'gcA' -- ﰉ Comment at end of line and enter INSERT
        },

        -- ==========================================================================
        -- KEYBINDING TOGGLES
        -- ==========================================================================
        mappings = {
            ---Operator-pending mapping
            ---Includes: gcc, gbc, gc[count]{motion}, gb[count]{motion}
            basic = true,

            ---Extra mapping
            ---Includes: gco, gcO, gcA
            extra = true
        },

        -- ==========================================================================
        -- HOOKS (ADVANCED)
        -- ==========================================================================
        -- Function to call before (un)comment
        pre_hook = nil,

        -- Function to call after (un)comment
        post_hook = nil
    }
}

-- =============================================================================
-- USAGE EXAMPLES
-- =============================================================================
--
-- LINEWISE COMMENTS (gc):
-- -----------------------
-- gcc           - Toggle comment on current line
-- gc{motion}    - Comment using motion:
--   gcw         - Comment from cursor to next word
--   gc$         - Comment from cursor to end of line
--   gc}         - Comment until next blank line
--   gc5j        - Comment 5 lines down
--   gc8k        - Comment 8 lines up
--   gcip        - Comment inside paragraph
--   gca}        - Comment around curly brackets
-- [count]gcc    - Comment N lines (e.g., 3gcc comments 3 lines)
--
-- In VISUAL mode:
-- gc            - Toggle comment on selection
--
-- BLOCKWISE COMMENTS (gb):
-- ------------------------
-- gbc           - Toggle block comment on current line
-- gb{motion}    - Block comment using motion:
--   gb2j        - Block comment 2 lines down
--   gb}         - Block comment until next blank line
--   gbaf        - Block comment around function (treesitter)
--   gbac        - Block comment around class (treesitter)
-- [count]gbc    - Block comment N lines
--
-- In VISUAL mode:
-- gb            - Toggle block comment on selection
--
-- EXTRA MAPPINGS:
-- ---------------
-- gco           - Insert comment below and enter INSERT mode
-- gcO           - Insert comment above and enter INSERT mode
-- gcA           - Insert comment at end of line and enter INSERT mode
--
-- =============================================================================
-- NOTES
-- =============================================================================
-- • Supports treesitter for context-aware commenting
-- • Supports commentstring for all filetypes
-- • Dot (.) repeat support for gcc, gbc, and all motions
-- • Count support: [count]gcc and [count]gbc
-- • Works with text objects (gci{, gbat, etc.)
-- • For JSX/TSX support, integrate nvim-ts-context-commentstring via pre_hook
--
-- See :h comment-nvim for full documentation
-- =============================================================================
