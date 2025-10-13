-- ~\AppData\Local\nvim\lua\myconfig\plugins\telescope.lua
-- =============================================================================
-- TELESCOPE - Fuzzy Finder (COMPLETE)
-- =============================================================================
-- All commonly-used pickers with fzf-native for 6x faster performance
-- =============================================================================
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",

    -- Dependencies
    dependencies = {"nvim-lua/plenary.nvim",
    -- FZF native sorter for better performance
                    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cd build && zig build-lib -O ReleaseFast -dynamic -lc ../src/fzf.c && move /Y fzf.dll libfzf.dll"
    }},

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- Icons
                prompt_prefix = "\u{f002} ",
                selection_caret = "\u{f0da} ",
                entry_prefix = "  ",
                multi_icon = "\u{f00c} ",

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
                winblend = 0,

                path_display = {"truncate"},
                file_ignore_patterns = {"node_modules", ".git/", "dist/",
                                        "build/", "target/"},

                -- Keymaps within Telescope
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist +
                            actions.open_qflist,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab
                    },
                    n = {
                        ["q"] = actions.close
                    }
                }
            },

            pickers = {
                find_files = {
                    hidden = true,
                    follow = true
                },
                live_grep = {
                    additional_args = function()
                        return {"--hidden"}
                    end
                }
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            }
        })

        -- Load extensions
        telescope.load_extension("fzf")

        -- ==========================================================================
        -- TELESCOPE KEYBINDINGS
        -- ==========================================================================
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap.set

        -- ==========================================================================
        -- FILE PICKERS
        -- ==========================================================================
        keymap("n", "<leader>ff", builtin.find_files, {
            desc = "\u{f002} Find files"
        })
        keymap("n", "<leader>fg", builtin.git_files, {
            desc = "\u{f1d3} Find git files"
        })
        keymap("n", "<leader>fr", builtin.oldfiles, {
            desc = "\u{f1da} Find recent files"
        })
        keymap("n", "<leader>fp", builtin.builtin, {
            desc = "\u{f1e5} Find pickers (all Telescope)"
        })

        -- ==========================================================================
        -- SEARCH PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fw", builtin.live_grep, {
            desc = "\u{f1e5} Find word (live grep)"
        })
        keymap("n", "<leader>fs", builtin.grep_string, {
            desc = "\u{f002} Find string under cursor"
        })
        keymap("n", "<leader>f.", builtin.current_buffer_fuzzy_find, {
            desc = "\u{f002} Find in current buffer"
        })

        -- ==========================================================================
        -- BUFFER PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fb", builtin.buffers, {
            desc = "\u{f0c5} Find buffers"
        })

        -- ==========================================================================
        -- HELP & DOCUMENTATION PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fh", builtin.help_tags, {
            desc = "\u{f059} Find help tags"
        })
        keymap("n", "<leader>fk", builtin.keymaps, {
            desc = "\u{ea83} Find keymaps"
        })
        keymap("n", "<leader>fM", builtin.man_pages, {
            desc = "\u{f02d} Find man pages"
        })

        -- ==========================================================================
        -- VIM INTERNALS PICKERS
        -- ==========================================================================
        keymap("n", "<leader>f:", builtin.command_history, {
            desc = "\u{f489} Find command history"
        })
        keymap("n", "<leader>f/", builtin.search_history, {
            desc = "\u{f002} Find search history"
        })
        keymap("n", "<leader>f\"", builtin.registers, {
            desc = "\u{f0c5} Find registers"
        })
        keymap("n", "<leader>fm", builtin.marks, {
            desc = "\u{f02e} Find marks"
        })
        keymap("n", "<leader>fj", builtin.jumplist, {
            desc = "\u{f0e2} Find jumplist"
        })
        keymap("n", "<leader>fo", builtin.vim_options, {
            desc = "\u{f013} Find vim options"
        })
        keymap("n", "<leader>fa", builtin.autocommands, {
            desc = "\u{f085} Find autocommands"
        })
        keymap("n", "<leader>fH", builtin.highlights, {
            desc = "\u{f043} Find highlight groups"
        })
        keymap("n", "<leader>fT", builtin.filetypes, {
            desc = "\u{f016} Find filetypes"
        })

        -- ==========================================================================
        -- QUICKFIX & LOCATION LIST PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fq", builtin.quickfix, {
            desc = "\u{f0cb} Find quickfix list"
        })
        keymap("n", "<leader>fl", builtin.loclist, {
            desc = "\u{f03a} Find location list"
        })

        -- ==========================================================================
        -- GIT PICKERS (Changed from <leader>g* to <leader>fg*)
        -- ==========================================================================
        keymap("n", "<leader>fgc", builtin.git_commits, {
            desc = "\u{f1d3} Find git commits"
        })
        keymap("n", "<leader>fgs", builtin.git_status, {
            desc = "\u{f126} Find git status"
        })
        keymap("n", "<leader>fgb", builtin.git_branches, {
            desc = "\u{f126} Find git branches"
        })
        keymap("n", "<leader>fgS", builtin.git_stash, {
            desc = "\u{f01c} Find git stash"
        })
        keymap("n", "<leader>fgC", builtin.git_bcommits, {
            desc = "\u{f1d3} Find buffer commits"
        })

        -- ==========================================================================
        -- LSP PICKERS
        -- ==========================================================================
        keymap("n", "<leader>ls", builtin.lsp_document_symbols, {
            desc = "\u{f121} Find LSP document symbols"
        })
        keymap("n", "<leader>lS", builtin.lsp_workspace_symbols, {
            desc = "\u{f1e5} Find LSP workspace symbols"
        })
        keymap("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, {
            desc = "\u{f002} Find LSP workspace (dynamic)"
        })
        keymap("n", "<leader>li", builtin.lsp_incoming_calls, {
            desc = "\u{f060} Find LSP incoming calls"
        })
        keymap("n", "<leader>lo", builtin.lsp_outgoing_calls, {
            desc = "\u{f061} Find LSP outgoing calls"
        })

        -- ==========================================================================
        -- DIAGNOSTIC PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fd", builtin.diagnostics, {
            desc = "\u{f658} Find diagnostics"
        })

        -- ==========================================================================
        -- MISC PICKERS
        -- ==========================================================================
        keymap("n", "<leader>fC", builtin.colorscheme, {
            desc = "\u{f043} Find colorscheme"
        })
        keymap("n", "<leader>ft", builtin.treesitter, {
            desc = "\u{f1bb} Find treesitter symbols"
        })

        -- Spell suggest (better than default z=)
        keymap("n", "z=", builtin.spell_suggest, {
            desc = "\u{f0eb} Spelling suggestions"
        })

        -- ==========================================================================
        -- RESUME LAST PICKER (CRITICAL!)
        -- ==========================================================================
        keymap("n", "<leader><leader>", builtin.resume, {
            desc = "\u{f021} Resume last Telescope picker"
        })
    end
}

