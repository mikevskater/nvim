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
        -- "classic" - Traditional which-key layout
        -- "modern"  - Cleaner, more spacious layout
        -- "helix"   - Helix-editor style layout
        preset = "modern",

        -- ==========================================================================
        -- DELAY CONFIGURATION
        -- ==========================================================================
        -- Delay before showing popup (in ms)
        delay = function(ctx)
            return ctx.plugin and 0 or 200 -- No delay for plugins, 200ms for user
        end,

        -- ==========================================================================
        -- ICONS
        -- ==========================================================================
        icons = {
            breadcrumb = "\u{00bb}", -- »
            separator = " ", -- "\u{27a1}", -- ➡
            group = "\u{002b}" -- +
        },

        -- ==========================================================================
        -- PLUGINS & PRESETS
        -- ==========================================================================
        plugins = {
            marks = true, -- Show marks in which-key
            registers = true, -- Show registers in which-key

            spelling = {
                enabled = true,
                suggestions = 20
            },

            -- Built-in help for common Vim bindings
            presets = {
                operators = true, -- Help for d, y, c, etc.
                motions = true, -- Help for w, b, e, etc.
                text_objects = true, -- Help for i, a text objects
                windows = true, -- Help for <C-w> bindings
                nav = true, -- Misc window navigation
                z = true, -- Bindings for folds, spelling, etc.
                g = true -- Bindings starting with g
            }
        },

        -- ==========================================================================
        -- WINDOW OPTIONS
        -- ==========================================================================
        win = {
            border = "rounded", -- rounded, single, double, shadow, none
            padding = {1, 2}, -- [top/bottom, left/right]
            title = true, -- Show title
            title_pos = "center", -- left, center, right
            zindex = 1000,

            -- Window transparency (0-100)
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
            spacing = 3 -- Spacing between columns
        },

        -- ==========================================================================
        -- KEY GROUP DEFINITIONS (NEW SPEC FORMAT)
        -- ==========================================================================
        spec = { -- File/Find operations (Telescope)
        {
            "<leader>f",
            group = "Find (Telescope)",
            icon = {
                icon = "\u{f002}", --  (search)
                color = "blue"
            }
        }, -- Git operations (Fugitive)
        {
            "<leader>g",
            group = "Git",
            icon = {
                icon = "\u{f1d3}", --  (git logo)
                color = "orange"
            }
        }, -- Git subcommands (documented individually for clarity)
        {
            "<leader>gs",
            desc = "\u{f1d3} Git Status", --  (git logo)
            icon = {
                icon = "\u{f1d3}",
                color = "orange"
            }
        }, {
            "<leader>gc",
            desc = "\u{f044} Commit", --  (edit)
            icon = {
                icon = "\u{f044}",
                color = "green"
            }
        }, {
            "<leader>gC",
            desc = "\u{f044} Commit Amend", --  (edit)
            icon = {
                icon = "\u{f044}",
                color = "yellow"
            }
        }, {
            "<leader>gp",
            desc = "\u{f062} Push", --  (arrow up)
            icon = {
                icon = "\u{f062}",
                color = "blue"
            }
        }, {
            "<leader>gP",
            desc = "\u{f063} Pull", --  (arrow down)
            icon = {
                icon = "\u{f063}",
                color = "cyan"
            }
        }, {
            "<leader>gf",
            desc = "\u{f01e} Fetch", --  (refresh)
            icon = {
                icon = "\u{f01e}",
                color = "azure"
            }
        }, {
            "<leader>gd",
            desc = "\u{f04b} Diff Split", --  (code branch)
            icon = {
                icon = "\u{f04b}",
                color = "yellow"
            }
        }, {
            "<leader>gD",
            desc = "\u{f338} Diff VSplit", --  (columns)
            icon = {
                icon = "\u{f338}",
                color = "yellow"
            }
        }, {
            "<leader>gv",
            desc = "\u{f0e8} 3-way Merge", --  (sitemap)
            icon = {
                icon = "\u{f0e8}",
                color = "red"
            }
        }, {
            "<leader>gb",
            desc = "\u{f05a} Blame", --  (info)
            icon = {
                icon = "\u{f05a}",
                color = "purple"
            }
        }, {
            "<leader>gl",
            desc = "\u{f1da} Log", --  (history)
            icon = {
                icon = "\u{f1da}",
                color = "cyan"
            }
        }, {
            "<leader>gL",
            desc = "\u{f1da} Log Pretty", --  (history)
            icon = {
                icon = "\u{f1da}",
                color = "cyan"
            }
        }, {
            "<leader>go",
            desc = "\u{f1da} Log (File)", --  (history)
            icon = {
                icon = "\u{f1da}",
                color = "azure"
            }
        }, {
            "<leader>gr",
            desc = "\u{f021} Read (Checkout)", --  (refresh)
            icon = {
                icon = "\u{f021}",
                color = "red"
            }
        }, {
            "<leader>gw",
            desc = "\u{f067} Write (Stage)", --  (plus)
            icon = {
                icon = "\u{f067}",
                color = "green"
            }
        }, {
            "<leader>ga",
            desc = "\u{f067} Add All", --  (plus)
            icon = {
                icon = "\u{f067}",
                color = "green"
            }
        }, {
            "<leader>gS",
            desc = "\u{f187} Stash", --  (archive)
            icon = {
                icon = "\u{f187}",
                color = "grey"
            }
        }, {
            "<leader>gA",
            desc = "\u{f187} Stash Apply", --  (archive)
            icon = {
                icon = "\u{f187}",
                color = "green"
            }
        }, {
            "<leader>gZ",
            desc = "\u{f187} Stash Pop", --  (archive)
            icon = {
                icon = "\u{f187}",
                color = "cyan"
            }
        }, {
            "<leader>gm",
            desc = "\u{f0b2} Move/Rename", --  (arrows)
            icon = {
                icon = "\u{f0b2}",
                color = "yellow"
            }
        }, {
            "<leader>gx",
            desc = "\u{f1f8} Delete File", --  (trash)
            icon = {
                icon = "\u{f1f8}",
                color = "red"
            }
        }, {
            "<leader>gB",
            desc = "\u{f0ac} Browse Web", --  (globe)
            icon = {
                icon = "\u{f0ac}",
                color = "blue"
            }
        }, {
            "<leader>gg",
            desc = "\u{f002} Grep", --  (search)
            icon = {
                icon = "\u{f002}",
                color = "azure"
            }
        }, {
            "<leader>gn",
            desc = "\u{f126} New Branch", --  (code branch)
            icon = {
                icon = "\u{f126}",
                color = "green"
            }
        }, {
            "<leader>gt",
            desc = "\u{f126} Checkout Branch", --  (code branch)
            icon = {
                icon = "\u{f126}",
                color = "orange"
            }
        }, -- Git hunks (from gitsigns)
        {
            "<leader>h",
            group = "Git Hunks",
            icon = {
                icon = "\u{f126}", --  (branch/fork)
                color = "orange"
            }
        }, -- Debug/Diagnostics (NOTE: <leader>d is overloaded - used for both Debug and Database)
        -- Database plugin takes priority for <leader>db, <leader>df, <leader>dr, etc.
        -- To see debug options, use <leader>ds (step) or other debug-specific prefixes
        {
            "<leader>d",
            group = "Database/Debug",
            icon = {
                icon = "\u{f1c0}", --  (database icon, since database is more commonly used)
                color = "azure"
            }
        }, -- Database subgroup (takes precedence when DBUI is active)
        {
            "<leader>db",
            desc = "\u{f1c0} Toggle Database UI", -- Specific binding, not a group
            icon = {
                icon = "\u{f1c0}", --  (database)
                color = "azure"
            }
        }, {
            "<leader>da",
            desc = "\u{f067} Add Connection" -- Specific database binding
        }, {
            "<leader>df",
            desc = "\u{f002} Find Database Buffer" -- Specific database binding
        }, {
            "<leader>dw",
            desc = "\u{f0c7} Save Query" -- Specific database binding (SQL buffers)
        }, {
            "<leader>dx",
            desc = "\u{f04b} Execute Query" -- Specific database binding (SQL buffers)
        }, {
            "<leader>dS",
            desc = "\u{f338} Open in Vertical Split" -- Specific database binding
        }, {
            "<leader>dJ",
            desc = "\u{f0c1} Jump to Foreign Key" -- Specific database binding
        }, -- Debug subgroups (use these when debugging)
        {
            "<leader>ds",
            group = "Step",
            icon = {
                icon = "\u{f04b}", --  (play)
                color = "green"
            }
        }, {
            "<leader>du",
            group = "UI",
            icon = {
                icon = "\u{f2d0}", --  (window)
                color = "cyan"
            }
        }, -- Code actions
        {
            "<leader>c",
            group = "Code",
            icon = {
                icon = "\u{f121}", --  (code)
                color = "cyan"
            }
        }, -- Buffer operations
        {
            "<leader>b",
            group = "Buffer",
            icon = {
                icon = "\u{f0c5}", --  (files)
                color = "yellow"
            }
        }, -- Window/split operations
        {
            "<leader>w",
            group = "Window",
            icon = {
                icon = "\u{f2d0}", --  (window)
                color = "green"
            }
        }, -- LSP operations
        {
            "<leader>l",
            group = "LSP",
            icon = {
                icon = "\u{f085}", --  (gears)
                color = "purple"
            }
        }, -- Flash/Jump operations (extended)
        {
            "<leader>j",
            group = "Jump (Flash)",
            icon = {
                icon = "\u{26a1}", -- ⚡ (lightning bolt)
                color = "cyan"
            }
        }, {
            "<leader>jl",
            desc = "\u{f0c9} Jump to Line" --  (list)
        }, {
            "<leader>jw",
            desc = "\u{f031} Jump to Word" --  (text)
        }, {
            "<leader>jc",
            desc = "\u{f021} Continue Last Jump" --  (refresh/repeat)
        }, {
            "<leader>jd",
            desc = "\u{f188} Jump to Diagnostic" --  (bug)
        },
        -- ==========================================================================
        -- UNDOTREE - Undo History Visualization
        -- ==========================================================================

        -- F5 keymap (canonical/official)
        {
            "<F4>",
            desc = "\u{f1da} Toggle Undotree", --  (history)
            icon = {
                icon = "\u{f1da}",
                color = "purple"
            }
        }, -- Leader-based toggle (your existing keymap, updated icon)
        {
            "<leader>u",
            desc = "\u{f1da} Toggle Undotree", --  (history)
            icon = {
                icon = "\u{f1da}",
                color = "purple"
            }
        }, -- Undotree subgroup (optional, for additional commands)
        {
            "<leader>u",
            group = "Undotree",
            icon = {
                icon = "\u{f1da}", --  (history)
                color = "purple"
            }
        }, -- Undotree subcommands
        {
            "<leader>uf",
            desc = "\u{f002} Focus Undotree", --  (search/focus)
            icon = {
                icon = "\u{f002}",
                color = "azure"
            }
        }, {
            "<leader>us",
            desc = "\u{f06e} Show Undotree", --  (eye)
            icon = {
                icon = "\u{f06e}",
                color = "green"
            }
        }, {
            "<leader>uh",
            desc = "\u{f070} Hide Undotree", --  (eye-slash)
            icon = {
                icon = "\u{f070}",
                color = "grey"
            }
        },
        -- ==========================================================================
        -- AUTOPAIRS - Auto-close Brackets/Quotes
        -- ==========================================================================

        -- Main autopairs group
        {
            "<leader>a",
            group = "Auto-pairs",
            icon = {
                icon = "\u{f0c1}", --  (link/chain - represents pairing)
                color = "cyan"
            }
        }, -- Toggle auto-pairs
        {
            "<leader>ap",
            desc = "\u{f074} Toggle Auto-pairs", --  (random/shuffle)
            icon = {
                icon = "\u{f074}",
                color = "yellow"
            }
        }, -- Enable auto-pairs
        {
            "<leader>ape",
            desc = "\u{f00c} Enable Auto-pairs", --  (check mark)
            icon = {
                icon = "\u{f00c}",
                color = "green"
            }
        }, -- Disable auto-pairs
        {
            "<leader>apd",
            desc = "\u{f00d} Disable Auto-pairs", --  (times/x)
            icon = {
                icon = "\u{f00d}",
                color = "red"
            }
        }, -- Fast wrap (insert mode - documented for reference)
        {
            mode = "i",
            {
                "<M-e>",
                desc = "\u{f0c1} Fast Wrap", --  (link/chain)
                icon = {
                    icon = "\u{f0c1}",
                    color = "cyan"
                }
            }
        },
        -- ==========================================================================
        -- COMPLETION (BLINK.CMP) - Insert Mode Reference
        -- ==========================================================================
        -- Note: These are insert mode mappings, shown here for documentation
        {
            mode = {"i"},
            {
                "<CR>",
                desc = "\u{f00c} Accept completion" -- ✓ (check)
            },
            {
                "<C-y>",
                desc = "\u{f00c} Select and accept" -- ✓
            },
            {
                "<C-l>",
                desc = "\u{f00c} Accept (alt)" -- ✓
            },
            {
                "<C-space>",
                desc = "\u{f05a} Show documentation" -- ℹ (info)
            },
            {
                "<C-e>",
                desc = "\u{f00d} Hide completion" -- ✕ (close)
            },
            {
                "<C-g>",
                desc = "\u{f05e} Cancel completion" -- ⛔ (ban)
            },
            {
                "<C-b>",
                desc = "\u{f062} Scroll docs up" -- ↑ (arrow up)
            },
            {
                "<C-f>",
                desc = "\u{f063} Scroll docs down" -- ↓ (arrow down)
            },
            {
                "<C-k>",
                desc = "\u{f059} Signature help" -- ❓ (question)
            },
            {
                "<M-k>",
                desc = "\u{f062} Scroll signature up" -- ↑
            },
            {
                "<M-j>",
                desc = "\u{f063} Scroll signature down" -- ↓
            },
            {
                "<Tab>",
                desc = "\u{f061} Next snippet/item" -- → (arrow right)
            },
            {
                "<S-Tab>",
                desc = "\u{f060} Prev snippet/item" -- ← (arrow left)
            }
        }, -- Grouping (optional - for organization in which-key display)
        {
            group = "Completion",
            icon = {
                icon = "\u{f0c7}", -- 💾 (save/complete)
                color = "green"
            }
        },
        -- ==========================================================================
        -- GIT SIGNS - Git Decorations
        -- ==========================================================================
        {
            "<leader>h",
            group = "Git Hunks",
            icon = {
                icon = "\u{f126}", --  (branch/fork)
                color = "orange"
            }
        }, -- Individual hunk keymaps
        {
            mode = {"n", "v"},
            {
                "<leader>hs",
                desc = "\u{f067} Stage hunk"
            },
            {
                "<leader>hr",
                desc = "\u{f0e2} Reset hunk"
            }
        }, -- Normal mode only
        {
            "<leader>hS",
            desc = "\u{f067} Stage buffer"
        }, {
            "<leader>hR",
            desc = "\u{f0e2} Reset buffer"
        }, {
            "<leader>hU",
            desc = "\u{f0e2} Unstage buffer"
        }, {
            "<leader>hu",
            desc = "\u{f0e2} Undo stage hunk"
        }, {
            "<leader>hp",
            desc = "\u{f06e} Preview hunk"
        }, {
            "<leader>hi",
            desc = "\u{f06e} Preview inline"
        }, {
            "<leader>hd",
            desc = "\u{f1e5} Diff this"
        }, {
            "<leader>hD",
            desc = "\u{f1e5} Diff against ~"
        }, {
            "<leader>hb",
            desc = "\u{f1d3} Blame line"
        }, {
            "<leader>hq",
            desc = "\u{f03a} Hunks to quickfix"
        }, {
            "<leader>hl",
            desc = "\u{f03a} Hunks to loclist"
        }, -- Toggle group
        {
            "<leader>t",
            group = "Toggle",
            icon = {
                icon = "\u{f204}", --  (toggle-on)
                color = "cyan"
            }
        }, {
            "<leader>tb",
            desc = "\u{f1d3} Toggle line blame"
        }, {
            "<leader>td",
            desc = "\u{f06e} Toggle deleted"
        },

        -- Navigation hints (these work automatically but can add to which-key for visibility)
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
        -- OIL.NVIM - File Explorer as Buffer
        -- ==========================================================================
        {
            "<leader>o",
            group = "Oil",
            icon = {
                icon = "\u{f07c}", --  (folder open)
                color = "yellow"
            }
        }, -- Individual Oil keymaps (ADDED)
        {
            "<leader>o",
            desc = "\u{f07c} Oil (current file)" --  (folder open)
        }, {
            "<leader>O",
            desc = "\u{f07b} Oil (cwd)" --  (folder)
        }, {
            "-",
            desc = "\u{f07c} Parent directory" --  (folder open)
        }, {
            "<leader>-",
            desc = "\u{f2d2} Oil float" --  (window maximize)
        },
        -- ==========================================================================
        -- LSP GROUP DEFINITIONS
        -- ==========================================================================
        {
            "gr",
            group = "LSP (Go/References)",
            icon = {
                icon = "\u{f1e5}", --  (location arrow)
                color = "cyan"
            }
        }, {
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
        }, -- LSP Workspace operations
        {
            "<leader>w",
            group = "Workspace/Window",
            icon = {
                icon = "\u{f0b1}", --  (briefcase)
                color = "purple"
            }
        }, {
            mode = {"n"},
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
            }
        }, -- Call hierarchy
        {
            mode = {"n"},
            {
                "<leader>ic",
                desc = "\u{f01e} Incoming calls"
            },
            {
                "<leader>oc",
                desc = "\u{f01e} Outgoing calls"
            },
            {
                "<leader>cl",
                desc = "\u{f135} Run code lens"
            }
        }, -- Enhanced diagnostic descriptions
        {
            mode = {"n"},
            {
                "[D",
                desc = "\u{f062} First diagnostic"
            },
            {
                "]D",
                desc = "\u{f063} Last diagnostic"
            },
            {
                "<C-w>d",
                desc = "\u{f05a} Show diagnostic"
            },
            {
                "<leader>dq",
                desc = "\u{f03a} Diagnostic quickfix"
            }
        },
        -- =============================================================================
        -- TELESCOPE GROUPS (Add to existing spec table)
        -- =============================================================================

        -- Main Telescope/Find group (already exists, just showing for reference)
        {
            "<leader>f",
            group = "Find (Telescope)",
            icon = {
                icon = "\u{f002}",
                color = "blue"
            }
        }, -- LSP group (add LSP telescope pickers)
        {
            "<leader>l",
            group = "LSP",
            icon = {
                icon = "\u{f085}",
                color = "purple"
            }
        },

        -- =============================================================================
        -- NEW TELESCOPE KEYMAPS (Add these to spec table)
        -- =============================================================================

        -- Resume picker (CRITICAL - override the existing <leader><leader> if present)
        {
            "<leader><leader>",
            desc = "\u{f021} Resume Telescope"
        }, -- File pickers
        {
            "<leader>fp",
            desc = "\u{f1e5} Telescope Pickers"
        }, -- Search pickers
        {
            "<leader>f.",
            desc = "\u{f002} Search Buffer"
        }, -- Vim internals
        {
            "<leader>f:",
            desc = "\u{f489} Command History"
        }, {
            "<leader>f/",
            desc = "\u{f002} Search History"
        }, {
            "<leader>f\"",
            desc = "\u{f0c5} Registers"
        }, {
            "<leader>fm",
            desc = "\u{f02e} Marks"
        }, {
            "<leader>fj",
            desc = "\u{f0e2} Jumplist"
        }, {
            "<leader>fo",
            desc = "\u{f013} Vim Options"
        }, {
            "<leader>fa",
            desc = "\u{f085} Autocommands"
        }, {
            "<leader>fH",
            desc = "\u{f043} Highlights"
        }, {
            "<leader>fT",
            desc = "\u{f016} Filetypes"
        }, -- Quickfix & Location List
        {
            "<leader>fq",
            desc = "\u{f0cb} Quickfix List"
        }, {
            "<leader>fl",
            desc = "\u{f03a} Location List"
        }, -- Git pickers (add to existing git group)
        {
            "<leader>gb",
            desc = "\u{f126} Git Branches"
        }, {
            "<leader>gS",
            desc = "\u{f01c} Git Stash"
        }, {
            "<leader>gC",
            desc = "\u{f1d3} Buffer Commits"
        }, -- LSP pickers (add to LSP group)
        {
            "<leader>ls",
            desc = "\u{f121} Document Symbols"
        }, {
            "<leader>lS",
            desc = "\u{f1e5} Workspace Symbols"
        }, {
            "<leader>lw",
            desc = "\u{f002} Workspace (Dynamic)"
        }, {
            "<leader>li",
            desc = "\u{f060} Incoming Calls"
        }, {
            "<leader>lo",
            desc = "\u{f061} Outgoing Calls"
        }, -- Misc pickers
        {
            "<leader>fC",
            desc = "\u{f043} Colorscheme"
        }, {
            "<leader>ft",
            desc = "\u{f1bb} Treesitter Symbols"
        }, {
            "<leader>fM",
            desc = "\u{f02d} Man Pages"
        }, -- Spell suggest (override default z=)
        {
            "z=",
            desc = "\u{f0eb} Spell Suggestions"
        },

        -- =============================================================================
        -- COMPLETE EXAMPLE OF UPDATED SPEC TABLE
        -- =============================================================================
        -- Here's how your complete spec table should look with all additions:
        --
        -- spec = {
        --     -- File/Find operations (Telescope)
        --     {
        --         "<leader>f",
        --         group = "Find (Telescope)",
        --         icon = { icon = "\u{f002}", color = "blue" }
        --     },
        --     
        --     -- Git operations
        --     {
        --         "<leader>g",
        --         group = "Git",
        --         icon = { icon = "\u{f1d3}", color = "orange" }
        --     },
        --     
        --     -- LSP operations
        --     {
        --         "<leader>l",
        --         group = "LSP",
        --         icon = { icon = "\u{f085}", color = "purple" }
        --     },
        --     
        --     -- ... (other existing groups)
        --     
        --     -- All the new keymaps listed above
        --     {
        --         "<leader><leader>",
        --         desc = "\u{f021} Resume Telescope"
        --     },
        --     -- ... etc
        -- }
        -- ==========================================================================
        -- HARPOON - File Marks & Navigation
        -- ==========================================================================
        -- Main harpoon group
        {
            "<leader>h",
            group = "Harpoon",
            icon = {
                icon = "\u{f02e}", --  (bookmark)
                color = "azure"
            }
        }, -- Harpoon core operations
        {
            "<leader>a",
            desc = "\u{f02e} Add file to Harpoon", --  (bookmark)
            icon = {
                icon = "\u{f02e}",
                color = "green"
            }
        }, -- Harpoon navigation
        {
            "<leader>hp",
            desc = "\u{f060} Previous Harpoon file", --  (arrow left)
            icon = {
                icon = "\u{f060}",
                color = "cyan"
            }
        }, {
            "<leader>hn",
            desc = "\u{f061} Next Harpoon file", --  (arrow right)
            icon = {
                icon = "\u{f061}",
                color = "cyan"
            }
        }, -- Harpoon quick jumps (5-9)
        {
            "<leader>h5",
            desc = "\u{2784} Harpoon File 5", -- ➄
            icon = {
                icon = "\u{2784}",
                color = "azure"
            }
        }, {
            "<leader>h6",
            desc = "\u{2785} Harpoon File 6", -- ➅
            icon = {
                icon = "\u{2785}",
                color = "azure"
            }
        }, {
            "<leader>h7",
            desc = "\u{2786} Harpoon File 7", -- ➆
            icon = {
                icon = "\u{2786}",
                color = "azure"
            }
        }, {
            "<leader>h8",
            desc = "\u{2787} Harpoon File 8", -- ➇
            icon = {
                icon = "\u{2787}",
                color = "azure"
            }
        }, {
            "<leader>h9",
            desc = "\u{2788} Harpoon File 9", -- ➈
            icon = {
                icon = "\u{2788}",
                color = "azure"
            }
        }, -- Control-e (not in leader group, but documented for completeness)
        {
            "<C-e>",
            desc = "\u{f03a} Toggle Harpoon menu", --  (list)
            icon = {
                icon = "\u{f03a}",
                color = "azure"
            }
        },
        -- ==========================================================================
        -- COMMENT.NVIM KEYMAPS
        -- ==========================================================================
        -- Linewise comment operations (Normal mode)
        {
            mode = "n",
            {
                "gc",
                desc = "\u{f075} Comment (motion)", --  (comment)
                icon = {
                    icon = "\u{f075}",
                    color = "green"
                }
            },
            {
                "gcc",
                desc = "\u{f075} Toggle line comment", --  (comment)
                icon = {
                    icon = "\u{f075}",
                    color = "green"
                }
            },
            {
                "gco",
                desc = "\u{f078} Comment below + INSERT", --  (chevron down)
                icon = {
                    icon = "\u{f078}",
                    color = "green"
                }
            },
            {
                "gcO",
                desc = "\u{f077} Comment above + INSERT", --  (chevron up)
                icon = {
                    icon = "\u{f077}",
                    color = "green"
                }
            },
            {
                "gcA",
                desc = "\u{f061} Comment EOL + INSERT", --  (arrow right)
                icon = {
                    icon = "\u{f061}",
                    color = "green"
                }
            }
        }, -- Blockwise comment operations (Normal mode)
        {
            mode = "n",
            {
                "gb",
                desc = "\u{f10b} Block comment (motion)", --  (square with corners)
                icon = {
                    icon = "\u{f10b}",
                    color = "cyan"
                }
            },
            {
                "gbc",
                desc = "\u{f10b} Toggle block comment", --  (square with corners)
                icon = {
                    icon = "\u{f10b}",
                    color = "cyan"
                }
            }
        }, -- Visual mode comment operations
        {
            mode = "x",
            {
                "gc",
                desc = "\u{f075} Comment selection (linewise)", --  (comment)
                icon = {
                    icon = "\u{f075}",
                    color = "green"
                }
            },
            {
                "gb",
                desc = "\u{f10b} Comment selection (blockwise)", --  (square)
                icon = {
                    icon = "\u{f10b}",
                    color = "cyan"
                }
            }
        },
        -- ==========================================================================
        -- NVIM-SURROUND KEYMAPS
        -- ==========================================================================
        -- Add operations (Normal mode)
        {
            mode = "n",
            {
                "ys",
                desc = "\u{f104}\u{f105} Add surround (motion)", --  (angle brackets)
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            },
            {
                "yss",
                desc = "\u{f104}\u{f105} Add surround (line)", --  (angle brackets)
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            },
            {
                "yS",
                desc = "\u{f104}\u{23ce}\u{f105} Add surround (motion, new lines)", --  ⏎ 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            },
            {
                "ySS",
                desc = "\u{f104}\u{23ce}\u{f105} Add surround (line, new lines)", --  ⏎ 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            }
        }, -- Delete operation
        {
            mode = "n",
            {
                "ds",
                desc = "\u{f00d} Delete surround", --  (times/delete)
                icon = {
                    icon = "\u{f00d}",
                    color = "red"
                }
            }
        }, -- Change operations
        {
            mode = "n",
            {
                "cs",
                desc = "\u{f021} Change surround", --  (refresh/replace)
                icon = {
                    icon = "\u{f021}",
                    color = "yellow"
                }
            },
            {
                "cS",
                desc = "\u{f021}\u{23ce} Change surround (new lines)", --  ⏎
                icon = {
                    icon = "\u{f021}",
                    color = "yellow"
                }
            }
        }, -- Visual mode operations
        {
            mode = "x",
            {
                "S",
                desc = "\u{f104}\u{f105} Surround selection", -- 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            },
            {
                "gS",
                desc = "\u{f104}\u{23ce}\u{f105} Surround selection (new lines)", --  ⏎ 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            }
        }, -- Insert mode operations
        {
            mode = "i",
            {
                "<C-g>s",
                desc = "\u{f104}\u{f105} Surround at cursor", -- 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            },
            {
                "<C-g>S",
                desc = "\u{f104}\u{23ce}\u{f105} Surround at cursor (new lines)", --  ⏎ 
                icon = {
                    icon = "\u{f104}\u{f105}",
                    color = "cyan"
                }
            }
        }, -- Individual key descriptions
        {
            mode = {"n", "v"},
            {
                "<leader>y",
                desc = "\u{f0c5} Yank to clipboard" --  (copy)
            },
            {
                "<leader>d",
                desc = "\u{f00d} Delete without yank" --  (delete)
            }
        }, -- Quick actions
        {
            "<leader><leader>",
            desc = "\u{f021} Source file" --  (refresh)
        }, {
            "<leader>q",
            desc = "\u{f2d1} Quit" --  (window close)
        }, {
            "<leader>w",
            desc = "\u{f0c7} Save file" --  (save)
        }, {
            "<leader>u",
            desc = "\u{f1da} Toggle undotree" --  (history)
        }, {
            "<leader>-",
            desc = "\u{f07c} Oil float" --  (folder open)
        }, {
            "-",
            desc = "\u{f115} Parent directory" --  (folder open outline)
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
        desc = "\u{f059} Buffer Local Keymaps" --  (question circle)
    }}
}

