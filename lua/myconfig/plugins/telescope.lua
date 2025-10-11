-- ~\AppData\Local\nvim\lua\myconfig\plugins\telescope.lua
-- =============================================================================
-- TELESCOPE - Fuzzy Finder
-- =============================================================================
-- Why Telescope? THE fuzzy finder for Neovim
-- Find files, search text, browse git commits, and more
-- https://github.com/nvim-telescope/telescope.nvim
-- =============================================================================
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",

    -- Dependencies (other plugins this plugin needs)
    dependencies = {"nvim-lua/plenary.nvim" -- Required utility functions
    },

    -- Configuration
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- Layout
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                        results_width = 0.8
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120
                },

                -- Behavior
                prompt_prefix = " 🔍 ",
                selection_caret = "  ",
                path_display = {"truncate"}, -- Shorten long paths

                -- Keymaps within Telescope
                mappings = {
                    i = { -- Insert mode
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist +
                            actions.open_qflist
                    }
                }
            },

            pickers = {
                -- Customize individual pickers
                find_files = {
                    hidden = true, -- Show hidden files
                    -- Follow symbolic links
                    follow = true
                }
            }
        })

        -- ==========================================================================
        -- TELESCOPE KEYBINDINGS
        -- ==========================================================================
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap.set

        -- File pickers
        keymap("n", "<leader>ff", builtin.find_files, {
            desc = "Find files"
        })
        keymap("n", "<leader>fg", builtin.git_files, {
            desc = "Find git files"
        })
        keymap("n", "<leader>fr", builtin.oldfiles, {
            desc = "Find recent files"
        })

        -- Search pickers
        keymap("n", "<leader>fw", builtin.live_grep, {
            desc = "Find word (grep)"
        })
        keymap("n", "<leader>fs", builtin.grep_string, {
            desc = "Find string under cursor"
        })

        -- Buffer pickers
        keymap("n", "<leader>fb", builtin.buffers, {
            desc = "Find buffers"
        })

        -- Help pickers
        keymap("n", "<leader>fh", builtin.help_tags, {
            desc = "Find help"
        })
        keymap("n", "<leader>fk", builtin.keymaps, {
            desc = "Find keymaps"
        })

        -- Git pickers
        keymap("n", "<leader>fc", builtin.git_commits, {
            desc = "Find git commits"
        })
        keymap("n", "<leader>ft", builtin.git_status, {
            desc = "Find git status"
        })
    end
}

-- =============================================================================
-- TELESCOPE NOTES
-- =============================================================================
-- Requirements:
-- - ripgrep (for live_grep) - Install: winget install BurntSushi.ripgrep.MSVC
-- - fd (optional, for faster file finding) - Install: winget install sharkdp.fd
--
-- Useful commands:
-- :Telescope              - Show all pickers
-- :Telescope find_files   - Find files
-- :Telescope live_grep    - Search in files
-- :Telescope help_tags    - Search help
--
-- In Telescope window:
-- <C-j/k>    - Move up/down
-- <CR>       - Open file
-- <C-x>      - Open in horizontal split
-- <C-v>      - Open in vertical split
-- <C-t>      - Open in new tab
-- <C-q>      - Send to quickfix list
-- =============================================================================
