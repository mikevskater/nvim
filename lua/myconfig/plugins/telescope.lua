-- ~\AppData\Local\nvim\lua\myconfig\plugins\telescope.lua
-- =============================================================================
-- TELESCOPE - Fuzzy Finder (UPDATED)
-- =============================================================================
-- Added: telescope-fzf-native for 6x faster fuzzy matching performance
-- =============================================================================
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",

    -- Dependencies (other plugins this plugin needs)
    dependencies = {"nvim-lua/plenary.nvim", -- Required utility functions
    -- FZF native sorter for MUCH better performance
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- Build command - using Zig to compile the native library
        build = "cd build && zig build-lib -O ReleaseFast -dynamic -lc ../src/fzf.c && move /Y fzf.dll libfzf.dll"
    }},

    -- Configuration
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- Icons
                prompt_prefix = "\u{f002} ", --  (search/magnifying glass)
                selection_caret = "\u{f0da} ", --  (caret right)
                entry_prefix = "  ",
                multi_icon = "\u{f00c} ", --  (check)

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

                path_display = {"truncate"},
                file_ignore_patterns = {"node_modules", ".git/", "dist/",
                                        "build/", "target/"},

                -- Keymaps within Telescope
                mappings = {
                    i = { -- Insert mode
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist +
                            actions.open_qflist,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab
                    },
                    n = { -- Normal mode
                        ["q"] = actions.close
                    }
                }
            },

            pickers = {
                -- Customize individual pickers
                find_files = {
                    hidden = true, -- Show hidden files
                    follow = true -- Follow symbolic links
                },
                live_grep = {
                    additional_args = function()
                        return {"--hidden"} -- Search in hidden files
                    end
                }
            },

            -- Extension configuration
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                }
            }
        })

        -- ==========================================================================
        -- LOAD EXTENSIONS
        -- ==========================================================================
        -- Load fzf native extension for better performance
        telescope.load_extension("fzf")

        -- ==========================================================================
        -- TELESCOPE KEYBINDINGS
        -- ==========================================================================
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap.set

        -- File pickers
        keymap("n", "<leader>ff", builtin.find_files, {
            desc = "\u{f002} Find files" --  (search)
        })
        keymap("n", "<leader>fg", builtin.git_files, {
            desc = "\u{f1d3} Find git files" --  (git)
        })
        keymap("n", "<leader>fr", builtin.oldfiles, {
            desc = "\u{f1da} Find recent files" --  (history)
        })

        -- Search pickers
        keymap("n", "<leader>fw", builtin.live_grep, {
            desc = "\u{f1e5} Find word" --  (location arrow)
        })
        keymap("n", "<leader>fs", builtin.grep_string, {
            desc = "\u{f002} Find string" --  (search)
        })

        -- Buffer pickers
        keymap("n", "<leader>fb", builtin.buffers, {
            desc = "\u{f0c5} Find buffers" --  (files)
        })

        -- Help pickers
        keymap("n", "<leader>fh", builtin.help_tags, {
            desc = "\u{f059} Find help" --  (question circle)
        })
        keymap("n", "<leader>fk", builtin.keymaps, {
            desc = "\u{ea83} Find keymaps" --  (key)
        })

        -- Git pickers
        keymap("n", "<leader>fc", builtin.git_commits, {
            desc = "\u{f1d3} Find git commits" --  (git)
        })
        keymap("n", "<leader>ft", builtin.git_status, {
            desc = "\u{f126} Find git status" --  (branch)
        })

        -- Diagnostic pickers
        keymap("n", "<leader>fd", builtin.diagnostics, {
            desc = "\u{f658} Find diagnostics" --  (times circle)
        })
    end
}

-- =============================================================================
-- TELESCOPE NOTES
-- =============================================================================
-- Performance improvement with fzf-native:
-- - ~6x faster fuzzy matching compared to default
-- - Uses native C implementation
-- - Especially noticeable on large projects
--
-- Troubleshooting fzf-native on Windows:
-- 1. Make sure you have a C compiler (zig, MSVC, or MinGW)
-- 2. If build fails, try: :Lazy build telescope-fzf-native.nvim
-- 3. Check :checkhealth telescope
--
-- In Telescope window:
-- <C-j/k>    - Move up/down
-- <CR>       - Open file
-- <C-x>      - Open in horizontal split
-- <C-v>      - Open in vertical split
-- <C-t>      - Open in new tab
-- <C-q>      - Send to quickfix list
-- =============================================================================
