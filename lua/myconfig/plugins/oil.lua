-- ~\AppData\Local\nvim\lua\myconfig\plugins\oil.lua
-- =============================================================================
-- OIL.NVIM - File Explorer as Buffer (UPDATED)
-- =============================================================================
-- Added: Common keymaps (Esc, q, detail toggle), better documentation
-- =============================================================================
return {
    "stevearc/oil.nvim",

    dependencies = {"nvim-tree/nvim-web-devicons"},

    lazy = false,

    opts = {
        -- ==========================================================================
        -- DEFAULT FILE EXPLORER
        -- ==========================================================================
        default_file_explorer = true,

        -- ==========================================================================
        -- COLUMNS TO DISPLAY
        -- ==========================================================================
        columns = {"icon"
        -- Uncomment for detail view (toggle with 'gd' in Oil):
        -- "permissions",
        -- "size",
        -- "mtime",
        },

        -- ==========================================================================
        -- BUFFER OPTIONS
        -- ==========================================================================
        buf_options = {
            buflisted = false,
            bufhidden = "hide"
        },

        -- ==========================================================================
        -- WINDOW OPTIONS
        -- ==========================================================================
        win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic"
        },

        -- ==========================================================================
        -- DELETE TO TRASH
        -- ==========================================================================
        delete_to_trash = true,

        -- ==========================================================================
        -- CONFIRMATION
        -- ==========================================================================
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,

        -- ==========================================================================
        -- CLEANUP
        -- ==========================================================================
        cleanup_delay_ms = 2000,

        -- ==========================================================================
        -- LSP FILE OPERATIONS
        -- ==========================================================================
        lsp_file_methods = {
            timeout_ms = 1000,
            autosave_changes = false
        },

        -- ==========================================================================
        -- VIEW OPTIONS
        -- ==========================================================================
        view_options = {
            show_hidden = true,

            is_hidden_file = function(name, bufnr)
                return vim.startswith(name, ".")
            end,

            is_always_hidden = function(name, bufnr)
                return false
            end,

            natural_order = "fast",
            case_insensitive = false,

            sort = {{"type", "asc"}, {"name", "asc"}}
        },

        -- ==========================================================================
        -- GIT INTEGRATION (EXPERIMENTAL)
        -- ==========================================================================
        git = {
            add = function(path)
                return false
            end,
            mv = function(src_path, dest_path)
                return false
            end,
            rm = function(path)
                return false
            end
        },

        -- ==========================================================================
        -- FLOATING WINDOW
        -- ==========================================================================
        float = {
            padding = 2,
            max_width = 100,
            max_height = 30,
            border = "rounded",
            win_options = {
                winblend = 0
            }
        },

        -- ==========================================================================
        -- PROGRESS WINDOW
        -- ==========================================================================
        progress = {
            max_width = 0.9,
            min_width = {40, 0.4},
            width = nil,
            max_height = {10, 0.9},
            min_height = {5, 0.1},
            height = nil,
            border = "rounded",
            minimized_border = "none",
            win_options = {
                winblend = 0
            }
        },

        -- ==========================================================================
        -- SSH WINDOW
        -- ==========================================================================
        ssh = {
            border = "rounded"
        },

        -- ==========================================================================
        -- KEYMAPS HELP WINDOW
        -- ==========================================================================
        keymaps_help = {
            border = "rounded"
        },

        -- ==========================================================================
        -- KEYMAPS (within oil buffer)
        -- ==========================================================================
        keymaps = {
            -- =======================================================================
            -- HELP
            -- =======================================================================
            ["g?"] = "actions.show_help",

            -- =======================================================================
            -- FILE OPERATIONS (Select/Open)
            -- =======================================================================
            ["<CR>"] = "actions.select",
            ["<C-s>"] = {
                "actions.select",
                opts = {vertical = true}
            },
            ["<C-v>"] = { -- ADDED: Alternative vertical split (more common)
                "actions.select",
                opts = {vertical = true},
                desc = "Open in vertical split"
            },
            ["<C-h>"] = {
                "actions.select",
                opts = {horizontal = true}
            },
            ["<C-x>"] = { -- ADDED: Alternative horizontal split (more common)
                "actions.select",
                opts = {horizontal = true},
                desc = "Open in horizontal split"
            },
            ["<C-t>"] = {
                "actions.select",
                opts = {tab = true}
            },

            -- =======================================================================
            -- PREVIEW & CLOSE
            -- =======================================================================
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = {
                "actions.close",
                mode = "n"
            },
            ["<Esc>"] = { -- ADDED: Quick close (common convention)
                "actions.close",
                mode = "n",
                desc = "Close Oil"
            },
            ["q"] = { -- ADDED: Vim convention for closing special buffers
                "actions.close",
                mode = "n",
                desc = "Close Oil"
            },

            -- =======================================================================
            -- NAVIGATION
            -- =======================================================================
            ["-"] = {
                "actions.parent",
                mode = "n"
            },
            ["_"] = {
                "actions.open_cwd",
                mode = "n"
            },

            -- =======================================================================
            -- DIRECTORY OPERATIONS
            -- =======================================================================
            ["`"] = {
                "actions.cd",
                mode = "n"
            },
            ["~"] = {
                "actions.cd",
                opts = {scope = "tab"},
                mode = "n"
            },

            -- =======================================================================
            -- VIEW OPTIONS
            -- =======================================================================
            ["<C-l>"] = "actions.refresh",
            ["gs"] = {
                "actions.change_sort",
                mode = "n"
            },
            ["g."] = {
                "actions.toggle_hidden",
                mode = "n"
            },
            ["g\\"] = {
                "actions.toggle_trash",
                mode = "n"
            },
            ["gd"] = { -- ADDED: Toggle detail view (popular recipe)
                desc = "Toggle file detail view",
                callback = function()
                    local oil = require("oil")
                    local config = require("oil.config")
                    if #config.columns == 1 then
                        oil.set_columns({"icon", "permissions", "size", "mtime"})
                    else
                        oil.set_columns({"icon"})
                    end
                end
            },

            -- =======================================================================
            -- EXTERNAL
            -- =======================================================================
            ["gx"] = "actions.open_external"
        },

        use_default_keymaps = true
    },

    config = function(_, opts)
        require("oil").setup(opts)

        -- ==========================================================================
        -- GLOBAL KEYBINDINGS (outside Oil buffer)
        -- ==========================================================================
        
        -- Open Oil in parent directory of current file
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
            desc = "\u{f07c} Open parent directory" --  (folder open)
        })
    end
}

