-- lua/myconfig/plugins/dap.lua
return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for debugging
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
      
      -- Virtual text support (show variable values inline)
      "theHamsta/nvim-dap-virtual-text",
      
      -- Mason integration for debugger installation
      "jay-babu/mason-nvim-dap.nvim",
      
      -- Language-specific extensions (add as needed)
      "leoluz/nvim-dap-go",               -- Go
      -- "jbyuki/one-small-step-for-vimkind", -- Lua/Neovim
    },
    
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_vt = require("nvim-dap-virtual-text")
      
      -- ========================================================================
      -- SETUP DAP UI
      -- ========================================================================
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
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
        all_references = false,
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
        text = "●",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = ""
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "◆",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = ""
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "○",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = ""
      })
      vim.fn.sign_define("DapStopped", {
        text = "→",
        texthl = "DapStopped",
        linehl = "debugPC",
        numhl = ""
      })
      vim.fn.sign_define("DapLogPoint", {
        text = "◆",
        texthl = "DapLogPoint",
        linehl = "",
        numhl = ""
      })
      
      -- ========================================================================
      -- KEYBINDINGS
      -- ========================================================================
      local keymap = vim.keymap.set
      
      -- Start/Continue
      keymap("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      keymap("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
      
      -- Step controls
      keymap("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      keymap("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      keymap("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      keymap("n", "<leader>dso", dap.step_over, { desc = "Debug: Step Over" })
      keymap("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
      keymap("n", "<leader>dsO", dap.step_out, { desc = "Debug: Step Out" })
      
      -- Breakpoints
      keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      keymap("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Conditional Breakpoint" })
      keymap("n", "<leader>dL", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Debug: Log Point" })
      
      -- UI controls
      keymap("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
      keymap("n", "<leader>de", dapui.eval, { desc = "Debug: Eval" })
      keymap("v", "<leader>de", dapui.eval, { desc = "Debug: Eval Selection" })
      
      -- Session controls
      keymap("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      keymap("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
      keymap("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
      
      -- ========================================================================
      -- LANGUAGE-SPECIFIC SETUP
      -- ========================================================================
      
      -- Python (using nvim-dap-python)
      require("dap-python").setup("python")  -- or path to debugpy
      
      -- Go (using nvim-dap-go)
      require("dap-go").setup()
      
      -- Add configurations for other languages as needed
      -- See: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    end,
  },
  
  -- Mason integration for auto-installing debuggers
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        -- Automatically install these debuggers
        ensure_installed = {
          "python",     -- debugpy
          "delve",      -- Go
          "js",         -- JavaScript/TypeScript
          -- Add more as needed
        },
        
        -- Auto-configure installed debuggers
        automatic_installation = true,
        
        -- Handlers for specific debuggers
        handlers = {},
      })
    end,
  },
}