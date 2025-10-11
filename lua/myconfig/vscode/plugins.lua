-- ~\AppData\Local\nvim\lua\myconfig\vscode\plugins.lua
-- =============================================================================
-- VSCODE-COMPATIBLE PLUGINS
-- =============================================================================
-- Only load plugins that enhance text editing without conflicting with VSCode
-- VSCode handles LSP, completion, file explorer, fuzzy finding, git decorations
-- =============================================================================

-- Bootstrap lazy.nvim (same as standalone)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  
  -- ==========================================================================
  -- ENHANCED NAVIGATION
  -- ==========================================================================
  
  -- Flash: Enhanced f/t motions and search
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },
  
  -- ==========================================================================
  -- TEXT OBJECTS
  -- ==========================================================================
  
  -- Surround: Add/change/delete surrounding pairs
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  
  -- Targets: Additional text objects (separators, arguments, etc.)
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },
  
  -- ==========================================================================
  -- COMMENTING
  -- ==========================================================================
  
  -- Comment.nvim: Smart commenting
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  
  -- ==========================================================================
  -- SYNTAX & TREESITTER (Optional)
  -- ==========================================================================
  
  -- Treesitter: Better syntax understanding for text objects
  -- Note: VSCode has its own syntax highlighting, but treesitter
  -- can still help with text objects and motions
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Only install parsers you need
        ensure_installed = {
          "lua", "javascript", "typescript", "python",
          "html", "css", "json", "markdown",
        },
        
        -- Enable only features that work well with VSCode
        highlight = {
          enable = false,  -- VSCode handles highlighting
        },
        
        indent = {
          enable = false,  -- VSCode handles indentation
        },
        
        -- Text objects are useful even in VSCode
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
  
  -- ==========================================================================
  -- MULTI-CURSOR (Optional)
  -- ==========================================================================
  
  -- Visual Multi: Multiple cursors (if you prefer Neovim's version)
  -- Note: VSCode has built-in multi-cursor, so this is optional
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    enabled = false,  -- Disabled by default, enable if you prefer it
  },
  
}, {
  -- Lazy.nvim options
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- =============================================================================
-- NOTES ON VSCODE-COMPATIBLE PLUGINS
-- =============================================================================
--
-- RECOMMENDED (These enhance Neovim without conflicts):
-- ✅ flash.nvim - Enhanced navigation (s/S for jump)
-- ✅ nvim-surround - Surround text objects (ys/cs/ds)
-- ✅ Comment.nvim - Smart commenting (gcc/gc)
-- ✅ targets.vim - Additional text objects (cin'/da,)
-- ✅ nvim-treesitter - Better text objects (only textobjects feature)
--
-- OPTIONAL (Can work but may have quirks):
-- ⚠️ leap.nvim - Alternative to flash.nvim
-- ⚠️ vim-visual-multi - Multi-cursor (VSCode has its own)
-- ⚠️ indent-blankline - Indent guides (VSCode has extensions)
--
-- DO NOT USE (Conflicts with VSCode):
-- ❌ telescope.nvim - VSCode has Ctrl+P
-- ❌ oil.nvim / nvim-tree - VSCode has file explorer
-- ❌ nvim-cmp / blink.cmp - VSCode has IntelliSense
-- ❌ All LSP plugins - VSCode has LSP
-- ❌ lualine.nvim - VSCode has statusbar
-- ❌ gitsigns.nvim - VSCode has GitLens
-- ❌ bufferline.nvim - VSCode manages tabs
-- ❌ which-key.nvim - Can conflict with VSCode shortcuts
-- ❌ toggleterm.nvim - VSCode has integrated terminal
-- =============================================================================
