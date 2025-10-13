-- ~\AppData\Local\nvim\lua\myconfig\plugins\treesitter.lua
-- =============================================================================
-- TREESITTER - Advanced Syntax Highlighting (UPDATED)
-- =============================================================================
-- Added: Swap, repeatable moves, LSP interop, conditional/loop navigation
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
                -- ----------------------------------------------------------------------
                -- SELECT TEXT OBJECTS
                -- ----------------------------------------------------------------------
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
                        ["ia"] = "@parameter.inner",

                        -- Blocks
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",

                        -- Scopes (from locals query)
                        ["as"] = {
                            query = "@local.scope",
                            query_group = "locals",
                            desc = "Select language scope"
                        }
                    }
                },

                -- ----------------------------------------------------------------------
                -- SWAP TEXT OBJECTS (Changed from <leader>a to <leader>s)
                -- ----------------------------------------------------------------------
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sa"] = {
                            query = "@parameter.inner",
                            desc = "Swap with next parameter"
                        },
                        ["<leader>sf"] = {
                            query = "@function.outer",
                            desc = "Swap with next function"
                        }
                    },
                    swap_previous = {
                        ["<leader>sA"] = {
                            query = "@parameter.inner",
                            desc = "Swap with previous parameter"
                        },
                        ["<leader>sF"] = {
                            query = "@function.outer",
                            desc = "Swap with previous function"
                        }
                    }
                },

                -- ----------------------------------------------------------------------
                -- MOVE BETWEEN TEXT OBJECTS
                -- ----------------------------------------------------------------------
                move = {
                    enable = true,
                    set_jumps = true, -- Add to jumplist
                    goto_next_start = {
                        -- Functions & Classes
                        ["]f"] = {
                            query = "@function.outer",
                            desc = "Next function start"
                        },
                        ["]c"] = {
                            query = "@class.outer",
                            desc = "Next class start"
                        },

                        -- Loops
                        ["]o"] = {
                            query = "@loop.*",
                            desc = "Next loop start"
                        },

                        -- Conditionals (Changed from ]d to ]i)
                        ["]i"] = {
                            query = "@conditional.outer",
                            desc = "Next conditional start"
                        },

                        -- Parameters
                        ["]a"] = {
                            query = "@parameter.inner",
                            desc = "Next parameter start"
                        },

                        -- Scopes (from locals query)
                        ["]s"] = {
                            query = "@local.scope",
                            query_group = "locals",
                            desc = "Next scope start"
                        },

                        -- Folds (from folds query)
                        ["]z"] = {
                            query = "@fold",
                            query_group = "folds",
                            desc = "Next fold start"
                        }
                    },
                    goto_next_end = {
                        ["]F"] = {
                            query = "@function.outer",
                            desc = "Next function end"
                        },
                        ["]C"] = {
                            query = "@class.outer",
                            desc = "Next class end"
                        }
                    },
                    goto_previous_start = {
                        ["[f"] = {
                            query = "@function.outer",
                            desc = "Previous function start"
                        },
                        ["[c"] = {
                            query = "@class.outer",
                            desc = "Previous class start"
                        },
                        ["[o"] = {
                            query = "@loop.*",
                            desc = "Previous loop start"
                        },
                        
                        -- Conditionals (Changed from [d to [i)
                        ["[i"] = {
                            query = "@conditional.outer",
                            desc = "Previous conditional start"
                        },
                        
                        ["[a"] = {
                            query = "@parameter.inner",
                            desc = "Previous parameter start"
                        },
                        ["[s"] = {
                            query = "@local.scope",
                            query_group = "locals",
                            desc = "Previous scope start"
                        },
                        ["[z"] = {
                            query = "@fold",
                            query_group = "folds",
                            desc = "Previous fold start"
                        }
                    },
                    goto_previous_end = {
                        ["[F"] = {
                            query = "@function.outer",
                            desc = "Previous function end"
                        },
                        ["[C"] = {
                            query = "@class.outer",
                            desc = "Previous class end"
                        }
                    }
                },

                -- ----------------------------------------------------------------------
                -- LSP INTEROP
                -- ----------------------------------------------------------------------
                lsp_interop = {
                    enable = true,
                    border = "rounded",
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>df"] = {
                            query = "@function.outer",
                            desc = "\u{f0c1} Peek function definition" --  (link)
                        },
                        ["<leader>dF"] = {
                            query = "@class.outer",
                            desc = "\u{f0c1} Peek class definition" --  (link)
                        }
                    }
                }
            }
        })

        -- ==========================================================================
        -- REPEATABLE MOVEMENTS (like ; and , for f/t)
        -- ==========================================================================
        local ts_repeat_move = require(
            "nvim-treesitter.textobjects.repeatable_move")

        -- Repeat movement with ; and ,
        -- ; goes forward, , goes backward regardless of last direction
        vim.keymap.set({"n", "x", "o"}, ";",
            ts_repeat_move.repeat_last_move_next, {
                desc = "Repeat last move forward"
            })
        vim.keymap.set({"n", "x", "o"}, ",",
            ts_repeat_move.repeat_last_move_previous, {
                desc = "Repeat last move backward"
            })

        -- Make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({"n", "x", "o"}, "f", ts_repeat_move.builtin_f_expr, {
            expr = true
        })
        vim.keymap.set({"n", "x", "o"}, "F", ts_repeat_move.builtin_F_expr, {
            expr = true
        })
        vim.keymap.set({"n", "x", "o"}, "t", ts_repeat_move.builtin_t_expr, {
            expr = true
        })
        vim.keymap.set({"n", "x", "o"}, "T", ts_repeat_move.builtin_T_expr, {
            expr = true
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
        desc = "\u{f062} Go to context" --  (arrow up)
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
-- TREESITTER NOTES (UPDATED)
-- =============================================================================
-- New features added:
--
-- 1. SWAP TEXT OBJECTS (Changed from <leader>a to <leader>s):
--    <leader>sa - Swap current parameter with next
--    <leader>sA - Swap current parameter with previous
--    <leader>sf - Swap current function with next
--    <leader>sF - Swap current function with previous
--
-- 2. REPEATABLE MOVEMENTS:
--    ;  - Repeat last treesitter movement forward
--    ,  - Repeat last treesitter movement backward
--    Works with f/F/t/T as well!
--
-- 3. LSP INTEROP:
--    <leader>df - Peek function definition without leaving buffer
--    <leader>dF - Peek class definition without leaving buffer
--    Press keymap twice to enter floating window
--
-- 4. ADDITIONAL NAVIGATION:
--    ]i / [i - Next/Previous conditional (if/else/switch) [CHANGED from ]d/[d]
--    ]o / [o - Next/Previous loop (for/while)
--    ]s / [s - Next/Previous scope
--    ]z / [z - Next/Previous fold
--    ]a / [a - Next/Previous parameter
--
-- 5. ADDITIONAL TEXT OBJECTS:
--    ab / ib - Around/Inside block
--    as / is - Around/Inside scope (local scope from locals query)
--
-- Existing text objects:
-- af/if  - Around/Inside function
-- ac/ic  - Around/Inside class
-- al/il  - Around/Inside loop
-- ai/ii  - Around/Inside conditional
-- aa/ia  - Around/Inside parameter
--
-- Movement examples:
-- ]f     - Jump to next function start
-- [f     - Jump to previous function start
-- ]F     - Jump to next function end
-- [F     - Jump to previous function end
-- ]c     - Jump to next class
--
-- Workflow tip:
-- 1. Use ]f to jump to next function
-- 2. Use daf to delete entire function
-- 3. Use vif to select inside function
-- 4. Use <leader>sa to swap function parameters
-- 5. Use ; to repeat the last movement
-- =============================================================================