-- ~\AppData\Local\nvim\lua\myconfig\vscode\keymaps.lua
-- =============================================================================
-- VSCODE-SPECIFIC KEYMAPS
-- =============================================================================
-- These keymaps call VSCode commands through the vscode-neovim extension
-- They integrate Neovim's modal editing with VSCode's features
-- =============================================================================
-- Helper function to call VSCode commands
local vscode = require('vscode')

local keymap = vim.keymap.set

-- =============================================================================
-- FILE NAVIGATION
-- =============================================================================

-- Quick Open (VSCode's fuzzy finder)
keymap("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
end, {
    desc = "VSCode: Quick Open"
})

-- Recent files
keymap("n", "<leader>fr", function()
    vscode.action("workbench.action.openRecent")
end, {
    desc = "VSCode: Recent files"
})

-- File explorer
keymap("n", "<leader>e", function()
    vscode.action("workbench.action.toggleSidebarVisibility")
end, {
    desc = "VSCode: Toggle sidebar"
})
keymap("n", "-", function()
    vscode.action("workbench.view.explorer")
end, {
    desc = "VSCode: Focus explorer"
})

-- =============================================================================
-- SEARCH AND REPLACE
-- =============================================================================

-- Global search
keymap("n", "<leader>fw", function()
    vscode.action("workbench.action.findInFiles")
end, {
    desc = "VSCode: Find in files"
})

-- Search in current file
keymap("n", "<leader>fs", function()
    vscode.action("actions.find")
end, {
    desc = "VSCode: Find in file"
})

-- Replace in current file
keymap("n", "<leader>sr", function()
    vscode.action("editor.action.startFindReplaceAction")
end, {
    desc = "VSCode: Find and replace"
})

-- =============================================================================
-- CODE NAVIGATION (LSP)
-- =============================================================================

-- Go to definition (also works with 'gd' by default)
keymap("n", "<leader>gd", function()
    vscode.action("editor.action.revealDefinition")
end, {
    desc = "VSCode: Go to definition"
})

-- Go to references
keymap("n", "<leader>gr", function()
    vscode.action("references-view.findReferences")
end, {
    desc = "VSCode: Find references"
})

-- Go to implementation
keymap("n", "<leader>gi", function()
    vscode.action("editor.action.goToImplementation")
end, {
    desc = "VSCode: Go to implementation"
})

-- Go to type definition
keymap("n", "<leader>gt", function()
    vscode.action("editor.action.goToTypeDefinition")
end, {
    desc = "VSCode: Go to type definition"
})

-- Show hover information
keymap("n", "K", function()
    vscode.action("editor.action.showHover")
end, {
    desc = "VSCode: Show hover"
})

-- Peek definition
keymap("n", "<leader>pd", function()
    vscode.action("editor.action.peekDefinition")
end, {
    desc = "VSCode: Peek definition"
})

-- =============================================================================
-- CODE ACTIONS
-- =============================================================================

-- Code actions (quick fix)
keymap({"n", "v"}, "<leader>ca", function()
    vscode.action("editor.action.quickFix")
end, {
    desc = "VSCode: Code actions"
})

-- Rename symbol
keymap("n", "<leader>rn", function()
    vscode.action("editor.action.rename")
end, {
    desc = "VSCode: Rename symbol"
})

-- Format document
keymap("n", "<leader>fm", function()
    vscode.action("editor.action.formatDocument")
end, {
    desc = "VSCode: Format document"
})

-- Format selection
keymap("v", "<leader>fm", function()
    vscode.action("editor.action.formatSelection")
end, {
    desc = "VSCode: Format selection"
})

-- =============================================================================
-- DIAGNOSTICS (Problems)
-- =============================================================================

-- Show problems panel
keymap("n", "<leader>xx", function()
    vscode.action("workbench.actions.view.problems")
end, {
    desc = "VSCode: Show problems"
})

-- Next diagnostic
keymap("n", "]d", function()
    vscode.action("editor.action.marker.next")
end, {
    desc = "VSCode: Next diagnostic"
})

-- Previous diagnostic
keymap("n", "[d", function()
    vscode.action("editor.action.marker.prev")
end, {
    desc = "VSCode: Previous diagnostic"
})

-- Show diagnostic (error/warning)
keymap("n", "<leader>d", function()
    vscode.action("editor.action.showHover")
end, {
    desc = "VSCode: Show diagnostic"
})

-- =============================================================================
-- EDITOR TABS/SPLITS
-- =============================================================================

-- Split editor
keymap("n", "<leader>sv", function()
    vscode.action("workbench.action.splitEditorRight")
end, {
    desc = "VSCode: Split right"
})
keymap("n", "<leader>sh", function()
    vscode.action("workbench.action.splitEditorDown")
end, {
    desc = "VSCode: Split down"
})

-- Close editor
keymap("n", "<leader>c", function()
    vscode.action("workbench.action.closeActiveEditor")
end, {
    desc = "VSCode: Close editor"
})

-- Navigate between editor groups
keymap("n", "<C-h>", function()
    vscode.action("workbench.action.navigateLeft")
end, {
    desc = "VSCode: Navigate left"
})
keymap("n", "<C-l>", function()
    vscode.action("workbench.action.navigateRight")
end, {
    desc = "VSCode: Navigate right"
})
keymap("n", "<C-k>", function()
    vscode.action("workbench.action.navigateUp")
end, {
    desc = "VSCode: Navigate up"
})
keymap("n", "<C-j>", function()
    vscode.action("workbench.action.navigateDown")
end, {
    desc = "VSCode: Navigate down"
})

-- Navigate between tabs
keymap("n", "<S-h>", function()
    vscode.action("workbench.action.previousEditor")
end, {
    desc = "VSCode: Previous tab"
})
keymap("n", "<S-l>", function()
    vscode.action("workbench.action.nextEditor")
end, {
    desc = "VSCode: Next tab"
})

-- =============================================================================
-- GIT INTEGRATION
-- =============================================================================

-- Git status
keymap("n", "<leader>gs", function()
    vscode.action("workbench.view.scm")
end, {
    desc = "VSCode: Git status"
})

-- Git blame
keymap("n", "<leader>gb", function()
    vscode.action("gitlens.toggleLineBlame")
end, {
    desc = "VSCode: Toggle git blame"
})

-- Git diff
keymap("n", "<leader>gd", function()
    vscode.action("workbench.action.compareEditor.focusPrimarySide")
end, {
    desc = "VSCode: Git diff"
})

-- Next/Previous git change
keymap("n", "]c", function()
    vscode.action("workbench.action.editor.nextChange")
end, {
    desc = "VSCode: Next git change"
})
keymap("n", "[c", function()
    vscode.action("workbench.action.editor.previousChange")
end, {
    desc = "VSCode: Previous git change"
})

-- =============================================================================
-- COMMENTING
-- =============================================================================

-- Toggle line comment (also 'gcc' works with vim-commentary)
keymap("n", "<leader>/", function()
    vscode.action("editor.action.commentLine")
end, {
    desc = "VSCode: Toggle comment"
})
keymap("v", "<leader>/", function()
    vscode.action("editor.action.commentLine")
end, {
    desc = "VSCode: Toggle comment"
})

-- =============================================================================
-- WORKSPACE/PROJECT
-- =============================================================================

-- Command palette
keymap("n", "<leader>p", function()
    vscode.action("workbench.action.showCommands")
end, {
    desc = "VSCode: Command palette"
})

-- Save file
keymap("n", "<leader>w", function()
    vscode.action("workbench.action.files.save")
end, {
    desc = "VSCode: Save file"
})

-- Save all
keymap("n", "<leader>wa", function()
    vscode.action("workbench.action.files.saveAll")
end, {
    desc = "VSCode: Save all"
})

-- Toggle terminal
keymap("n", "<leader>t", function()
    vscode.action("workbench.action.terminal.toggleTerminal")
end, {
    desc = "VSCode: Toggle terminal"
})

-- Focus on terminal
keymap("n", "<leader>tt", function()
    vscode.action("workbench.action.terminal.focus")
end, {
    desc = "VSCode: Focus terminal"
})

-- =============================================================================
-- DEBUGGING
-- =============================================================================

-- Toggle breakpoint
keymap("n", "<leader>db", function()
    vscode.action("editor.debug.action.toggleBreakpoint")
end, {
    desc = "VSCode: Toggle breakpoint"
})

-- Start debugging
keymap("n", "<leader>dc", function()
    vscode.action("workbench.action.debug.start")
end, {
    desc = "VSCode: Start debugging"
})

-- =============================================================================
-- FOLD/UNFOLD
-- =============================================================================

-- Toggle fold at cursor
keymap("n", "za", function()
    vscode.action("editor.toggleFold")
end, {
    desc = "VSCode: Toggle fold"
})

-- Fold all
keymap("n", "zM", function()
    vscode.action("editor.foldAll")
end, {
    desc = "VSCode: Fold all"
})

-- Unfold all
keymap("n", "zR", function()
    vscode.action("editor.unfoldAll")
end, {
    desc = "VSCode: Unfold all"
})

-- =============================================================================
-- NOTES
-- =============================================================================
-- To discover VSCode command IDs:
-- 1. Open VSCode Command Palette (Ctrl+Shift+P)
-- 2. Run: "Developer: Open Keyboard Shortcuts (JSON)"
-- 3. Or check: https://code.visualstudio.com/api/references/commands
--
-- The vscode.action() function calls VSCode commands from Neovim
-- You can chain commands and even pass arguments if needed
-- =============================================================================
