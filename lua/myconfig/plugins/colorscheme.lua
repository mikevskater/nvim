-- ~\AppData\Local\nvim\lua\myconfig\plugins\colorscheme.lua
-- =============================================================================
-- COLORSCHEME - Rose Pine Theme
-- =============================================================================
-- Why Rose Pine? Clean, easy on the eyes, has dark/light variants
-- ThePrimeagen uses this one
-- Alternatives: tokyonight, catppuccin, gruvbox, onedark
-- =============================================================================
return {
    "rose-pine/neovim",
    name = "rose-pine",

    -- Load this plugin immediately (before other plugins)
    -- Colorschemes should load first to avoid flashing
    priority = 1000,

    -- Configuration function runs when plugin is loaded
    config = function()
        require("rose-pine").setup({
            -- Variant: "main" (default), "moon", "dawn" (light mode)
            variant = "main",

            -- Disable italics if you don't like them
            disable_italics = false,

            -- Make background transparent (shows terminal background)
            -- Uncomment if you want transparency
            -- disable_background = true,

            -- Custom colors and highlights
            highlight_groups = {
                -- =================================================================
                -- BASE TRANSPARENCY
                -- =================================================================
                Normal = {
                    bg = "none"
                },
                NormalFloat = {
                    bg = "none"
                },
                NormalNC = {
                    bg = "none"
                },
                WinSeparator = {
                    bg = "none"
                },
                WinBar = {
                    bg = "none"
                },
                FloatBorder = {
                    bg = "none"
                },

                -- =================================================================
                -- BLINK.CMP TRANSPARENCY
                -- =================================================================
                BlinkCmpMenu = {
                    bg = "none"
                },
                BlinkCmpMenuBorder = {
                    bg = "none"
                },
                BlinkCmpMenuSelection = {
                    bg = "none"
                },
                BlinkCmpDoc = {
                    bg = "none"
                },
                BlinkCmpDocBorder = {
                    bg = "none"
                },
                BlinkCmpSignatureHelp = {
                    bg = "none"
                },
                BlinkCmpSignatureHelpBorder = {
                    bg = "none"
                },

                -- =================================================================
                -- WHICH-KEY TRANSPARENCY
                -- =================================================================
                WhichKeyFloat = {
                    bg = "none"
                },
                WhichKeyBorder = {
                    bg = "none"
                },

                -- =================================================================
                -- TELESCOPE TRANSPARENCY
                -- =================================================================
                TelescopeNormal = {
                    bg = "none"
                },
                TelescopeBorder = {
                    bg = "none"
                },
                TelescopePromptNormal = {
                    bg = "none"
                },
                TelescopePromptBorder = {
                    bg = "none"
                },
                TelescopeResultsNormal = {
                    bg = "none"
                },
                TelescopeResultsBorder = {
                    bg = "none"
                },
                TelescopePreviewNormal = {
                    bg = "none"
                },
                TelescopePreviewBorder = {
                    bg = "none"
                },
                TelescopeTitle = {
                    bg = "none"
                },
                TelescopePromptTitle = {
                    bg = "none"
                },
                TelescopePreviewTitle = {
                    bg = "none"
                },
                TelescopeResultsTitle = {
                    bg = "none"
                },

                -- =================================================================
                -- LSP & DIAGNOSTIC TRANSPARENCY
                -- =================================================================
                LspInfoBorder = {
                    bg = "none"
                },
                DiagnosticFloatingError = {
                    bg = "none"
                },
                DiagnosticFloatingWarn = {
                    bg = "none"
                },
                DiagnosticFloatingInfo = {
                    bg = "none"
                },
                DiagnosticFloatingHint = {
                    bg = "none"
                },

                -- =================================================================
                -- MASON & LAZY TRANSPARENCY
                -- =================================================================
                MasonNormal = {
                    bg = "none"
                },
                MasonBorder = {
                    bg = "none"
                },
                LazyNormal = {
                    bg = "none"
                },
                LazyBorder = {
                    bg = "none"
                },

                -- =================================================================
                -- OIL.NVIM TRANSPARENCY
                -- =================================================================
                OilNormal = {
                    bg = "none"
                },
                OilBorder = {
                    bg = "none"
                },

                -- =================================================================
                -- NVIM-DAP TRANSPARENCY
                -- =================================================================
                DapUIFloatBorder = {
                    bg = "none"
                },
                DapUINormal = {
                    bg = "none"
                },

                -- =================================================================
                -- NOTIFICATIONS TRANSPARENCY
                -- =================================================================
                NotifyBackground = {
                    bg = "none"
                },

                -- =================================================================
                -- ADDITIONAL COMMON FLOATS
                -- =================================================================
                Pmenu = {
                    bg = "none"
                }, -- Built-in completion menu
                PmenuBorder = {
                    bg = "none"
                },
                FloatTitle = {
                    bg = "none"
                }
            }
        })

        -- Apply the colorscheme
        vim.cmd("colorscheme rose-pine")

        -- =================================================================
        -- ADDITIONAL MANUAL OVERRIDES (for stubborn plugins)
        -- =================================================================
        -- Some plugins set their highlights after colorscheme loads
        -- This autocmd ensures our transparency is applied after that
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                -- Force transparency for all float-related groups
                local transparent_groups =
                    {"NormalFloat", "FloatBorder", "WhichKeyFloat",
                     "WhichKeyBorder", "BlinkCmpMenu", "BlinkCmpMenuBorder",
                     "BlinkCmpDoc", "BlinkCmpDocBorder", "TelescopeNormal",
                     "TelescopeBorder", "TelescopePromptNormal",
                     "TelescopePromptBorder", "TelescopeResultsNormal",
                     "TelescopeResultsBorder", "TelescopePreviewNormal",
                     "TelescopePreviewBorder"}

                for _, group in ipairs(transparent_groups) do
                    vim.api.nvim_set_hl(0, group, {
                        bg = "none"
                    })
                end
            end
        })
    end
}

-- =============================================================================
-- COLORSCHEME NOTES
-- =============================================================================
-- To change colorscheme:
-- 1. Change the plugin spec above (e.g., "folke/tokyonight.nvim")
-- 2. Update the config function to use the new colorscheme
-- 3. Run :Lazy sync to install
-- 4. Restart Neovim
--
-- Popular alternatives:
-- - folke/tokyonight.nvim (modern, clean)
-- - catppuccin/nvim (pastel, many variants)
-- - ellisonleao/gruvbox.nvim (retro, warm)
-- - navarasu/onedark.nvim (VS Code style)
-- =============================================================================
