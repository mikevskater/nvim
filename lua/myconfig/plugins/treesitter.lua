-- ~\AppData\Local\nvim\lua\myconfig\plugins\treesitter.lua
-- =============================================================================
-- TREESITTER - Advanced Syntax Highlighting
-- =============================================================================
-- Why Treesitter? Better syntax highlighting than regex-based highlighting
-- Understands code structure, enables smart text objects, code folding, etc.
-- https://github.com/nvim-treesitter/nvim-treesitter
-- =============================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  
  -- Run :TSUpdate after installation/updates
  build = ":TSUpdate",
  
  -- Load on events for better startup time
  event = { "BufReadPre", "BufNewFile" },
  
  -- Optional dependencies (useful text objects)
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  
  config = function()
    require("nvim-treesitter.configs").setup({
      -- ==========================================================================
      -- PARSER INSTALLATION
      -- ==========================================================================
      -- Install parsers for these languages automatically
      -- Add/remove languages as needed
      ensure_installed = {
        -- General purpose
        "lua",        -- Neovim config
        "vim",        -- Vim help files
        "vimdoc",     -- Vim documentation
        
        -- Web development
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        
        -- Systems programming
        "c",
        "cpp",
        "rust",
        "go",
        
        -- Scripting
        "python",
        "bash",
        
        -- Markup/config
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
        
        -- Add more as needed...
      },
      
      -- Install parsers synchronously (only for ensure_installed)
      sync_install = false,
      
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      
      -- ==========================================================================
      -- HIGHLIGHTING
      -- ==========================================================================
      highlight = {
        enable = true,
        
        -- Disable for large files (improves performance)
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        
        -- Enable additional highlighting by vim's regex
        additional_vim_regex_highlighting = false,
      },
      
      -- ==========================================================================
      -- INDENTATION
      -- ==========================================================================
      indent = {
        enable = true,
      },
      
      -- ==========================================================================
      -- INCREMENTAL SELECTION
      -- ==========================================================================
      -- Expand selection based on syntax tree
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      
      -- ==========================================================================
      -- TEXT OBJECTS (requires nvim-treesitter-textobjects)
      -- ==========================================================================
      -- Smart text objects based on syntax tree
      -- Example: "daf" = delete a function, "vac" = select a class
      textobjects = {
        select = {
          enable = true,
          lookahead = true,  -- Automatically jump forward to textobj
          keymaps = {
            -- Functions
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            
            -- Classes
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            
            -- Loops
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            
            -- Conditionals
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            
            -- Parameters/arguments
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        
        -- Move between functions, classes, etc.
        move = {
          enable = true,
          set_jumps = true,  -- Add to jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
      },
    })
  end,
}

-- =============================================================================
-- TREESITTER NOTES
-- =============================================================================
-- Treesitter requires a C compiler on Windows:
-- 1. Install zig: winget install zig.zig
-- 2. OR install Visual Studio Build Tools
--
-- Useful commands:
-- :TSInstall <language>    - Install parser for language
-- :TSUpdate                - Update all parsers
-- :TSUninstall <language>  - Remove parser
-- :TSInstallInfo           - Show installed parsers
--
-- Text object examples (with textobjects enabled):
-- daf  - Delete a function
-- vif  - Select inside function
-- yac  - Yank a class
-- ]f   - Jump to next function
-- [f   - Jump to previous function
-- =============================================================================
