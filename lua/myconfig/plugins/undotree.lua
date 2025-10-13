-- ~\AppData\Local\nvim\lua\myconfig\plugins\undotree.lua
-- =============================================================================
-- UNDOTREE - Visualize Undo History
-- =============================================================================
-- Shows undo history as a tree, travel through time in your file
-- Plugin: https://github.com/mbbill/undotree
-- =============================================================================
return {
    "mbbill/undotree",

    config = function()
        -- =======================================================================
        -- CONFIGURATION OPTIONS
        -- =======================================================================

        -- Window layout (1-4, see :h undotree_WindowLayout)
        vim.g.undotree_WindowLayout = 2 -- Diff panel at bottom

        -- Window dimensions
        vim.g.undotree_SplitWidth = 35
        vim.g.undotree_DiffpanelHeight = 12

        -- Auto-open diff panel
        vim.g.undotree_DiffAutoOpen = true

        -- Set focus when toggling
        vim.g.undotree_SetFocusWhenToggle = true

        -- Use relative timestamps (e.g., "5 minutes ago")
        vim.g.undotree_RelativeTimestamp = true

        -- Use short indicators (e.g., "5 m" instead of "5 minutes ago")
        vim.g.undotree_ShortIndicators = true

        -- Highlight changed text in diff
        vim.g.undotree_HighlightChangedText = true

        -- Show help line at top
        vim.g.undotree_HelpLine = true

        -- Tree appearance (Unicode box drawing characters)
        vim.g.undotree_TreeNodeShape = '●' -- Node indicator
        vim.g.undotree_TreeVertShape = '│' -- Vertical line
        vim.g.undotree_TreeSplitShape = '╱' -- Split branch
        vim.g.undotree_TreeReturnShape = '╲' -- Return branch

        -- =======================================================================
        -- KEYMAPS
        -- =======================================================================

        -- Primary toggle (following official documentation example)
        vim.keymap.set("n", "<F4>", vim.cmd.UndotreeToggle, {
            desc = "\u{f1da} Toggle undotree" --  (history icon)
        })

        -- Alternative leader-based toggle (your existing keymap)
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
            desc = "\u{f1da} Toggle undotree" --  (history icon)
        })

        -- Focus undotree window (if already open)
        vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus, {
            desc = "\u{f002} Focus undotree" --  (search/focus icon)
        })

        -- Show undotree state (info)
        vim.keymap.set("n", "<leader>us", function()
            vim.cmd("UndotreeShow")
        end, {
            desc = "\u{f06e} Show undotree" --  (eye icon)
        })

        -- Hide undotree (without toggling)
        vim.keymap.set("n", "<leader>uh", function()
            vim.cmd("UndotreeHide")
        end, {
            desc = "\u{f070} Hide undotree" --  (eye-slash icon)
        })
    end
}

-- =============================================================================
-- USAGE NOTES
-- =============================================================================
-- External Commands:
--   <F5> or <leader>u    Toggle undotree panel
--   <leader>uf           Focus undotree (if already open)
--   <leader>us           Show undotree
--   <leader>uh           Hide undotree
--
-- Inside Undotree Window (automatic, no config needed):
--   ?                    Show help
--   <Enter>              Restore to selected state
--   J / K                Navigate states
--   <C-n> / <C-p>        Navigate saved states
--   u / <C-r>            Undo / Redo
--   t                    Toggle timestamp format
--   D                    Toggle diff panel
--   q                    Quit undotree
--   :                    Clear history (with confirmation)
--
-- Persistent Undo (recommended):
--   Add to options.lua:
--   vim.opt.undofile = true
--   vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
-- =============================================================================
