-- ~\AppData\Local\nvim\lua\myconfig\options.lua
-- =============================================================================
-- VIM OPTIONS - Editor Behavior Settings
-- =============================================================================
-- These settings control how Neovim behaves as an editor
-- vim.opt is the modern Lua way to set options (replaces 'set' in Vimscript)
-- =============================================================================

local opt = vim.opt  -- Shorthand for convenience

-- =============================================================================
-- UI APPEARANCE
-- =============================================================================

-- Line numbers
opt.number = true           -- Show absolute line number on current line
opt.relativenumber = true   -- Show relative line numbers (great for motions like "5j")
opt.signcolumn = "yes"      -- Always show sign column (prevents text shifting)

-- Cursor
opt.cursorline = true       -- Highlight the current line
--opt.guicursor = ""          -- Keep block cursor in all modes (ThePrimeagen style)

-- Colors
opt.termguicolors = true    -- Enable 24-bit RGB colors (required for modern themes)

-- Scrolling
opt.scrolloff = 8           -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8       -- Keep 8 columns visible left/right of cursor

-- Splits
opt.splitright = true       -- Vertical splits go to the right
opt.splitbelow = true       -- Horizontal splits go below

-- Command line
opt.showcmd = true          -- Show command in bottom bar
opt.cmdheight = 1           -- Height of the command bar

-- Visual feedback
opt.showmode = true        -- Don't show mode (we'll use statusline plugin)
opt.colorcolumn = "80"      -- Show column border at 80 characters

-- =============================================================================
-- EDITING BEHAVIOR
-- =============================================================================

-- Indentation
opt.tabstop = 4             -- Number of spaces a <Tab> counts for
opt.softtabstop = 4         -- Number of spaces for <Tab> in insert mode
opt.shiftwidth = 4          -- Number of spaces for each indentation level
opt.expandtab = true        -- Convert tabs to spaces
opt.smartindent = true      -- Smart auto-indenting for new lines
opt.breakindent = true      -- Wrapped lines will be indented

-- Line wrapping
opt.wrap = false            -- Don't wrap long lines (ThePrimeagen preference)

-- Undo/Backup
opt.swapfile = false        -- Don't create swap files
opt.backup = false          -- Don't create backup files
-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir       -- Store undo files in dedicated directory
opt.undofile = true         -- Enable persistent undo (survives Neovim restart)

-- =============================================================================
-- SEARCH BEHAVIOR
-- =============================================================================

opt.hlsearch = false        -- Don't highlight all search matches (less visual clutter)
opt.incsearch = true        -- Show search matches as you type
opt.ignorecase = true       -- Case-insensitive search...
opt.smartcase = true        -- ...unless search contains uppercase letter

-- =============================================================================
-- PERFORMANCE
-- =============================================================================

opt.updatetime = 50         -- Faster completion (default is 4000ms)
opt.timeoutlen = 300        -- Time to wait for mapped sequence to complete

-- =============================================================================
-- COMPLETION
-- =============================================================================

opt.completeopt = "menu,menuone,noselect"  -- Better completion experience

-- =============================================================================
-- FILE HANDLING
-- =============================================================================

opt.isfname:append("@-@")   -- Consider @ as part of filename

-- =============================================================================
-- CLIPBOARD
-- =============================================================================

-- Use system clipboard (requires clip.exe on Windows, which should be available)
opt.clipboard = "unnamedplus"

-- =============================================================================
-- MOUSE
-- =============================================================================

opt.mouse = "a"             -- Enable mouse support in all modes

-- =============================================================================
-- NETRW (Built-in File Explorer) Settings
-- =============================================================================
-- We'll use oil.nvim instead, but keep these for reference

vim.g.netrw_browse_split = 0    -- Open files in same window
vim.g.netrw_banner = 0           -- Hide banner
vim.g.netrw_winsize = 25         -- Window size

-- =============================================================================
-- Notes:
-- - These are sensible defaults inspired by ThePrimeagen and modern Neovim usage
-- - You can always check what an option does with :help <option-name>
-- - Example: :help number
-- =============================================================================
