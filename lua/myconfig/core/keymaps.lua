-- ~\AppData\Local\nvim\lua\myconfig\core\keymaps.lua
-- =============================================================================
-- SHARED KEYMAPS - Works in Both Standalone and VSCode
-- =============================================================================
-- These keymaps work well in both environments
-- VSCode-specific keymaps are in vscode/keymaps.lua
-- =============================================================================
local keymap = vim.keymap.set

-- =============================================================================
-- LEADER KEY
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- =============================================================================
-- SHARED EDITING KEYMAPS
-- =============================================================================
-- These work great in both standalone and VSCode

-- Visual mode: stay in visual after indenting
keymap("v", "<", "<gv", {
    desc = "Indent left and stay in visual"
})
keymap("v", ">", ">gv", {
    desc = "Indent right and stay in visual"
})

-- Visual mode: move lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selection down"
})
keymap("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selection up"
})

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", {
    desc = "Scroll down and center"
})
keymap("n", "<C-u>", "<C-u>zz", {
    desc = "Scroll up and center"
})

-- Keep search terms centered
keymap("n", "n", "nzzzv", {
    desc = "Next search (centered)"
})
keymap("n", "N", "Nzzzv", {
    desc = "Previous search (centered)"
})

-- Clipboard operations
keymap({"n", "v"}, "<leader>d", '"_d', {
    desc = "Delete without yanking"
})
keymap("x", "<leader>p", '"_dP', {
    desc = "Paste without yanking"
})
keymap({"n", "v"}, "<leader>y", '"+y', {
    desc = "Yank to system clipboard"
})
keymap("n", "<leader>Y", '"+Y', {
    desc = "Yank line to clipboard"
})

-- Disable annoying defaults
keymap("n", "Q", "<nop>", {
    desc = "Disable Ex mode"
})
keymap("n", "<Space>", "<nop>", {
    desc = "Disable space"
})

-- Replace word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    {
        desc = "Replace word under cursor"
    })

-- =============================================================================
-- STANDALONE-ONLY KEYMAPS
-- =============================================================================
-- These only work when NOT in VSCode

if not vim.g.vscode then
    -- File operations
    keymap("n", "<leader>w", ":w<CR>", {
        desc = "Save file"
    })
    keymap("n", "<leader>q", ":q<CR>", {
        desc = "Quit"
    })
    
    -- Source file (Changed from <leader><leader> to <leader>so)
    keymap("n", "<leader>so", ":source %<CR>", {
        desc = "Source file"
    })

    -- Window navigation
    keymap("n", "<C-h>", "<C-w>h", {
        desc = "Move to left split"
    })
    keymap("n", "<C-j>", "<C-w>j", {
        desc = "Move to bottom split"
    })
    keymap("n", "<C-k>", "<C-w>k", {
        desc = "Move to top split"
    })
    keymap("n", "<C-l>", "<C-w>l", {
        desc = "Move to right split"
    })

    -- Resize splits
    keymap("n", "<C-Up>", ":resize +2<CR>", {
        desc = "Increase height"
    })
    keymap("n", "<C-Down>", ":resize -2<CR>", {
        desc = "Decrease height"
    })
    keymap("n", "<C-Left>", ":vertical resize -2<CR>", {
        desc = "Decrease width"
    })
    keymap("n", "<C-Right>", ":vertical resize +2<CR>", {
        desc = "Increase width"
    })

    -- Buffer navigation
    keymap("n", "<S-h>", ":bprevious<CR>", {
        desc = "Previous buffer"
    })
    keymap("n", "<S-l>", ":bnext<CR>", {
        desc = "Next buffer"
    })
    
    -- Delete buffer (Changed from <leader>bd to <leader>bx)
    keymap("n", "<leader>bx", ":bdelete<CR>", {
        desc = "Delete buffer"
    })

    -- Terminal mode
    keymap("t", "<Esc><Esc>", "<C-\\><C-n>", {
        desc = "Exit terminal mode"
    })

    -- File explorer (will be overridden by oil.nvim)
    keymap("n", "<leader>pv", vim.cmd.Ex, {
        desc = "Open file explorer"
    })
end

-- =============================================================================
-- VSCODE-SPECIFIC KEYMAPS
-- =============================================================================
-- These are loaded from vscode/keymaps.lua when in VSCode mode
-- They call VSCode commands via the VSCode Neovim extension API
-- =============================================================================