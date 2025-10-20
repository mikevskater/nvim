-- ~\AppData\Local\nvim\lua\myconfig\plugins\whichkey.lua
-- =============================================================================
-- WHICH-KEY - Keybinding Helper (UPDATED)
-- =============================================================================
-- Updated: Modern spec format, icons, presets, better layout
-- =============================================================================
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        -- ==========================================================================
        -- PRESET LAYOUT
        -- ==========================================================================
        preset = "modern",

        -- ==========================================================================
        -- DELAY CONFIGURATION
        -- ==========================================================================
        delay = function(ctx)
            return ctx.plugin and 0 or 200
        end,

        -- ==========================================================================
        -- ICONS
        -- ==========================================================================
        icons = {
            breadcrumb = "\u{00bb}", -- »
            separator = " ",
            group = "\u{002b}" -- +
        },

        -- ==========================================================================
        -- PLUGINS & PRESETS
        -- ==========================================================================
        plugins = {
            marks = true,
            registers = true,

            spelling = {
                enabled = true,
                suggestions = 20
            },

            presets = {
                operators = true,
                motions = true,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true
            }
        },

        -- ==========================================================================
        -- WINDOW OPTIONS
        -- ==========================================================================
        win = {
            border = "rounded",
            padding = {1, 2},
            title = true,
            title_pos = "center",
            zindex = 1000,

            wo = {
                winblend = 0
            }
        },

        -- ==========================================================================
        -- LAYOUT
        -- ==========================================================================
        layout = {
            width = {
                min = 20
            },
            spacing = 3
        },

        -- ==========================================================================
        -- KEY GROUP DEFINITIONS (UPDATED)
        -- ==========================================================================
        spec = { 
        -- ==========================================================================
        -- FIND/TELESCOPE OPERATIONS
        -- ==========================================================================
        {
            "<leader>f",
            group = "Find (Telescope)",
            icon = {
                icon = "\u{f002}",
                color = "blue"
            }
        },
        
        -- Telescope Git subgroup (Changed from <leader>g to <leader>fg)
        {
            "<leader>fg",
            group = "Find Git",
            icon = {
                icon = "\u{f1d3}",
                color = "orange"
            }
        },
        {
            "<leader>fgc",
            desc = "\u{f1d3} Find git commits"
        },
        {
            "<leader>fgs",
            desc = "\u{f126} Find git status"
        },
        {
            "<leader>fgb",
            desc = "\u{f126} Find git branches"
        },
        {
            "<leader>fgS",
            desc = "\u{f01c} Find git stash"
        },
        {
            "<leader>fgC",
            desc = "\u{f1d3} Find buffer commits"
        },

        -- ==========================================================================
        -- GIT OPERATIONS (Fugitive - keeping <leader>g)
        -- ==========================================================================
        {
            "<leader>g",
            group = "Git",
            icon = {
                icon = "\u{f1d3}",
                color = "orange"
            }
        },
        {
            "<leader>gs",
            desc = "\u{f1d3} Git Status"
        }, {
            "<leader>gc",
            desc = "\u{f044} Commit"
        }, {
            "<leader>gC",
            desc = "\u{f044} Commit Amend"
        }, {
            "<leader>gp",
            desc = "\u{f062} Push"
        }, {
            "<leader>gP",
            desc = "\u{f063} Pull"
        }, {
            "<leader>gf",
            desc = "\u{f01e} Fetch"
        }, {
            "<leader>gd",
            desc = "\u{f04b} Diff Split"
        }, {
            "<leader>gD",
            desc = "\u{f338} Diff VSplit"
        }, {
            "<leader>gv",
            desc = "\u{f0e8} 3-way Merge"
        }, {
            "<leader>gb",
            desc = "\u{f05a} Blame"
        }, {
            "<leader>gl",
            desc = "\u{f1da} Log"
        }, {
            "<leader>gL",
            desc = "\u{f1da} Log Pretty"
        }, {
            "<leader>go",
            desc = "\u{f1da} Log (File)"
        }, {
            "<leader>gr",
            desc = "\u{f021} Read (Checkout)"
        }, {
            "<leader>gw",
            desc = "\u{f067} Write (Stage)"
        }, {
            "<leader>ga",
            desc = "\u{f067} Add All"
        }, {
            "<leader>gS",
            desc = "\u{f187} Stash"
        }, {
            "<leader>gA",
            desc = "\u{f187} Stash Apply"
        }, {
            "<leader>gZ",
            desc = "\u{f187} Stash Pop"
        }, {
            "<leader>gm",
            desc = "\u{f0b2} Move/Rename"
        }, {
            "<leader>gx",
            desc = "\u{f1f8} Delete File"
        }, {
            "<leader>gB",
            desc = "\u{f0ac} Browse Web"
        }, {
            "<leader>gg",
            desc = "\u{f002} Grep"
        }, {
            "<leader>gn",
            desc = "\u{f126} New Branch"
        }, {
            "<leader>gt",
            desc = "\u{f126} Checkout Branch"
        },

        -- ==========================================================================
        -- GIT HUNKS (Changed from <leader>h to gh)
        -- ==========================================================================
        {
            "gh",
            group = "Git Hunks",
            icon = {
                icon = "\u{f126}",
                color = "orange"
            }
        },
        {
            mode = {"n", "v"},
            {
                "ghs",
                desc = "\u{f067} Stage hunk"
            },
            {
                "ghr",
                desc = "\u{f0e2} Reset hunk"
            }
        },
        {
            "ghS",
            desc = "\u{f067} Stage buffer"
        }, {
            "ghR",
            desc = "\u{f0e2} Reset buffer"
        }, {
            "ghU",
            desc = "\u{f0e2} Unstage buffer"
        }, {
            "ghu",
            desc = "\u{f0e2} Undo stage hunk"
        }, {
            "ghp",
            desc = "\u{f06e} Preview hunk"
        }, {
            "ghi",
            desc = "\u{f06e} Preview inline"
        }, {
            "ghd",
            desc = "\u{f1e5} Diff this"
        }, {
            "ghD",
            desc = "\u{f1e5} Diff against ~"
        }, {
            "ghb",
            desc = "\u{f1d3} Blame line"
        }, {
            "ght",
            desc = "\u{f1d3} Toggle line blame"
        }, {
            "ghx",
            desc = "\u{f06e} Toggle deleted"
        }, {
            "ghq",
            desc = "\u{f03a} Hunks to quickfix"
        }, {
            "ghl",
            desc = "\u{f03a} Hunks to loclist"
        },

        -- Navigation hints
        {
            mode = "n",
            {
                "]c",
                desc = "\u{f063} Next hunk"
            },
            {
                "[c",
                desc = "\u{f062} Prev hunk"
            },
            {
                "]H",
                desc = "\u{f063} Last hunk"
            },
            {
                "[H",
                desc = "\u{f062} First hunk"
            }
        },

        -- ==========================================================================
        -- HARPOON (Keeping <leader>h)
        -- ==========================================================================
        {
            "<leader>h",
            group = "Harpoon",
            icon = {
                icon = "\u{f02e}",
                color = "azure"
            }
        },
        {
            "<leader>h",
            desc = "\u{f03a} Toggle Harpoon menu"
        },
        {
            "<leader>ha",
            desc = "\u{f02e} Add file to Harpoon"
        },
        {
            "<leader>hp",
            desc = "\u{f060} Previous Harpoon file"
        }, {
            "<leader>hn",
            desc = "\u{f061} Next Harpoon file"
        },
        {
            "<leader>h1",
            desc = "\u{2780} Harpoon File 1"
        }, {
            "<leader>h2",
            desc = "\u{2781} Harpoon File 2"
        }, {
            "<leader>h3",
            desc = "\u{2782} Harpoon File 3"
        }, {
            "<leader>h4",
            desc = "\u{2783} Harpoon File 4"
        }, {
            "<leader>h5",
            desc = "\u{2784} Harpoon File 5"
        }, {
            "<leader>h6",
            desc = "\u{2785} Harpoon File 6"
        }, {
            "<leader>h7",
            desc = "\u{2786} Harpoon File 7"
        }, {
            "<leader>h8",
            desc = "\u{2787} Harpoon File 8"
        }, {
            "<leader>h9",
            desc = "\u{2788} Harpoon File 9"
        },

        -- ==========================================================================
        -- DATABASE (Changed from <leader>d to <leader>q)
        -- ==========================================================================
        {
            "<leader>q",
            group = "Database/Query",
            icon = {
                icon = "\u{f1c0}",
                color = "azure"
            }
        },
        {
            "<leader>qb",
            desc = "\u{f1c0} Toggle Database UI"
        }, {
            "<leader>qa",
            desc = "\u{f067} Add Connection"
        }, {
            "<leader>qf",
            desc = "\u{f002} Find Database Buffer"
        }, {
            "<leader>qr",
            desc = "\u{f040} Rename Database Buffer"
        }, {
            "<leader>ql",
            desc = "\u{f05a} Last Query Info"
        }, {
            "<leader>qw",
            desc = "\u{f0c7} Save Query"
        }, {
            "<leader>qx",
            desc = "\u{f04b} Execute Query"
        }, {
            "<leader>qe",
            desc = "\u{f040} Edit Bind Parameters"
        }, {
            "<leader>qv",
            desc = "\u{f338} Open in Vertical Split"
        }, {
            "<leader>qj",
            desc = "\u{f0c1} Jump to Foreign Key"
        },

        -- ==========================================================================
        -- DEBUG (Keeping <leader>d)
        -- ==========================================================================
        {
            "<leader>d",
            group = "Debug (DAP)",
            icon = {
                icon = "\u{f188}",
                color = "red"
            }
        },
        {
            "<leader>dc",
            desc = "\u{f04b} Continue"
        },
        {
            "<leader>dC",
            desc = "\u{f0a4} Run to Cursor"
        },
        {
            "<leader>dR",
            desc = "\u{f01e} Restart Session"
        },
        {
            "<leader>dp",
            desc = "\u{f04c} Pause"
        },
        {
            "<leader>dt",
            desc = "\u{f04d} Terminate"
        },
        {
            "<leader>db",
            desc = "\u{f111} Toggle Breakpoint"
        },
        {
            "<leader>dB",
            desc = "\u{f059} Conditional Breakpoint"
        },
        {
            "<leader>dL",
            desc = "\u{f05a} Log Point"
        },
        {
            "<leader>du",
            desc = "\u{f2d0} Toggle UI"
        },
        {
            "<leader>df",
            desc = "\u{f2d2} Float Element"
        },
        {
            mode = {"n", "v"},
            {
                "<leader>de",
                desc = "\u{f06e} Eval Expression"
            }
        },
        {
            "<leader>dE",
            desc = "\u{f120} Eval (Prompt)"
        },
        {
            "<leader>dh",
            desc = "\u{f05a} Hover Info"
        },
        {
            "<leader>dr",
            desc = "\u{f120} Open REPL"
        },
        {
            "<leader>dl",
            desc = "\u{f04b} Run Last Config"
        },

        -- Debug step subgroup
        {
            "<leader>ds",
            group = "Step",
            icon = {
                icon = "\u{f04b}",
                color = "green"
            }
        },
        {
            "<leader>dso",
            desc = "\u{f063} Step Over"
        },
        {
            "<leader>dsi",
            desc = "\u{f062} Step Into"
        },
        {
            "<leader>dsO",
            desc = "\u{f062} Step Out"
        },
        {
            "<leader>dsb",
            desc = "\u{f04a} Step Back"
        },

        -- ==========================================================================
        -- SWAP/REPLACE (Changed treesitter from <leader>a to <leader>s)
        -- ==========================================================================
        {
            "<leader>s",
            group = "Swap/Replace",
            icon = {
                icon = "\u{f0ec}",
                color = "yellow"
            }
        },
        {
            "<leader>s",
            desc = "\u{f002} Replace word under cursor"
        },
        {
            "<leader>sa",
            desc = "\u{f362} Swap next parameter"
        },
        {
            "<leader>sA",
            desc = "\u{f361} Swap prev parameter"
        },
        {
            "<leader>sf",
            desc = "\u{f362} Swap next function"
        },
        {
            "<leader>sF",
            desc = "\u{f361} Swap prev function"
        },
        {
            "<leader>so",
            desc = "\u{f021} Source file"
        },

        -- ==========================================================================
        -- CODE ACTIONS
        -- ==========================================================================
        {
            "<leader>c",
            group = "Code",
            icon = {
                icon = "\u{f121}",
                color = "cyan"
            }
        },

        -- ==========================================================================
        -- BUFFER OPERATIONS (Updated delete to <leader>bx)
        -- ==========================================================================
        {
            "<leader>b",
            group = "Buffer",
            icon = {
                icon = "\u{f0c5}",
                color = "yellow"
            }
        },
        {
            "<leader>bx",
            desc = "\u{f00d} Delete buffer"
        },
        {
            "<leader>bd",
            desc = "\u{f07b} Sort by directory"
        },

        -- ==========================================================================
        -- WINDOW/WORKSPACE MANAGEMENT
        -- ==========================================================================
        {
            "<leader>w",
            group = "Workspace/Window",
            icon = {
                icon = "\u{f0b1}",
                color = "purple"
            }
        },
        {
            "<leader>w",
            desc = "\u{f0c7} Save file"
        },
        {
            "<leader>ws",
            desc = "\u{f002} Workspace symbols"
        },
        {
            "<leader>wa",
            desc = "\u{f067} Add workspace folder"
        },
        {
            "<leader>wr",
            desc = "\u{f068} Remove workspace folder"
        },
        {
            "<leader>wl",
            desc = "\u{f03a} List workspace folders"
        },

        -- ==========================================================================
        -- LSP OPERATIONS
        -- ==========================================================================
        {
            "<leader>l",
            group = "LSP",
            icon = {
                icon = "\u{f085}",
                color = "purple"
            }
        },
        {
            "gr",
            group = "LSP (Go/References)",
            icon = {
                icon = "\u{f1e5}",
                color = "cyan"
            }
        },
        {
            mode = {"n"},
            {
                "gri",
                desc = "\u{f121} Implementation"
            },
            {
                "grr",
                desc = "\u{f126} References"
            },
            {
                "grt",
                desc = "\u{f1bb} Type definition"
            },
            {
                "gra",
                desc = "\u{f0eb} Code action"
            },
            {
                "grn",
                desc = "\u{f040} Rename"
            }
        },

        -- ==========================================================================
        -- FLASH/JUMP OPERATIONS
        -- ==========================================================================
        {
            "<leader>j",
            group = "Jump (Flash)",
            icon = {
                icon = "\u{26a1}",
                color = "cyan"
            }
        },
        {
            "<leader>jl",
            desc = "\u{f0c9} Jump to Line"
        },
        {
            "<leader>jw",
            desc = "\u{f031} Jump to Word"
        },
        {
            "<leader>jc",
            desc = "\u{f021} Continue Last Jump"
        },
        {
            "<leader>jd",
            desc = "\u{f188} Jump to Diagnostic"
        },

        -- ==========================================================================
        -- UNDOTREE
        -- ==========================================================================
        {
            "<F4>",
            desc = "\u{f1da} Toggle Undotree"
        },
        {
            "<leader>u",
            desc = "\u{f1da} Toggle Undotree"
        },
        {
            "<leader>uf",
            desc = "\u{f002} Focus Undotree"
        },
        {
            "<leader>us",
            desc = "\u{f06e} Show Undotree"
        },
        {
            "<leader>uh",
            desc = "\u{f070} Hide Undotree"
        },

        -- ==========================================================================
        -- OIL.NVIM
        -- ==========================================================================
        {
            "<leader>o",
            desc = "\u{f07c} Oil (current file)"
        }, {
            "<leader>O",
            desc = "\u{f07b} Oil (cwd)"
        }, {
            "-",
            desc = "\u{f07c} Parent directory"
        }, {
            "<leader>-",
            desc = "\u{f2d2} Oil float"
        },

        -- ==========================================================================
        -- TREESITTER NAVIGATION (Updated conditionals to ]i/[i)
        -- ==========================================================================
        {
            mode = "n",
            {
                "]i",
                desc = "\u{f063} Next conditional"
            },
            {
                "[i",
                desc = "\u{f062} Prev conditional"
            },
            {
                "]d",
                desc = "\u{f063} Next diagnostic"
            },
            {
                "[d",
                desc = "\u{f062} Prev diagnostic"
            },
            {
                "[D",
                desc = "\u{f062} First diagnostic"
            },
            {
                "]D",
                desc = "\u{f063} Last diagnostic"
            }
        },

        -- ==========================================================================
        -- COMMENT.NVIM
        -- ==========================================================================
        {
            mode = "n",
            {
                "gc",
                desc = "\u{f075} Comment (motion)"
            },
            {
                "gcc",
                desc = "\u{f075} Toggle line comment"
            },
            {
                "gco",
                desc = "\u{f078} Comment below + INSERT"
            },
            {
                "gcO",
                desc = "\u{f077} Comment above + INSERT"
            },
            {
                "gcA",
                desc = "\u{f061} Comment EOL + INSERT"
            },
            {
                "gb",
                desc = "\u{f10b} Block comment (motion)"
            },
            {
                "gbc",
                desc = "\u{f10b} Toggle block comment"
            }
        },
        {
            mode = "x",
            {
                "gc",
                desc = "\u{f075} Comment selection (linewise)"
            },
            {
                "gb",
                desc = "\u{f10b} Comment selection (blockwise)"
            }
        },

        -- ==========================================================================
        -- NVIM-SURROUND
        -- ==========================================================================
        {
            mode = "n",
            {
                "ys",
                desc = "\u{f104}\u{f105} Add surround (motion)"
            },
            {
                "yss",
                desc = "\u{f104}\u{f105} Add surround (line)"
            },
            {
                "yS",
                desc = "\u{f104}\u{23ce}\u{f105} Add surround (new lines)"
            },
            {
                "ySS",
                desc = "\u{f104}\u{23ce}\u{f105} Add surround (line, new lines)"
            },
            {
                "ds",
                desc = "\u{f00d} Delete surround"
            },
            {
                "cs",
                desc = "\u{f021} Change surround"
            },
            {
                "cS",
                desc = "\u{f021}\u{23ce} Change surround (new lines)"
            }
        },
        {
            mode = "x",
            {
                "S",
                desc = "\u{f104}\u{f105} Surround selection"
            },
            {
                "gS",
                desc = "\u{f104}\u{23ce}\u{f105} Surround selection (new lines)"
            }
        },

        -- ==========================================================================
        -- MISC KEYBINDINGS
        -- ==========================================================================
        {
            mode = {"n", "v"},
            {
                "<leader>y",
                desc = "\u{f0c5} Yank to clipboard"
            },
            {
                "<leader>d",
                desc = "\u{f00d} Delete without yank"
            }
        },
        {
            "<leader><leader>",
            desc = "\u{f021} Resume Telescope"
        }, {
            "<leader>Q",
            desc = "\u{f2d1} Quit"
        },
        {
            "z=",
            desc = "\u{f0eb} Spell Suggestions"
        }}
    },

    -- ==========================================================================
    -- ADDITIONAL KEYBINDINGS
    -- ==========================================================================
    keys = {{
        "<leader>?",
        function()
            require("which-key").show({
                global = false
            })
        end,
        desc = "\u{f059} Buffer Local Keymaps"
    }}
}

