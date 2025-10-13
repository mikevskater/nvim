-- ~\AppData\Local\nvim\lua\myconfig\plugins\fugitive.lua
-- =============================================================================
-- VIM-FUGITIVE - Git Integration
-- =============================================================================
-- The best Git plugin for Vim/Neovim by tpope
-- =============================================================================
return {
    "tpope/vim-fugitive",

    config = function()
        -- ==========================================================================
        -- GIT STATUS & SUMMARY
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {
            desc = "\u{f1d3} Git status" --  (git logo)
        })

        -- ==========================================================================
        -- GIT COMMIT OPERATIONS
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", {
            desc = "\u{f044} Commit" --  (edit/pencil)
        })

        vim.keymap.set("n", "<leader>gC", "<cmd>Git commit --amend<CR>", {
            desc = "\u{f044} Commit amend" --  (edit/pencil)
        })

        -- ==========================================================================
        -- GIT PUSH/PULL/FETCH
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", {
            desc = "\u{f062} Push" --  (arrow up)
        })

        vim.keymap.set("n", "<leader>gP", "<cmd>Git pull<CR>", {
            desc = "\u{f063} Pull" --  (arrow down)
        })

        vim.keymap.set("n", "<leader>gf", "<cmd>Git fetch<CR>", {
            desc = "\u{f01e} Fetch" --  (refresh)
        })

        -- ==========================================================================
        -- GIT DIFF OPERATIONS
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", {
            desc = "\u{f04b} Diff split" --  (code branch/diff)
        })

        vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit<CR>", {
            desc = "\u{f338} Diff vsplit" --  (columns)
        })

        vim.keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit!<CR>", {
            desc = "\u{f0e8} Diff 3-way merge" --  (sitemap)
        })

        -- ==========================================================================
        -- GIT BLAME
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", {
            desc = "\u{f05a} Blame" --  (info circle)
        })

        -- ==========================================================================
        -- GIT LOG
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", {
            desc = "\u{f1da} Log" --  (history)
        })

        vim.keymap.set("n", "<leader>gL",
            "<cmd>Git log --oneline --graph --decorate --all<CR>", {
                desc = "\u{f1da} Log pretty" --  (history)
            })

        vim.keymap.set("n", "<leader>go", "<cmd>Git log -- %<CR>", {
            desc = "\u{f1da} Log (current file)" --  (history)
        })

        -- ==========================================================================
        -- GIT READ/WRITE (CHECKOUT/STAGE)
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gr", "<cmd>Gread<CR>", {
            desc = "\u{f021} Read (checkout file)" --  (refresh/reset)
        })

        vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<CR>", {
            desc = "\u{f067} Write (stage file)" --  (plus)
        })

        vim.keymap.set("n", "<leader>ga", "<cmd>Git add .<CR>", {
            desc = "\u{f067} Add all" --  (plus)
        })

        -- ==========================================================================
        -- GIT STASH
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gS", "<cmd>Git stash<CR>", {
            desc = "\u{f187} Stash" --  (archive)
        })

        vim.keymap.set("n", "<leader>gA", "<cmd>Git stash apply<CR>", {
            desc = "\u{f187} Stash apply" --  (archive)
        })

        vim.keymap.set("n", "<leader>gZ", "<cmd>Git stash pop<CR>", {
            desc = "\u{f187} Stash pop" --  (archive)
        })

        -- ==========================================================================
        -- GIT FILE OPERATIONS
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gm", "<cmd>GMove<CR>", {
            desc = "\u{f0b2} Move/rename" --  (arrows)
        })

        vim.keymap.set("n", "<leader>gx", "<cmd>GDelete<CR>", {
            desc = "\u{f1f8} Delete file" --  (trash)
        })

        -- ==========================================================================
        -- GIT BROWSE (GITHUB/GITLAB)
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gB", "<cmd>GBrowse<CR>", {
            desc = "\u{f0ac} Browse on web" --  (globe)
        })

        vim.keymap.set("v", "<leader>gB", ":GBrowse<CR>", {
            desc = "\u{f0ac} Browse selection" --  (globe)
        })

        -- ==========================================================================
        -- GIT GREP/SEARCH
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gg", "<cmd>Ggrep ", {
            desc = "\u{f002} Grep" --  (search)
        })

        -- ==========================================================================
        -- GIT BRANCH OPERATIONS
        -- ==========================================================================
        vim.keymap.set("n", "<leader>gn", "<cmd>Git branch ", {
            desc = "\u{f126} New branch" --  (code branch)
        })

        vim.keymap.set("n", "<leader>gt", "<cmd>Git checkout ", {
            desc = "\u{f126} Checkout branch" --  (code branch)
        })
    end
}

-- =============================================================================
-- USAGE NOTES
-- =============================================================================
-- In :Git status window, use these mappings:
--   s     - stage file
--   u     - unstage file
--   cc    - commit
--   ca    - commit --amend
--   ce    - commit --amend --no-edit
--   cw    - commit --fixup=reword
--   -     - toggle stage/unstage
--   =     - toggle inline diff
--   >     - insert inline diff
--   <     - remove inline diff
--   dd    - diff split
--   dv    - vertical diff split
--   ds    - horizontal diff split
--   dp    - diff patch
--   o     - open file in split
--   O     - open file in tab
--   g?    - help
--   R     - reload status
--   q     - close status window
--
-- In :Git blame window:
--   <CR>  - open commit
--   o     - open commit in split
--   O     - open commit in tab
--   -     - reblame at commit
--   ~     - reblame at previous commit
--   A     - resize to author column
--   C     - resize to commit column
--   D     - resize to date column
--   g?    - help
--   q     - close blame
--
-- In diff windows:
--   [c    - previous change
--   ]c    - next change
--   do    - diff obtain (get changes from other)
--   dp    - diff put (put changes to other)
--   :diffupdate - update diff
-- =============================================================================
