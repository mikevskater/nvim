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
        -- CORE OPERATIONS
        -- =============================================================================
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, {
            desc = "\u{f02e} Add file" --  bookmark
        })

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, {
            desc = "\u{f03a} Toggle menu" --  list
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
        -- QUICK JUMP - Files 1-9
        -- =============================================================================
        -- Primary files (1-4) - using your existing Dvorak-friendly bindings
        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end, {
            desc = "\u{2780} File 1" -- ➀
        })

        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(2)
        end, {
            desc = "\u{2781} File 2" -- ➁
        })

        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(3)
        end, {
            desc = "\u{2782} File 3" -- ➂
        })

        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(4)
        end, {
            desc = "\u{2783} File 4" -- ➃
        })

        -- Extended files (5-9) - leader-based for larger projects
        vim.keymap.set("n", "<leader>h5", function()
            harpoon:list():select(5)
        end, {
            desc = "\u{2784} File 5" -- ➄
        })

        vim.keymap.set("n", "<leader>h6", function()
            harpoon:list():select(6)
        end, {
            desc = "\u{2785} File 6" -- ➅
        })

        vim.keymap.set("n", "<leader>h7", function()
            harpoon:list():select(7)
        end, {
            desc = "\u{2786} File 7" -- ➆
        })

        vim.keymap.set("n", "<leader>h8", function()
            harpoon:list():select(8)
        end, {
            desc = "\u{2787} File 8" -- ➇
        })

        vim.keymap.set("n", "<leader>h9", function()
            harpoon:list():select(9)
        end, {
            desc = "\u{2788} File 9" -- ➈
        })

        -- =============================================================================
        -- EXTEND - UI enhancements (open in splits/tabs)
        -- =============================================================================
        -- Add keymaps within the harpoon menu for split/vsplit/tab opening
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({
                        vsplit = true
                    })
                end, {
                    buffer = cx.bufnr,
                    desc = "\u{f338} Open in vsplit" --  columns
                })

                vim.keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({
                        split = true
                    })
                end, {
                    buffer = cx.bufnr,
                    desc = "\u{f0db} Open in split" --  rows
                })

                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({
                        tabedit = true
                    })
                end, {
                    buffer = cx.bufnr,
                    desc = "\u{f24d} Open in tab" --  clone
                })
            end
        })
    end
}

-- =============================================================================
-- HARPOON USAGE
-- =============================================================================
-- CORE:
-- <leader>a       - Mark current file
-- <C-e>           - Open harpoon menu
--
-- NAVIGATION:
-- <leader>hp/hn   - Cycle prev/next in list
-- <C-h/t/n/s>     - Jump to marked files 1-4 (Dvorak optimized)
-- <leader>h5-9    - Jump to marked files 5-9
--
-- IN MENU:
-- <C-v>           - Open in vertical split
-- <C-x>           - Open in horizontal split
-- <C-t>           - Open in new tab
-- =============================================================================
