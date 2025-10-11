-- ~\AppData\Local\nvim\lua\myconfig\plugins\oil.lua
-- =============================================================================
-- OIL.NVIM - File Explorer as Buffer
-- =============================================================================
-- Why oil.nvim? Edit your filesystem like a normal buffer
-- Use Vim motions to move/rename/delete files
-- Much more intuitive than traditional file trees
-- https://github.com/stevearc/oil.nvim
-- =============================================================================
return {
    "stevearc/oil.nvim",

    -- Dependencies (for file icons)
    dependencies = {"nvim-tree/nvim-web-devicons"},

    -- Don't lazy load (needed for directory navigation)
    lazy = false,

    -- Configuration
    opts = {
        -- ==========================================================================
        -- DEFAULT FILE EXPLORER
        -- ==========================================================================
        -- Replace netrw (Vim's built-in file explorer)
        default_file_explorer = true,

        -- ==========================================================================
        -- COLUMNS TO DISPLAY
        -- ==========================================================================
        -- What information to show for each file
        columns = {"icon" -- File type icon
        -- "permissions", -- Unix permissions (uncomment if needed)
        -- "size",        -- File size (uncomment if needed)
        -- "mtime",       -- Modified time (uncomment if needed)
        },

        -- ==========================================================================
        -- BUFFER OPTIONS
        -- ==========================================================================
        -- How the oil buffer behaves
        buf_options = {
            buflisted = false, -- Don't show in buffer list
            bufhidden = "hide" -- Hide when abandoned
        },

        -- ==========================================================================
        -- WINDOW OPTIONS
        -- ==========================================================================
        -- Split behavior when opening oil
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
        -- DELETE TO TRASH (safer than permanent delete)
        -- ==========================================================================
        delete_to_trash = true, -- Send to recycle bin instead of permanent delete

        -- ==========================================================================
        -- SKIP CONFIRMATION FOR SIMPLE OPERATIONS
        -- ==========================================================================
        skip_confirm_for_simple_edits = false, -- Always confirm changes

        -- ==========================================================================
        -- PROMPT TO SAVE CHANGES
        -- ==========================================================================
        prompt_save_on_select_new_entry = true, -- Save before navigating away

        -- ==========================================================================
        -- CLEANUP AFTER BUFFER CLOSE
        -- ==========================================================================
        cleanup_delay_ms = 2000, -- Clean up hidden buffers after 2 seconds

        -- ==========================================================================
        -- LSP FILE OPERATIONS
        -- ==========================================================================
        -- Experimental: Notify LSP of file operations (rename, move, etc.)
        lsp_file_methods = {
            timeout_ms = 1000,
            autosave_changes = false
        },

        -- ==========================================================================
        -- VIEW OPTIONS
        -- ==========================================================================
        view_options = {
            show_hidden = true, -- Show hidden files (dotfiles)
            is_hidden_file = function(name, bufnr)
                return vim.startswith(name, ".") -- Files starting with '.'
            end,
            is_always_hidden = function(name, bufnr)
                return false -- No files are permanently hidden
            end,
            sort = {{"type", "asc"}, -- Directories first
            {"name", "asc"} -- Then alphabetically
            }
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

        -- ==========================================================================
        -- USE DEFAULT KEYMAPS
        -- ==========================================================================
        use_default_keymaps = true
    },

    -- Additional setup after options
    config = function(_, opts)
        require("oil").setup(opts)

        -- ==========================================================================
        -- CUSTOM KEYBINDINGS
        -- ==========================================================================
        -- Open oil in current directory
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
            desc = "Open parent directory"
        })

        -- Open oil in float window
        vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", {
            desc = "Open parent directory (float)"
        })
    end
}

-- =============================================================================
-- OIL.NVIM USAGE GUIDE
-- =============================================================================
-- Open oil: Press '-' (opens parent directory)
--
-- Within oil buffer:
-- <CR>     - Open file/directory
-- -        - Go to parent directory
-- _        - Go to current working directory
-- g?       - Show help
-- g.       - Toggle hidden files
-- d        - Delete file (sends to trash)
-- yy       - Copy file path
-- p        - Paste (move/copy file)
--
-- File operations (like in normal buffer):
-- dd       - Cut line (stages file for move/delete)
-- yy       - Yank line (copy file path)
-- p        - Paste
-- R        - Rename (just edit the filename!)
-- :w       - Save changes (performs file operations)
--
-- Example workflow:
-- 1. Press '-' to open oil
-- 2. Navigate with j/k
-- 3. Press 'R' on a file to rename it (edit the text)
-- 4. Press ':w' to save (actually renames the file)
--
-- This is MUCH more intuitive than traditional file explorers!
-- =============================================================================