-- =============================================================================
-- WHICH-KEY NOTES (UPDATED)
-- =============================================================================
-- Major changes applied:
--
-- 1. Git Hunks: <leader>h → gh
--    - All git hunk operations now use gh prefix
--    - Harpoon reclaimed <leader>h
--
-- 2. Database: <leader>d → <leader>q
--    - All database operations now use <leader>q
--    - Debug (DAP) reclaimed <leader>d
--
-- 3. Harpoon: Updated to use <leader>h
--    - <leader>ha - Add file
--    - <leader>h - Toggle menu
--    - <leader>h1-9 - Jump to files
--    - Removed conflicting Ctrl bindings
--
-- 4. Treesitter Swap: <leader>a → <leader>s
--    - <leader>sa/sA - Swap parameters
--    - <leader>sf/sF - Swap functions
--
-- 5. Treesitter Conditionals: ]d/[d → ]i/[i
--    - Diagnostics keep ]d/[d
--
-- 6. Telescope Git: <leader>g → <leader>fg
--    - Git telescope pickers under <leader>fg prefix
--
-- 7. Source file: <leader><leader> → <leader>so
--    - Resume Telescope keeps <leader><leader>
--
-- 8. Buffer delete: <leader>bd → <leader>bx
--    - Sort by directory keeps <leader>bd
-- =============================================================================