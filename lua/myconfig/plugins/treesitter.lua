-- ~\AppData\Local\nvim\lua\myconfig\plugins\treesitter.lua
-- =============================================================================
-- TREESITTER - Advanced Syntax Highlighting (UPDATED)
-- =============================================================================
-- Added: Rainbow delimiters, context, autotag, and folding support
-- =============================================================================
return { -- Main treesitter plugin
{
    "nvim-treesitter/nvim-treesitter",

    -- Run :TSUpdate after installation/updates
    build = ":TSUpdate",

    -- Load on events for better startup time
    event = {"BufReadPre", "BufNewFile"},

    -- Optional dependencies
    dependencies = {"nvim-treesitter/nvim-treesitter-textobjects",
                    "nvim-treesitter/nvim-treesitter-context",
                    "windwp/nvim-ts-autotag"},

    config = function()
        require("nvim-treesitter.configs").setup({
            -- ==========================================================================
            -- PARSER INSTALLATION
            -- ==========================================================================
            ensure_installed = { -- General purpose
            "lua", "vim", "vimdoc", -- Web development
            "javascript", "typescript", "tsx", "html", "css", "json",

            -- Systems programming
            "c", "cpp", "rust", "go", -- Scripting
            "python", "bash", -- Markup/config
            "markdown", "markdown_inline", "yaml", "toml"},

            sync_install = false,
            auto_install = true,

            -- ==========================================================================
            -- HIGHLIGHTING
            -- ==========================================================================
            highlight = {
                enable = true,

                -- Disable for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat,
                        vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                additional_vim_regex_highlighting = false
            },

            -- ==========================================================================
            -- INDENTATION
            -- ==========================================================================
            indent = {
                enable = true
            },

            -- ==========================================================================
            -- AUTO TAG (HTML/JSX/XML)
            -- ==========================================================================
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = {"html", "javascript", "typescript",
                             "javascriptreact", "typescriptreact", "vue", "xml"}
            },

            -- ==========================================================================
            -- INCREMENTAL SELECTION
            -- ==========================================================================
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>"
                }
            },

            -- ==========================================================================
            -- TEXT OBJECTS
            -- ==========================================================================
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
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
                        ["ia"] = "@parameter.inner"
                    }
                },

                -- Move between functions, classes, etc.
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer"
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer"
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer"
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer"
                    }
                }
            }
        })
    end
},

-- =============================================================================
-- RAINBOW DELIMITERS
-- =============================================================================
-- Shows matching brackets in alternating colors
{
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local rainbow = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow.strategy['global'],
                vim = rainbow.strategy['local']
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks'
            },
            priority = {
                [''] = 110,
                lua = 210
            },
            highlight = {'RainbowDelimiterRed', 'RainbowDelimiterYellow',
                         'RainbowDelimiterBlue', 'RainbowDelimiterOrange',
                         'RainbowDelimiterGreen', 'RainbowDelimiterViolet',
                         'RainbowDelimiterCyan'}
        }
    end
},

-- =============================================================================
-- TREESITTER CONTEXT
-- =============================================================================
-- Shows current function/class at top of buffer
{
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        enable = true,
        max_lines = 3, -- How many lines the window should span
        min_window_height = 0, -- Minimum editor window height
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor", -- Line used to calculate context (cursor/topline)
        separator = nil, -- Separator between context and content
        zindex = 20
    },
    keys = {{
        "[x",
        function()
            require("treesitter-context").go_to_context()
        end,
        desc = "Go to context"
    }}
},

-- =============================================================================
-- AUTO TAG
-- =============================================================================
-- Auto close and rename HTML/JSX tags
{
    "windwp/nvim-ts-autotag",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    ft = {"html", "javascript", "typescript", "javascriptreact",
          "typescriptreact", "vue", "xml"},
    config = function()
        require("nvim-ts-autotag").setup({
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            }
        })
    end
}}

-- =============================================================================
-- TREESITTER NOTES
-- =============================================================================
-- New features added:
--
-- 1. RAINBOW DELIMITERS:
--    - Brackets/parens colored by nesting level
--    - Makes it easy to match pairs visually
--
-- 2. TREESITTER CONTEXT:
--    - Shows current function/class at top
--    - Press [x to jump to context
--    - Useful when scrolling through long functions
--
-- 3. AUTO TAG:
--    - Automatically closes HTML/JSX tags
--    - Renames closing tag when you rename opening tag
--    - Works in: HTML, JSX, TSX, Vue, XML
--
-- 4. FOLDING:
--    - Configured in options.lua
--    - Use 'za' to toggle fold
--    - Use 'zM' to fold all
--    - Use 'zR' to unfold all
--
-- Text object examples:
-- daf  - Delete a function
-- vif  - Select inside function
-- yac  - Yank a class
-- ]f   - Jump to next function
-- [f   - Jump to previous function
-- =============================================================================
