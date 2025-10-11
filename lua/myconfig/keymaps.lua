-- ~\AppData\Local\nvim\lua\myconfig\keymaps.lua
-- =============================================================================
-- KEYMAPS - Custom Keyboard Shortcuts
-- =============================================================================
-- vim.keymap.set() is the modern Lua way to set keybindings
-- Format: vim.keymap.set(mode, keys, command, options)
-- Modes: "n" = normal, "i" = insert, "v" = visual, "x" = visual block
-- =============================================================================

local keymap = vim.keymap.set  -- Shorthand for convenience

-- =============================================================================
-- LEADER KEY MAPPINGS
-- =============================================================================
-- Leader is set to Space in init.lua
-- These are your "namespace" for custom commands

-- File explorer (using netrw for now, will be replaced by oil.nvim)
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- =============================================================================
-- BETTER DEFAULTS - Quality of Life Improvements
-- =============================================================================

-- Stay in visual mode when indenting
keymap("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })
keymap("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })

-- Move selected lines up/down (ThePrimeagen's favorite)
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms centered
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- =============================================================================
-- CLIPBOARD OPERATIONS
-- =============================================================================

-- Delete without yanking (delete to void register)
keymap({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Paste over selection without yanking (ThePrimeagen special)
keymap("x", "<leader>p", '"_dP', { desc = "Paste without yanking selection" })

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- =============================================================================
-- WINDOW NAVIGATION
-- =============================================================================

-- Navigate between splits
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase split height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease split height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease split width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase split width" })

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================

keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- =============================================================================
-- QUICK ACTIONS
-- =============================================================================

-- Save file
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Source current file (reload config)
keymap("n", "<leader><leader>", ":source %<CR>", { desc = "Source current file" })

-- Replace word under cursor (ThePrimeagen style)
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 
  { desc = "Replace word under cursor" })

-- Make current file executable
keymap("n", "<leader>x", ":!chmod +x %<CR>", { desc = "Make file executable" })

-- =============================================================================
-- DISABLE ANNOYING DEFAULTS
-- =============================================================================

-- Disable Q (Ex mode - almost never useful)
keymap("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- Disable Space in normal mode (we use it as leader)
keymap("n", "<Space>", "<nop>", { desc = "Disable space (used as leader)" })

-- =============================================================================
-- TERMINAL MODE
-- =============================================================================

-- Easier escape from terminal mode
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =============================================================================
-- Notes:
-- - All keymaps have descriptions (shows up in which-key plugin)
-- - These are based on ThePrimeagen's workflow but you should customize them!
-- - To see what a key does: :map <key>
-- - To unmap a key: :unmap <key>
-- =============================================================================
