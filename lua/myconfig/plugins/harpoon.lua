-- ~\AppData\Local\nvim\lua\myconfig\plugins\harpoon.lua
-- =============================================================================
-- HARPOON - Quick File Navigation
-- =============================================================================
-- Why Harpoon? ThePrimeagen's plugin for marking and jumping to files
-- Perfect for working with 4-5 main files in a project
-- =============================================================================
return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {"nvim-lua/plenary.nvim"},

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- =============================================================================
        -- CORE OPERATIONS (Changed from <leader>a to <leader>ha, <C-e> to <leader>h)
        -- =============================================================================
        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, {
            desc = "\u{f02e} Add file" --  bookmark
        })

        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, {
            desc = "\u{f03a} Toggle Harpoon menu" --  list
        })

        -- =============================================================================
        -- NAVIGATION - Cycle through list
        -- =============================================================================
        vim.keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
        end, {
            desc = "\u{f060} Previous file" --  arrow left
        })

        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
        end, {
            desc = "\u{f061} Next file" --  arrow right
        })

        -- =============================================================================
        -- QUICK JUMP - Files 1-9 (Removed conflicting Ctrl bindings)
        -- =============================================================================
        -- Primary files (1-9) - leader-based for no conflicts
        vim.keymap.set("n", "<leader>h1", function()
            harpoon:list():select(1)
        end, {
            desc = "\u{2780} Harpoon File 1" -- ➀
        })

        vim.keymap.set("n", "<leader>h2", function()
            harpoon:list():select(2)
        end, {
            desc = "\u{2781} Harpoon File 2" -- ➁
        })

        vim.keymap.set("n", "<leader>h3", function()
            harpoon:list():select(3)
        end, {
            desc = "\u{2782} Harpoon File 3" -- ➂
        })

        vim.keymap.set("n", "<leader>h4", function()
            harpoon:list():select(4)
        end, {
            desc = "\u{2783} Harpoon File 4" -- ➃
        })

        vim.keymap.set("n", "<leader>h5", function()
            harpoon:list():select(5)
        end, {
            desc = "\u{2784} Harpoon File 5" -- ➄
        })

        vim.keymap.set("n", "<leader>h6", function()
            harpoon:list():select(6)
        end, {
            desc = "\u{2785} Harpoon File 6" -- ➅
        })

        vim.keymap.set("n", "<leader>h7", function()
            harpoon:list():select(7)
        end, {
            desc = "\u{2786} Harpoon File 7" -- ➆
        })

        vim.keymap.set("n", "<leader>h8", function()
            harpoon:list():select(8)
        end, {
            desc = "\u{2787} Harpoon File 8" -- ➇
        })

        vim.keymap.set("n", "<leader>h9", function()
            harpoon:list():select(9)
        end, {
            desc = "\u{2788} Harpoon File 9" -- ➈
        })
    end
}

-- =============================================================================
-- HARPOON USAGE (UPDATED)
-- =============================================================================
-- CORE:
-- <leader>ha      - Mark current file (changed from <leader>a)
-- <leader>h       - Open harpoon menu (changed from <C-e>)
--
-- NAVIGATION:
-- <leader>hp/hn   - Cycle prev/next in list
-- <leader>h1-9    - Jump to marked files 1-9 (removed conflicting Ctrl bindings)
--
-- IN MENU:
-- <C-v>           - Open in vertical split
-- <C-x>           - Open in horizontal split
-- <C-t>           - Open in new tab
--
-- WORKFLOW:
-- 1. Mark your main files with <leader>ha
-- 2. Toggle menu with <leader>h to see all marks
-- 3. Jump quickly with <leader>h1, <leader>h2, etc.
-- 4. Cycle through with <leader>hp and <leader>hn
-- =============================================================================