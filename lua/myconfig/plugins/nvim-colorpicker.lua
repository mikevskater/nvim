-- nvim-colorpicker lazy.nvim configuration
-- Add this to your lazy.nvim plugin specs

return {
    -- Dependency for nvim-colorpicker UI
    {"mikevskater/nvim-float", lazy = true},
    -- Core color picker plugin setup
    {"mikevskater/nvim-colorpicker", 
        lazy = true,
        event = {"BufReadPre", "BufNewFile"},
        opts = {
            -- Default config options used just to show how you can change settings.
            -- These can just be deleted if you dont want to change anything.
            -- Check [.lua/config.lua] for all available overrides.
            highlight = {
                enable = true,
                mode = 'virtualtext',
                --swatch_char = "██"
            },
        },
        keys = {
            -- Replace the Color under cursor using the picker
            { "<leader>crp", "<cmd>ColorPickerAtCursor<cr>", desc = "Replace Color at Cursor: Color Picker Full" },
            { "<leader>crm", "<cmd>ColorPickerMiniAtCursor<cr>", desc = "Replace Color at Cursor: Color Picker Mini" },
            -- Insert a color at the cursor using the picker
            { "<leader>cip", "<cmd>ColorPicker<cr>", desc = "Color Picker Full and Insert Color" },
            { "<leader>cim", "<cmd>ColorPickerMini<cr>", desc = "Color Picker Mini and Insert Color" },
            -- Color Conversion Keybindings
            { "<leader>crg", "<cmd>ColorConvert rgb<cr>", desc = "Convert Color to RGB" },
            { "<leader>chs", "<cmd>ColorConvert hsl<cr>", desc = "Convert Color to HSL" },
            { "<leader>ccm", "<cmd>ColorConvert cmyk<cr>", desc = "Convert Color to CMYK" },
            { "<leader>che", "<cmd>ColorConvert hex<cr>", desc = "Convert Color to HEX" },
        },
    },
}
