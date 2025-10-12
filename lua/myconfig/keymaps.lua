-- ~\AppData\Local\nvim\lua\myconfig\keymaps.lua
-- =============================================================================
-- KEYMAPS - Custom Keyboard Shortcuts
-- =============================================================================
-- vim.keymap.set() is the modern Lua way to set keybindings
-- Format: vim.keymap.set(mode, keys, command, options)
-- Modes: "n" = normal, "i" = insert, "v" = visual, "x" = visual block
-- =============================================================================
local keymap = vim.keymap.set -- Shorthand for convenience

-- =============================================================================
-- LEADER KEY MAPPINGS
-- =============================================================================
-- Leader is set to Space in init.lua
-- These are your "namespace" for custom commands

-- File explorer (using netrw for now, will be replaced by oil.nvim)
keymap("n", "<leader>pv", vim.cmd.Ex, {
    desc = "\u{f115} File explorer" --  (folder open)
})

-- =============================================================================
-- BETTER DEFAULTS - Quality of Life Improvements
-- =============================================================================

-- Stay in visual mode when indenting
keymap("v", "<", "<gv", {
    desc = "\u{f060} Indent left" --  (arrow left)
})
keymap("v", ">", ">gv", {
    desc = "\u{f061} Indent right" --  (arrow right)
})

-- Move selected lines up/down (ThePrimeagen's favorite)
keymap("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "\u{f063} Move selection down" --  (arrow down)
})
keymap("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "\u{f062} Move selection up" --  (arrow up)
})

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", {
    desc = "\u{f063} Scroll down (centered)" --  (arrow down)
})
keymap("n", "<C-u>", "<C-u>zz", {
    desc = "\u{f062} Scroll up (centered)" --  (arrow up)
})

-- Keep search terms centered
keymap("n", "n", "nzzzv", {
    desc = "\u{f002} Next search (centered)" --  (search)
})
keymap("n", "N", "Nzzzv", {
    desc = "\u{f002} Previous search (centered)" --  (search)
})

-- =============================================================================
-- CLIPBOARD OPERATIONS
-- =============================================================================

-- Delete without yanking (delete to void register)
keymap({"n", "v"}, "<leader>d", '"_d', {
    desc = "\u{f00d} Delete without yanking" --  (close/delete)
})

-- Paste over selection without yanking (ThePrimeagen special)
keymap("x", "<leader>p", '"_dP', {
    desc = "\u{f0c5} Paste without yanking" --  (files/paste)
})

-- Yank to system clipboard
keymap({"n", "v"}, "<leader>y", '"+y', {
    desc = "\u{f0c5} Yank to clipboard" --  (copy)
})
keymap("n", "<leader>Y", '"+Y', {
    desc = "\u{f0c5} Yank line to clipboard" --  (copy)
})

-- =============================================================================
-- WINDOW NAVIGATION
-- =============================================================================

-- Navigate between splits
keymap("n", "<C-h>", "<C-w>h", {
    desc = "\u{f060} Move to left split" --  (arrow left)
})
keymap("n", "<C-j>", "<C-w>j", {
    desc = "\u{f063} Move to bottom split" --  (arrow down)
})
keymap("n", "<C-k>", "<C-w>k", {
    desc = "\u{f062} Move to top split" --  (arrow up)
})
keymap("n", "<C-l>", "<C-w>l", {
    desc = "\u{f061} Move to right split" --  (arrow right)
})

-- Resize splits
keymap("n", "<C-Up>", ":resize +2<CR>", {
    desc = "\u{f062} Increase height" --  (arrow up)
})
keymap("n", "<C-Down>", ":resize -2<CR>", {
    desc = "\u{f063} Decrease height" --  (arrow down)
})
keymap("n", "<C-Left>", ":vertical resize -2<CR>", {
    desc = "\u{f060} Decrease width" --  (arrow left)
})
keymap("n", "<C-Right>", ":vertical resize +2<CR>", {
    desc = "\u{f061} Increase width" --  (arrow right)
})

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================

keymap("n", "<S-h>", ":bprevious<CR>", {
    desc = "\u{f053} Previous buffer" --  (chevron left)
})
keymap("n", "<S-l>", ":bnext<CR>", {
    desc = "\u{f054} Next buffer" --  (chevron right)
})
keymap("n", "<leader>bd", ":bdelete<CR>", {
    desc = "\u{f00d} Delete buffer" --  (close)
})

-- =============================================================================
-- QUICK ACTIONS
-- =============================================================================

-- Save file
keymap("n", "<leader>w", ":w<CR>", {
    desc = "\u{f0c7} Save file" --  (save/floppy disk)
})

-- Quit
keymap("n", "<leader>q", ":q<CR>", {
    desc = "\u{f2d1} Quit" --  (window close)
})

-- Source current file (reload config)
keymap("n", "<leader><leader>", ":source %<CR>", {
    desc = "\u{f021} Source file" --  (refresh/reload)
})

-- Replace word under cursor (ThePrimeagen style)
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    {
        desc = "\u{f002} Replace word under cursor" --  (search)
    })

-- Make current file executable
keymap("n", "<leader>x", ":!chmod +x %<CR>", {
    desc = "\u{f013} Make file executable" --  (gear/settings)
})

-- =============================================================================
-- DISABLE ANNOYING DEFAULTS
-- =============================================================================

-- Disable Q (Ex mode - almost never useful)
keymap("n", "Q", "<nop>", {
    desc = "Disable Ex mode"
})

-- Disable Space in normal mode (we use it as leader)
keymap("n", "<Space>", "<nop>", {
    desc = "Disable space (used as leader)"
})

-- =============================================================================
-- TERMINAL MODE
-- =============================================================================

-- Easier escape from terminal mode
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", {
    desc = "\u{ead4} Exit terminal mode" --  (terminal)
})

-- =============================================================================
-- Notes:
-- - All keymaps have descriptions (shows up in which-key plugin)
-- - These are based on ThePrimeagen's workflow but you should customize them!
-- - To see what a key does: :map <key>
-- - To unmap a key: :unmap <key>
-- =============================================================================
