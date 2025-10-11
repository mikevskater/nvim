-- ~\AppData\Local\nvim\lua\myconfig\plugins\lsp.lua
-- =============================================================================
-- LSP - Language Server Protocol
-- =============================================================================
-- Why LSP? Provides IDE features: code completion, go-to-definition, 
-- diagnostics, etc. Mason manages LSP server installation.
-- =============================================================================

-- lua/myconfig/plugins/lsp.lua
return {
  -- Mason: Package manager for LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  
  -- Mason-LSPConfig: Bridges mason.nvim and native LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "pyright",
        },
        automatic_installation = true,
      })
    end,
  },
  
  -- nvim-lspconfig: Provides LSP configs (now just data)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",  -- Changed: Use blink.cmp instead of cmp-nvim-lsp
    },
    config = function()
      -- ==========================================================================
      -- LSP CAPABILITIES (for blink.cmp)
      -- ==========================================================================
      -- blink.cmp provides its own capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      -- If blink.cmp is loaded, get its capabilities
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = vim.tbl_deep_extend(
          'force',
          capabilities,
          blink.get_lsp_capabilities and blink.get_lsp_capabilities() or {}
        )
      end
      
      -- ==========================================================================
      -- LSP KEYBINDINGS
      -- ==========================================================================
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local keymap = vim.keymap.set
          
          -- Navigation
          keymap("n", "gd", vim.lsp.buf.definition, 
            vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          keymap("n", "gD", vim.lsp.buf.declaration, 
            vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          keymap("n", "gi", vim.lsp.buf.implementation, 
            vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          keymap("n", "gr", vim.lsp.buf.references, 
            vim.tbl_extend("force", opts, { desc = "Show references" }))
          
          -- Information
          keymap("n", "K", vim.lsp.buf.hover, 
            vim.tbl_extend("force", opts, { desc = "Show hover information" }))
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, 
            vim.tbl_extend("force", opts, { desc = "Show signature help" }))
          
          -- Diagnostics
          keymap("n", "[d", vim.diagnostic.goto_prev, 
            vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
          keymap("n", "]d", vim.diagnostic.goto_next, 
            vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
          keymap("n", "<leader>e", vim.diagnostic.open_float, 
            vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
          keymap("n", "<leader>dl", vim.diagnostic.setloclist, 
            vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))
          
          -- Actions
          keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, 
            vim.tbl_extend("force", opts, { desc = "Code action" }))
          keymap("n", "<leader>rn", vim.lsp.buf.rename, 
            vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          keymap("n", "<leader>fm", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        end,
      })
      
      -- ==========================================================================
      -- CONFIGURE LANGUAGE SERVERS (New API)
      -- ==========================================================================
      
      -- Global capabilities for all servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })
      
      -- Lua (with Neovim-specific settings)
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
      
      -- Enable all language servers
      -- nvim-lspconfig provides the base configs automatically
      vim.lsp.enable({
        'lua_ls',
        'ts_ls',
        'pyright',
        'html',
        'cssls',
        'jsonls',
      })
    end,
  },
}

-- =============================================================================
-- LSP NOTES
-- =============================================================================
-- Mason UI: :Mason
-- Install LSP: :MasonInstall <server-name>
-- LSP Info: :LspInfo
-- LSP Log: :LspLog
--
-- Common LSP keybindings (defined above):
-- gd       - Go to definition
-- gr       - Show references
-- K        - Hover documentation
-- <leader>ca - Code actions
-- <leader>rn - Rename
-- <leader>fm - Format
-- [d / ]d  - Navigate diagnostics
--
-- Troubleshooting:
-- 1. Check if LSP is running: :LspInfo
-- 2. Check logs: :LspLog
-- 3. Restart LSP: :LspRestart
-- 4. Make sure language server is installed: :Mason
-- =============================================================================
