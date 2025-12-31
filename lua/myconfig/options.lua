-- ~\AppData\Local\nvim\lua\myconfig\options.lua
-- =============================================================================
-- VIM OPTIONS - Editor Behavior Settings (UPDATED)
-- =============================================================================
-- Added: Treesitter-based folding configuration
-- =============================================================================
local opt = vim.opt

-- =============================================================================
-- UI APPEARANCE
-- =============================================================================

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Cursor
opt.cursorline = true
-- opt.guicursor = ""

-- Colors
opt.termguicolors = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Command line
opt.showcmd = true
opt.cmdheight = 1

-- Visual feedback
opt.showmode = true -- Show mode (or disable if using lualine)
opt.colorcolumn = "80"

-- =============================================================================
-- EDITING BEHAVIOR
-- =============================================================================

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Line wrapping
opt.wrap = false

-- Undo/Backup
opt.swapfile = false
opt.backup = false
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
opt.undofile = true

-- =============================================================================
-- SEARCH BEHAVIOR
-- =============================================================================

opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- =============================================================================
-- PERFORMANCE
-- =============================================================================

opt.updatetime = 50
opt.timeoutlen = 300

-- =============================================================================
-- COMPLETION
-- =============================================================================

opt.completeopt = "menu,menuone,noselect"

-- =============================================================================
-- FILE HANDLING
-- =============================================================================

opt.isfname:append("@-@")

-- =============================================================================
-- CLIPBOARD
-- =============================================================================

opt.clipboard = "unnamedplus"

-- =============================================================================
-- MOUSE
-- =============================================================================

opt.mouse = "a"

-- =============================================================================
-- SHELL CONFIGURATION (Windows)
-- =============================================================================

-- Note: On Windows, use PowerShell as default shell
-- For bash commands, use explicit: :!bash -c "command"
-- Or run from external Git Bash terminal

-- =============================================================================
-- FOLDING (ADDED - Treesitter-based)
-- =============================================================================

-- Enable folding based on treesitter
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Don't fold by default (all folds open)
opt.foldenable = false

-- Maximum nesting of folds
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Minimum number of lines for a fold
opt.foldminlines = 1

-- Column to show folds (0 = hide, 1-12 = width)
opt.foldcolumn = "0"

-- Text shown for closed folds (customize if desired)
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()"

-- =============================================================================
-- NETRW (Built-in File Explorer) Settings
-- =============================================================================
-- We use oil.nvim instead, but keep these for reference

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- =============================================================================
-- FOLDING KEYBINDINGS REMINDER
-- =============================================================================
-- za  - Toggle fold under cursor
-- zA  - Toggle all folds under cursor recursively
-- zc  - Close fold under cursor
-- zC  - Close all folds under cursor recursively
-- zo  - Open fold under cursor
-- zO  - Open all folds under cursor recursively
-- zm  - Fold more (close one level of folds everywhere)
-- zM  - Close all folds
-- zr  - Fold less (open one level of folds everywhere)
-- zR  - Open all folds
-- zj  - Move to next fold
-- zk  - Move to previous fold
-- =============================================================================

-- =============================================================================
-- NOTES
-- =============================================================================
-- New features added:
--
-- 1. TREESITTER FOLDING:
--    - Folds based on syntax tree (more accurate than indent-based)
--    - Works for functions, classes, blocks, etc.
--    - Language-aware (understands code structure)
--
-- Folding usage:
--    - Press 'za' to toggle fold at cursor
--    - Press 'zM' to close all folds
--    - Press 'zR' to open all folds
--    - Folds are disabled by default (foldenable = false)
--    - All folds start open (foldlevel = 99)
--
-- To enable folds by default, change:
--    opt.foldenable = true
--    opt.foldlevelstart = 0  -- Start with all folds closed
-- =============================================================================
