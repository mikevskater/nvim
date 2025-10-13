-- ~\AppData\Local\nvim\lua\myconfig\plugins\lsp.lua
-- =============================================================================
-- LSP - Language Server Protocol
-- =============================================================================
-- Why LSP? Provides IDE features: code completion, go-to-definition, 
-- diagnostics, etc. Mason manages LSP server installation.
-- =============================================================================
return { -- Mason: Package manager for LSP servers
{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "\u{2713}", -- ✓
                    package_pending = "\u{f252}", --  (spinner)
                    package_uninstalled = "\u{2715}" -- ✕
                }
            }
        })
    end
}, -- Mason-LSPConfig: Bridges mason.nvim and native LSP
{
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim"},
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {"lua_ls", "ts_ls", "html", "cssls", "jsonls",
                                "pyright"},
            automatic_installation = true
        })
    end
}, -- nvim-lspconfig: Provides LSP configs (now just data)
{
    "neovim/nvim-lspconfig",
    dependencies = {"williamboman/mason-lspconfig.nvim", "saghen/blink.cmp"},
    config = function()
        -- ==========================================================================
        -- LSP CAPABILITIES (for blink.cmp)
        -- ==========================================================================
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- If blink.cmp is loaded, get its capabilities
        local ok, blink = pcall(require, "blink.cmp")
        if ok then
            capabilities = vim.tbl_deep_extend('force', capabilities,
                blink.get_lsp_capabilities and blink.get_lsp_capabilities() or
                    {})
        end

        -- ==========================================================================
        -- DIAGNOSTIC SIGNS WITH ICONS
        -- ==========================================================================
        local signs = {
            Error = "\u{f658}", --  (times-circle)
            Warn = "\u{f071}", --  (warning triangle)
            Hint = "\u{f0eb}", --  (lightbulb)
            Info = "\u{f05a}" --  (info circle)
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
                text = icon,
                texthl = hl,
                numhl = hl
            })
        end

        -- ==========================================================================
        -- DIAGNOSTIC CONFIGURATION
        -- ==========================================================================
        vim.diagnostic.config({
            virtual_text = {
                prefix = "\u{25cf}" -- ● (filled circle)
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = ""
            }
        })

        -- ==========================================================================
        -- LSP KEYBINDINGS
        -- ==========================================================================
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = {
                    buffer = ev.buf,
                    silent = true
                }
                local keymap = vim.keymap.set

                -- ======================================================================
                -- NAVIGATION (Go-to)
                -- ======================================================================
                keymap("n", "gd", vim.lsp.buf.definition,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f1e5} Go to definition" --  (location arrow)
                    }))
                keymap("n", "gD", vim.lsp.buf.declaration,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f1e5} Go to declaration"
                    }))
                keymap("n", "gri", vim.lsp.buf.implementation,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f121} Go to implementation" --  (code)
                    }))
                keymap("n", "grr", vim.lsp.buf.references,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f126} Show references" --  (branch)
                    }))
                keymap("n", "grt", vim.lsp.buf.type_definition,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f1bb} Go to type definition" --  (tree/type)
                    }))

                -- ======================================================================
                -- INFORMATION & DOCUMENTATION
                -- ======================================================================
                keymap("n", "K", vim.lsp.buf.hover,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f059} Show hover documentation" --  (question circle)
                    }))
                keymap("n", "<C-k>", vim.lsp.buf.signature_help,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f059} Signature help"
                    }))
                -- Insert mode signature help (Neovim 0.11+ default)
                keymap("i", "<C-s>", vim.lsp.buf.signature_help,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f059} Signature help (insert mode)"
                    }))

                -- ======================================================================
                -- SYMBOLS
                -- ======================================================================
                -- Document symbols (local to current file)
                keymap("n", "gO", vim.lsp.buf.document_symbol,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f0cb} Document symbols" --  (list)
                    }))

                -- Workspace symbols (project-wide)
                keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f002} Workspace symbols" --  (search)
                    }))

                -- ======================================================================
                -- DIAGNOSTICS NAVIGATION
                -- ======================================================================
                -- Next/Previous diagnostic
                keymap("n", "[d", vim.diagnostic.goto_prev,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f062} Previous diagnostic" --  (arrow up)
                    }))
                keymap("n", "]d", vim.diagnostic.goto_next,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f063} Next diagnostic" --  (arrow down)
                    }))

                -- First/Last diagnostic (Neovim 0.11+ default)
                keymap("n", "[D", function()
                    vim.diagnostic.goto_prev({
                        count = math.huge
                    })
                end, vim.tbl_extend("force", opts, {
                    desc = "\u{f062} First diagnostic"
                }))
                keymap("n", "]D", function()
                    vim.diagnostic.goto_next({
                        count = math.huge
                    })
                end, vim.tbl_extend("force", opts, {
                    desc = "\u{f063} Last diagnostic"
                }))

                -- Show diagnostic in floating window
                keymap("n", "<leader>e", vim.diagnostic.open_float,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f05a} Show diagnostic" --  (info)
                    }))

                -- Alternative: <C-w>d (Neovim 0.10+ default)
                keymap("n", "<C-w>d", vim.diagnostic.open_float,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f05a} Show diagnostic (window)"
                    }))
                keymap("n", "<C-w><C-d>", vim.diagnostic.open_float,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f05a} Show diagnostic (window)"
                    }))

                -- Diagnostics list
                keymap("n", "<leader>dl", vim.diagnostic.setloclist,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f03a} Diagnostic loclist" --  (list)
                    }))
                keymap("n", "<leader>dq", vim.diagnostic.setqflist,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f03a} Diagnostic quickfix" --  (list)
                    }))

                -- ======================================================================
                -- CODE ACTIONS & REFACTORING
                -- ======================================================================
                keymap({"n", "v"}, "gra", vim.lsp.buf.code_action,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f0eb} Code action" --  (lightbulb)
                    }))
                keymap("n", "grn", vim.lsp.buf.rename,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f040} Rename symbol" --  (pencil)
                    }))

                -- ======================================================================
                -- FORMATTING
                -- ======================================================================
                -- Format buffer
                keymap("n", "<leader>fm", function()
                    vim.lsp.buf.format({
                        async = true
                    })
                end, vim.tbl_extend("force", opts, {
                    desc = "\u{f0c9} Format buffer" --  (align justify)
                }))

                -- Format selection (visual mode)
                keymap("v", "<leader>fm", function()
                    vim.lsp.buf.format({
                        async = true
                    })
                end, vim.tbl_extend("force", opts, {
                    desc = "\u{f0c9} Format selection"
                }))

                -- ======================================================================
                -- WORKSPACE MANAGEMENT
                -- ======================================================================
                keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f067} Add workspace folder" --  (plus)
                    }))
                keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f068} Remove workspace folder" --  (minus)
                    }))
                keymap("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, vim.tbl_extend("force", opts, {
                    desc = "\u{f03a} List workspace folders" --  (list)
                }))

                -- ======================================================================
                -- CALL HIERARCHY (if supported by server)
                -- ======================================================================
                keymap("n", "<leader>ic", vim.lsp.buf.incoming_calls,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f01e} Incoming calls" --  (arrows)
                    }))
                keymap("n", "<leader>oc", vim.lsp.buf.outgoing_calls,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f01e} Outgoing calls"
                    }))

                -- ======================================================================
                -- CODE LENS (if supported by server)
                -- ======================================================================
                keymap("n", "<leader>cl", vim.lsp.codelens.run,
                    vim.tbl_extend("force", opts, {
                        desc = "\u{f135} Run code lens" --  (rocket)
                    }))
            end
        })

        -- ==========================================================================
        -- CONFIGURE LANGUAGE SERVERS (New API)
        -- ==========================================================================

        -- Global capabilities for all servers
        vim.lsp.config('*', {
            capabilities = capabilities
        })

        -- Lua (with Neovim-specific settings)
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"}
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true
                        }
                    }
                }
            }
        })

        -- Enable all language servers
        vim.lsp
            .enable({'lua_ls', 'ts_ls', 'pyright', 'html', 'cssls', 'jsonls'})
    end
}}

