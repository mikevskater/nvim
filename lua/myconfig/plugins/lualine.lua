-- ~\AppData\Local\nvim\lua\myconfig\plugins\lualine.lua
-- =============================================================================
-- LUALINE - Statusline (NEW)
-- =============================================================================
-- Shows mode, git, file info, LSP status, diagnostics in statusline
-- =============================================================================
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},

    config = function()
        require("lualine").setup({
            -- ==========================================================================
            -- OPTIONS
            -- ==========================================================================
            options = {
                -- Theme (auto-detects from colorscheme)
                theme = "auto", -- or specify: "rose-pine", "gruvbox", etc.

                -- Separators between components
                component_separators = {
                    left = "|",
                    right = "|"
                },
                section_separators = {
                    left = "",
                    right = ""
                },

                -- Disable for these filetypes
                disabled_filetypes = {
                    statusline = {},
                    winbar = {}
                },

                -- Always show statusline
                globalstatus = true,

                -- Refresh interval (ms)
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000
                }
            },

            -- ==========================================================================
            -- SECTIONS
            -- ==========================================================================
            sections = {
                -- Left side
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", {
                    "diagnostics",
                    sources = {"nvim_diagnostic"},
                    symbols = {
                        error = " ",
                        warn = " ",
                        info = " ",
                        hint = " "
                    }
                }},
                lualine_c = {{
                    "filename",
                    file_status = true, -- Shows modified status
                    path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                    shorting_target = 40, -- Shorten if too long
                    symbols = {
                        modified = "[+]",
                        readonly = "[-]",
                        unnamed = "[No Name]"
                    }
                }},

                -- Right side
                lualine_x = {{
                    -- Show active LSP servers
                    function()
                        local clients = vim.lsp.get_clients({
                            bufnr = 0
                        })
                        if next(clients) == nil then
                            return ""
                        end

                        local names = {}
                        for _, client in pairs(clients) do
                            table.insert(names, client.name)
                        end
                        return " " .. table.concat(names, ", ")
                    end,
                    icon = ""
                }, "encoding", {
                    "fileformat",
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR"
                    }
                }, "filetype"},
                lualine_y = {"progress"},
                lualine_z = {"location"}
            },

            -- ==========================================================================
            -- INACTIVE SECTIONS (for inactive windows)
            -- ==========================================================================
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {"filename"},
                lualine_x = {"location"},
                lualine_y = {},
                lualine_z = {}
            },

            -- ==========================================================================
            -- TABLINE (optional - shows buffers/tabs at top)
            -- ==========================================================================
            -- Uncomment to enable tabline
            -- tabline = {
            --   lualine_a = { "buffers" },
            --   lualine_b = {},
            --   lualine_c = {},
            --   lualine_x = {},
            --   lualine_y = {},
            --   lualine_z = { "tabs" },
            -- },

            -- ==========================================================================
            -- EXTENSIONS
            -- ==========================================================================
            extensions = {"fugitive", -- Git integration
            "quickfix", -- Quickfix list
            "oil" -- Oil file explorer
            }
        })
    end
}

-- =============================================================================
-- LUALINE NOTES
-- =============================================================================
-- What it shows:
--
-- LEFT SIDE:
-- - Mode (NORMAL, INSERT, VISUAL, etc.)
-- - Git branch
-- - Git diff (added/modified/removed lines)
-- - Diagnostics (errors, warnings, info, hints)
-- - Filename (with path and status)
--
-- RIGHT SIDE:
-- - Active LSP servers
-- - File encoding (utf-8, etc.)
-- - File format (LF/CRLF)
-- - Filetype
-- - Cursor position (%)
-- - Line:Column
--
-- Customization tips:
-- 1. Change theme: theme = "rose-pine"
-- 2. Hide components: Just remove from sections
-- 3. Add components: Insert into lualine_x, etc.
-- 4. Change separators: component_separators, section_separators
--
-- Available components:
-- - branch, buffers, diagnostics, diff, encoding, fileformat,
--   filename, filetype, hostname, location, mode, progress, tabs
--
-- To disable mode in command line (since lualine shows it):
-- Set in options.lua: opt.showmode = false
--
-- Performance:
-- - Very lightweight (~0.5ms overhead)
-- - Updates every 1 second by default
-- - Automatically adapts to colorscheme
-- =============================================================================
