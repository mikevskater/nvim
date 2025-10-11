-- ~\AppData\Local\nvim\lua\myconfig\core\options.lua
-- =============================================================================
-- SHARED OPTIONS - Works in Both Standalone and VSCode
-- =============================================================================
-- These options work well in both environments
-- =============================================================================

local opt = vim.opt

-- =============================================================================
-- EDITOR BEHAVIOR (Shared)
-- =============================================================================

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Clipboard
opt.clipboard = "unnamedplus"

-- =============================================================================
-- STANDALONE-ONLY OPTIONS
-- =============================================================================
-- These only apply when NOT in VSCode

if not vim.g.vscode then
  -- UI Appearance
  opt.number = true
  opt.relativenumber = true
  opt.signcolumn = "yes"
  opt.cursorline = true
  opt.guicursor = ""
  opt.termguicolors = true
  opt.scrolloff = 8
  opt.sidescrolloff = 8
  opt.showmode = false
  opt.colorcolumn = "80"
  opt.showcmd = true
  opt.cmdheight = 1
  
  -- Splits
  opt.splitright = true
  opt.splitbelow = true
  
  -- Undo/Backup
  opt.swapfile = false
  opt.backup = false
  local undodir = vim.fn.expand("~/.vim/undodir")
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
  end
  opt.undodir = undodir
  opt.undofile = true
  
  -- Search highlighting
  opt.hlsearch = false
  
  -- Mouse
  opt.mouse = "a"
end

-- =============================================================================
-- VSCODE-SPECIFIC OPTIONS
-- =============================================================================

if vim.g.vscode then
  -- In VSCode, we want minimal options
  -- VSCode handles most of the UI
  
  -- Disable some Neovim UI elements
  opt.number = false
  opt.relativenumber = false
  opt.signcolumn = "no"
  
  -- Let VSCode handle search highlighting
  opt.hlsearch = false
end