-- =============================================================================
-- TELESCOPE USAGE NOTES (UPDATED)
-- =============================================================================
-- MOST IMPORTANT KEYBINDS:
-- <leader><leader> - Resume last picker (workflow game-changer!)
-- <leader>ff       - Find files
-- <leader>fw       - Live grep (search in files)
-- <leader>fb       - Find buffers
-- <leader>f.       - Search in current buffer
-- <leader>fp       - Show all Telescope pickers
-- <leader>f:       - Command history (huge time saver!)
--
-- WORKFLOW TIPS:
-- 1. Use <leader><leader> to resume your last search
-- 2. Use <C-q> to send results to quickfix list
-- 3. Use <Tab> to select multiple items
-- 4. Use <C-/> or ? to see all available actions
--
-- GIT WORKFLOW (MOVED TO <leader>fg prefix):
-- <leader>fgc - Browse commits with diff preview
-- <leader>fgs - Git status with staging
-- <leader>fgb - Checkout branches
-- <leader>fgS - Browse git stash
-- <leader>fgC - Buffer commits (file history)
--
-- LSP WORKFLOW:
-- <leader>ls - Browse symbols in current file
-- <leader>lS - Browse all workspace symbols
-- gr (LSP)   - Find references via Telescope
-- gd (LSP)   - Find definitions via Telescope
--
-- DEBUGGING AIDS:
-- <leader>fa - Browse autocommands
-- <leader>fq - Browse quickfix list
-- <leader>fd - Browse diagnostics
--
-- In Telescope window:
-- <C-j/k>    - Move up/down
-- <CR>       - Open file
-- <C-x>      - Open in horizontal split
-- <C-v>      - Open in vertical split
-- <C-t>      - Open in new tab
-- <C-q>      - Send to quickfix list
-- <Tab>      - Toggle selection (multi-select)
-- =============================================================================