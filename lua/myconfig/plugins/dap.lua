-- ~\AppData\Local\nvim\lua\myconfig\plugins\dap.lua
-- =============================================================================
-- DAP - Debug Adapter Protocol
-- =============================================================================
return {{
    "mfussenegger/nvim-dap",
    lazy = true, -- Only load when needed
    dependencies = { -- UI for debugging
    "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    -- Virtual text support (show variable values inline)
    "theHamsta/nvim-dap-virtual-text",

    -- Mason integration for debugger installation
    "jay-babu/mason-nvim-dap.nvim"},

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_vt = require("nvim-dap-virtual-text")

        -- ========================================================================
        -- SETUP DAP UI
        -- ========================================================================
        dapui.setup({
            layouts = {{
                elements = {{
                    id = "scopes",
                    size = 0.25
                }, {
                    id = "breakpoints",
                    size = 0.25
                }, {
                    id = "stacks",
                    size = 0.25
                }, {
                    id = "watches",
                    size = 0.25
                }},
                size = 40,
                position = "left"
            }, {
                elements = {{
                    id = "repl",
                    size = 0.5
                }, {
                    id = "console",
                    size = 0.5
                }},
                size = 10,
                position = "bottom"
            }},
            floating = {
                border = "rounded",
                mappings = {
                    close = {"q", "<Esc>"}
                },
                -- TRANSPARENCY SETTINGS
                win_options = {
                    winblend = 0
                }
            }
        })

        -- ========================================================================
        -- SETUP VIRTUAL TEXT
        -- ========================================================================
        dap_vt.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false
        })

        -- ========================================================================
        -- AUTO OPEN/CLOSE DAP UI
        -- ========================================================================
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- ========================================================================
        -- SIGNS (BREAKPOINT ICONS)
        -- ========================================================================
        vim.fn.sign_define("DapBreakpoint", {
            text = "\u{f111}", --  (filled circle)
            texthl = "DapBreakpoint",
            linehl = "",
            numhl = ""
        })
        vim.fn.sign_define("DapBreakpointCondition", {
            text = "\u{f059}", --  (question circle)
            texthl = "DapBreakpoint",
            linehl = "",
            numhl = ""
        })
        vim.fn.sign_define("DapBreakpointRejected", {
            text = "\u{f057}", --  (times circle)
            texthl = "DapBreakpoint",
            linehl = "",
            numhl = ""
        })
        vim.fn.sign_define("DapStopped", {
            text = "\u{f0da}", --  (caret right)
            texthl = "DapStopped",
            linehl = "debugPC",
            numhl = ""
        })
        vim.fn.sign_define("DapLogPoint", {
            text = "\u{f05a}", --  (info circle)
            texthl = "DapLogPoint",
            linehl = "",
            numhl = ""
        })

        -- ==========================================================================
        -- KEYBINDINGS WITH ICONS
        -- ==========================================================================
        local keymap = vim.keymap.set

        -- ==========================================================================
        -- FUNCTION KEYS (F5-F12) - Industry Standard
        -- ==========================================================================
        -- F5: Start/Continue (VS Code, Visual Studio, IntelliJ standard)
        keymap("n", "<F5>", dap.continue, {
            desc = "\u{f04b} Debug: Start/Continue" --  (play)
        })

        -- F9: Toggle Breakpoint (VS Code, Visual Studio, IntelliJ standard)
        keymap("n", "<F9>", dap.toggle_breakpoint, {
            desc = "\u{f111} Debug: Toggle Breakpoint" --  (circle)
        })

        -- F10: Step Over
        keymap("n", "<F10>", dap.step_over, {
            desc = "\u{f063} Debug: Step Over" --  (arrow down)
        })

        -- F11: Step Into
        keymap("n", "<F11>", dap.step_into, {
            desc = "\u{f062} Debug: Step Into" --  (arrow down into)
        })

        -- F12: Step Out
        keymap("n", "<F12>", dap.step_out, {
            desc = "\u{f062} Debug: Step Out" --  (arrow up)
        })

        -- F6: Pause
        keymap("n", "<F6>", dap.pause, {
            desc = "\u{f04c} Debug: Pause" --  (pause)
        })

        -- ==========================================================================
        -- ARROW KEYS - Alternative Step Navigation (Common in IDEs)
        -- ==========================================================================
        keymap("n", "<Down>", dap.step_over, {
            desc = "\u{f063} Debug: Step Over"
        })
        keymap("n", "<Right>", dap.step_into, {
            desc = "\u{f061} Debug: Step Into"
        })
        keymap("n", "<Left>", dap.step_out, {
            desc = "\u{f060} Debug: Step Out"
        })
        keymap("n", "<Up>", dap.run_to_cursor, {
            desc = "\u{f062} Debug: Run to Cursor"
        })

        -- ==========================================================================
        -- SESSION CONTROL - <leader>d prefix
        -- ==========================================================================
        -- Continue/Start
        keymap("n", "<leader>dc", dap.continue, {
            desc = "\u{f04b} Continue" --  (play)
        })

        -- Run to cursor (no breakpoint needed)
        keymap("n", "<leader>dC", dap.run_to_cursor, {
            desc = "\u{f0a4} Run to Cursor" --  (arrow to cursor)
        })

        -- Restart session
        keymap("n", "<leader>dR", dap.restart, {
            desc = "\u{f01e} Restart Session" --  (refresh)
        })

        -- Pause execution
        keymap("n", "<leader>dp", dap.pause, {
            desc = "\u{f04c} Pause" --  (pause)
        })

        -- Terminate session
        keymap("n", "<leader>dt", dap.terminate, {
            desc = "\u{f04d} Terminate" --  (stop)
        })

        -- ==========================================================================
        -- STEP CONTROLS - <leader>ds prefix
        -- ==========================================================================
        keymap("n", "<leader>dso", dap.step_over, {
            desc = "\u{f063} Step Over"
        })
        keymap("n", "<leader>dsi", dap.step_into, {
            desc = "\u{f062} Step Into"
        })
        keymap("n", "<leader>dsO", dap.step_out, {
            desc = "\u{f062} Step Out"
        })
        keymap("n", "<leader>dsb", dap.step_back, {
            desc = "\u{f04a} Step Back (Reverse)" --  (backward)
        })

        -- ==========================================================================
        -- BREAKPOINTS - <leader>db prefix
        -- ==========================================================================
        -- Toggle breakpoint
        keymap("n", "<leader>db", dap.toggle_breakpoint, {
            desc = "\u{f111} Toggle Breakpoint" --  (circle)
        })

        -- Conditional breakpoint
        keymap("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, {
            desc = "\u{f059} Conditional Breakpoint" --  (question)
        })

        -- Log point
        keymap("n", "<leader>dL", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end, {
            desc = "\u{f05a} Log Point" --  (info)
        })

        -- Clear all breakpoints
        keymap("n", "<leader>dbc", dap.clear_breakpoints, {
            desc = "\u{f00d} Clear All Breakpoints" --  (times)
        })

        -- List breakpoints
        keymap("n", "<leader>dbl", function()
            require("telescope.builtin").lsp_document_symbols()
        end, {
            desc = "\u{f03a} List Breakpoints" --  (list)
        })

        -- ==========================================================================
        -- UI CONTROLS - <leader>du prefix
        -- ==========================================================================
        -- Toggle UI
        keymap("n", "<leader>du", dapui.toggle, {
            desc = "\u{f2d0} Toggle UI" --  (window)
        })

        -- Open floating element
        keymap("n", "<leader>df", function()
            dapui.float_element()
        end, {
            desc = "\u{f2d2} Float Element" --  (window restore)
        })

        -- Open specific floating windows
        keymap("n", "<leader>ds", function()
            dapui.float_element("scopes")
        end, {
            desc = "\u{f0ce} Scopes (Float)" --  (table)
        })

        keymap("n", "<leader>dw", function()
            dapui.float_element("watches")
        end, {
            desc = "\u{f06e} Watches (Float)" --  (eye)
        })

        keymap("n", "<leader>dk", function()
            dapui.float_element("stacks")
        end, {
            desc = "\u{f0c9} Stack Trace (Float)" --  (bars)
        })

        -- ==========================================================================
        -- EVALUATION & INSPECTION - <leader>de prefix
        -- ==========================================================================
        -- Eval under cursor (normal & visual)
        keymap("n", "<leader>de", dapui.eval, {
            desc = "\u{f06e} Eval Expression" --  (eye)
        })
        keymap("v", "<leader>de", dapui.eval, {
            desc = "\u{f06e} Eval Selection"
        })

        -- Eval with input prompt
        keymap("n", "<leader>dE", function()
            dapui.eval(vim.fn.input("Expression: "))
        end, {
            desc = "\u{f120} Eval (Prompt)" --  (terminal)
        })

        -- Hover (alternative to eval)
        keymap("n", "<leader>dh", function()
            require("dap.ui.widgets").hover()
        end, {
            desc = "\u{f05a} Hover Info" --  (info)
        })

        -- ==========================================================================
        -- REPL & SESSION - <leader>dr prefix
        -- ==========================================================================
        -- Open REPL
        keymap("n", "<leader>dr", dap.repl.open, {
            desc = "\u{f120} Open REPL" --  (terminal)
        })

        -- Run last configuration
        keymap("n", "<leader>dl", dap.run_last, {
            desc = "\u{f04b} Run Last Config" --  (play)
        })

        -- View active sessions
        keymap("n", "<leader>dS", function()
            require("dap").session()
        end, {
            desc = "\u{f1da} View Sessions" --  (history)
        })

        -- ==========================================================================
        -- NAVIGATION - Stack/Frame
        -- ==========================================================================
        -- Go to line (without executing)
        keymap("n", "<leader>dg", function()
            dap.goto_()
        end, {
            desc = "\u{f01e} Goto Line"
        })

        -- Navigate stack frames
        keymap("n", "<leader>dj", dap.down, {
            desc = "\u{f063} Stack Frame Down"
        })
        keymap("n", "<leader>dk", dap.up, {
            desc = "\u{f062} Stack Frame Up"
        })
    end
}, -- Python DAP extension (install as regular plugin, NOT via luarocks)
{
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
        -- Setup Python debugger
        -- This will use the python in your PATH by default
        require("dap-python").setup("python")
    end
}, -- Go DAP extension
{
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
        require("dap-go").setup()
    end
}, -- Mason integration for auto-installing debuggers
{
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    cmd = {"DapInstall", "DapUninstall"},
    opts = {
        -- Automatically install these debuggers
        ensure_installed = {"python", -- debugpy
        "delve" -- Go
        -- "js",      -- JavaScript/TypeScript (uncomment if needed)
        },

        automatic_installation = true,
        handlers = {}
    }
}}
