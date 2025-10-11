-- ~\AppData\Local\nvim\lua\myconfig\plugins\fugitive.lua
-- =============================================================================
-- VIM-FUGITIVE - Git Integration
-- =============================================================================
-- The best Git plugin for Vim/Neovim by tpope
-- =============================================================================
return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {
            desc = "Git status"
        })
    end
}

-- Usage: <leader>gs for git status
-- Then: s to stage, u to unstage, cc to commit
