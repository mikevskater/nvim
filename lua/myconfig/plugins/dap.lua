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

        -- Start/Continue
        keymap("n", "<F5>", dap.continue, {
            desc = "\u{f04b} Debug: Start/Continue" --  (play)
        })
        keymap("n", "<leader>dc", dap.continue, {
            desc = "\u{f04b} Debug: Continue"
        })

        -- Step controls
        keymap("n", "<F10>", dap.step_over, {
            desc = "\u{f063} Debug: Step Over" --  (arrow down)
        })
        keymap("n", "<F11>", dap.step_into, {
            desc = "\u{f062} Debug: Step Into" --  (arrow down into)
        })
        keymap("n", "<F12>", dap.step_out, {
            desc = "\u{f062} Debug: Step Out" --  (arrow up)
        })
        keymap("n", "<leader>dso", dap.step_over, {
            desc = "Debug: Step Over"
        })
        keymap("n", "<leader>dsi", dap.step_into, {
            desc = "Debug: Step Into"
        })
        keymap("n", "<leader>dsO", dap.step_out, {
            desc = "Debug: Step Out"
        })

        -- Breakpoints
        keymap("n", "<leader>db", dap.toggle_breakpoint, {
            desc = "\u{f111} Debug: Toggle Breakpoint" --  (circle)
        })
        keymap("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, {
            desc = "\u{f059} Debug: Conditional Breakpoint" --  (question)
        })
        keymap("n", "<leader>dL", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end, {
            desc = "Debug: Log Point"
        })

        -- UI controls
        keymap("n", "<leader>du", dapui.toggle, {
            desc = "\u{f2d0} Debug: Toggle UI" --  (window)
        })
        keymap("n", "<leader>de", dapui.eval, {
            desc = "\u{f06e} Debug: Eval" --  (eye)
        })
        keymap("v", "<leader>de", dapui.eval, {
            desc = "Debug: Eval Selection"
        })

        -- Session controls
        keymap("n", "<leader>dr", dap.repl.open, {
            desc = "Debug: Open REPL"
        })
        keymap("n", "<leader>dl", dap.run_last, {
            desc = "Debug: Run Last"
        })
        keymap("n", "<leader>dt", dap.terminate, {
            desc = "\u{f04d} Debug: Terminate" --  (stop)
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