-- =============================================================================
-- LSP NOTES (UPDATED)
-- =============================================================================
-- Mason UI: :Mason
-- Install LSP: :MasonInstall <server-name>
-- LSP Info: :LspInfo
-- LSP Log: :LspLog
--
-- NAVIGATION KEYBINDINGS:
-- gd       - Go to definition
-- gD       - Go to declaration  
-- gri      - Go to implementation (changed from gi)
-- grr      - Show references (changed from gr)
-- grt      - Go to type definition (NEW)
-- gO       - Document symbols (NEW)
--
-- INFORMATION:
-- K        - Hover documentation
-- <C-k>    - Signature help (normal mode)
-- <C-s>    - Signature help (insert mode) (NEW)
--
-- SYMBOLS:
-- gO           - Document symbols (local file)
-- <leader>ws   - Workspace symbols (project-wide) (NEW)
--
-- DIAGNOSTICS:
-- [d / ]d      - Navigate to prev/next diagnostic
-- [D / ]D      - Jump to first/last diagnostic (NEW)
-- <leader>e    - Show diagnostic float
-- <C-w>d       - Show diagnostic float (window command) (NEW)
-- <leader>dl   - Diagnostic loclist
-- <leader>dq   - Diagnostic quickfix (NEW)
--
-- CODE ACTIONS:
-- gra          - Code actions (changed from <leader>ca)
-- grn          - Rename (changed from <leader>rn)
-- <leader>fm   - Format buffer/selection
--
-- WORKSPACE:
-- <leader>wa   - Add workspace folder (NEW)
-- <leader>wr   - Remove workspace folder (NEW)
-- <leader>wl   - List workspace folders (NEW)
--
-- CALL HIERARCHY (if supported):
-- <leader>ic   - Incoming calls (NEW)
-- <leader>oc   - Outgoing calls (NEW)
--
-- CODE LENS (if supported):
-- <leader>cl   - Run code lens (NEW)
--
-- COMPATIBILITY NOTES:
-- - Updated to match Neovim 0.11+ default keybindings
-- - Uses 'gr' prefix for LSP operations (grr, gra, grn, gri, grt)
-- - Maintains backward compatibility with <leader> alternatives
-- - All keybindings work with Neovim 0.10+
--
-- Troubleshooting:
-- 1. Check if LSP is running: :LspInfo
-- 2. Check logs: :LspLog
-- 3. Restart LSP: :LspRestart
-- 4. Make sure language server is installed: :Mason
-- =============================================================================
