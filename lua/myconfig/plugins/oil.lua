-- ~\AppData\Local\nvim\lua\myconfig\plugins\oil.lua
-- =============================================================================
-- OIL.NVIM - File Explorer as Buffer (UPDATED)
-- =============================================================================
-- Added: Size/mtime/permissions columns, git integration, better float config
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
        -- COLUMNS TO DISPLAY (UPDATED)
        -- ==========================================================================
        columns = {"icon" -- "permissions",  -- Uncomment to show file permissions (rwxr-xr-x)
        -- "size",         -- Uncomment to show file size
        -- "mtime",        -- Uncomment to show last modified time
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

            -- Natural number sorting
            natural_order = "fast",

            -- Case insensitive sorting
            case_insensitive = false,

            sort = {{"type", "asc"}, -- Directories first
            {"name", "asc"} -- Then alphabetically
            }
        },

        -- ==========================================================================
        -- GIT INTEGRATION (EXPERIMENTAL - ADDED)
        -- ==========================================================================
        -- Automatically perform git operations when moving/deleting files
        git = {
            -- Auto git-add new files
            add = function(path)
                return false -- Set to true to enable
            end,

            -- Auto git-mv when moving files
            mv = function(src_path, dest_path)
                return false -- Set to true to enable
            end,

            -- Auto git-rm when deleting files
            rm = function(path)
                return false -- Set to true to enable
            end
        },

        -- ==========================================================================
        -- FLOATING WINDOW (UPDATED)
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
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash"
        },

        use_default_keymaps = true
    },

    config = function(_, opts)
        require("oil").setup(opts)

        -- ==========================================================================
        -- CUSTOM KEYBINDINGS
        -- ==========================================================================
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
            desc = "Open parent directory"
        })

        vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", {
            desc = "Open parent directory (float)"
        })
    end
}

-- =============================================================================
-- OIL.NVIM USAGE GUIDE (UPDATED)
-- =============================================================================
-- New features:
--
-- 1. ADDITIONAL COLUMNS (commented out by default):
--    Uncomment in columns section to enable:
--    - "permissions" - Shows rwxr-xr-x style permissions
--    - "size"        - Shows file size (bytes/KB/MB)
--    - "mtime"       - Shows last modified time
--
-- 2. GIT INTEGRATION (experimental):
--    Set to true to auto-perform git operations:
--    - git.add = true  → Auto git-add new files
--    - git.mv = true   → Auto git-mv moved files
--    - git.rm = true   → Auto git-rm deleted files
--
-- 3. ENHANCED FLOAT WINDOW:
--    - Larger max size (100x30)
--    - Rounded borders
--    - Better visibility
--
-- Basic usage:
-- -           - Open oil in current directory
-- <leader>-   - Open oil in floating window
--
-- Within oil:
-- <CR>        - Open file/directory
-- -           - Go to parent directory
-- _           - Go to working directory
-- g?          - Show help
-- g.          - Toggle hidden files
-- <C-p>       - Preview file
-- <C-s>       - Open in vertical split
-- <C-h>       - Open in horizontal split
-- <C-t>       - Open in new tab
--
-- File operations (like normal buffer):
-- dd          - Cut line (stage file for move/delete)
-- yy          - Yank line (copy file path)
-- p           - Paste (move/copy file)
-- R or cw     - Rename (edit the filename!)
-- :w          - Save changes (performs file operations)
--
-- Pro tips:
-- 1. Use visual mode to select multiple files
-- 2. Edit filenames like any text
-- 3. Create new files by adding lines
-- 4. Enable columns to see more file info
-- 5. Enable git integration if you use git
-- =============================================================================