-- =============================================================================
-- OIL.NVIM USAGE GUIDE (UPDATED)
-- =============================================================================
-- CRITICAL WORKFLOW:
-- Oil is a BUFFER, not a file tree! Edit like any buffer, then :w to save.
--
-- Basic usage:
-- -           - Open oil in current file's directory
-- <leader>-   - Open oil in floating window
-- <leader>o   - Open oil (alternative)
-- <leader>O   - Open oil in working directory
--
-- Within Oil buffer:
-- =================
-- 
-- FILE SELECTION:
-- <CR>        - Open file/directory
-- <C-v>       - Open in vertical split
-- <C-x>       - Open in horizontal split
-- <C-t>       - Open in new tab
-- <C-p>       - Preview file
--
-- NAVIGATION:
-- -           - Go to parent directory
-- _           - Go to CWD
-- `           - CD to directory under cursor
-- ~           - CD to directory under cursor (tab-local)
--
-- VIEW CONTROLS:
-- <C-l>       - Refresh
-- g.          - Toggle hidden files
-- gd          - Toggle detail view (size/mtime/permissions)
-- gs          - Change sort order
-- g\          - Toggle trash view
-- g?          - Show help
--
-- CLOSING:
-- q           - Close Oil buffer
-- <Esc>       - Close Oil buffer
-- <C-c>       - Close Oil buffer
--
-- FILE OPERATIONS (Use normal Vim commands!):
-- ====================
-- dd          - Cut file (delete line)
-- yy          - Copy file (yank line)
-- p           - Paste file (paste line)
-- cw / R      - Rename file (change word / replace)
-- o           - Create new file below (new line)
-- O           - Create new file above
-- I           - Edit at start of filename
-- A           - Edit at end of filename
-- :w          - **SAVE CHANGES** (This actually performs the operations!)
-- :q!         - Discard all changes
--
-- IMPORTANT NOTES:
-- 1. Changes are NOT saved until you :w
-- 2. You can undo with 'u' before saving
-- 3. Visual mode works! Select multiple files with V
-- 4. Use dd/yy/p across different Oil buffers for cross-directory operations
-- 5. Oil respects your trash settings (delete_to_trash = true)
--
-- Advanced:
-- - Open multiple Oil buffers in splits for drag-and-drop style operations
-- - Use visual-block mode (Ctrl+V) for bulk operations
-- - Combine with macros for repetitive file operations
-- =============================================================================