-- =============================================================================
-- WHICH-KEY NOTES (UPDATED)
-- =============================================================================
-- What's new in this configuration:
--
-- 1. MODERN SPEC FORMAT:
--    - Uses new table-based spec instead of old register() function
--    - More intuitive and easier to read
--    - Better integration with lazy.nvim
--
-- 2. ICONS:
--    - Custom icons for each key group
--    - Color-coded for visual distinction
--    - Requires a Nerd Font to display properly
--
-- 3. PRESETS:
--    - Built-in help for common Vim operators
--    - Help for text objects (i/a)
--    - Window management hints (<C-w>)
--    - Fold and spelling hints (z, g)
--
-- 4. MODERN LAYOUT:
--    - Cleaner, more spacious design
--    - Rounded borders
--    - Better readability
--
-- Usage:
-- - Press <leader> and wait - which-key shows options
-- - Type any partial key sequence to see completions
-- - Press <leader>? to see buffer-local keymaps
--
-- Available icons/colors:
-- - Colors: azure, blue, cyan, green, grey, orange, purple, red, yellow
-- - Icons: Any Nerd Font icon or emoji
--
-- To add your own groups:
-- Just add to the spec table:
-- {
--   "<leader>x",
--   group = "My Group",
--   icon = { icon = "⚡", color = "red" },
-- },
-- =============================================================================
