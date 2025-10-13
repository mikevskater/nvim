-- ~\AppData\Local\nvim\lua\myconfig\plugins\autopairs.lua
-- =============================================================================
-- AUTO-PAIRS - Auto-close Brackets/Quotes
-- =============================================================================
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",

    opts = {
        -- =======================================================================
        -- CORE SETTINGS
        -- =======================================================================
        check_ts = false, -- Don't use treesitter for pair checking
        ts_config = {
            lua = {'string'}, -- Don't add pairs inside lua strings
            javascript = {'template_string'} -- Don't add pairs in JS template strings
        },

        -- =======================================================================
        -- BEHAVIOR SETTINGS
        -- =======================================================================
        disable_filetype = {"TelescopePrompt", "spectre_panel", "vim"},
        disable_in_macro = true, -- Disable when recording macros
        disable_in_visualblock = false, -- Keep enabled in visual block mode
        disable_in_replace_mode = true, -- Disable in replace mode
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=], -- Don't pair if next char is word/special

        enable_moveright = true, -- Move right when closing pair
        enable_afterquote = true, -- Add bracket pairs after quotes
        enable_check_bracket_line = true, -- Check for existing closing brackets
        enable_bracket_in_quote = true, -- Allow brackets inside quotes
        enable_abbr = false, -- Don't trigger abbreviations
        break_undo = true, -- Break undo sequence for each pair

        -- =======================================================================
        -- KEY MAPPINGS
        -- =======================================================================
        map_cr = true, -- Map <CR> to handle pairs
        map_bs = true, -- Map <BS> to delete pairs
        map_c_h = false, -- Don't map <C-h> (can conflict with other plugins)
        map_c_w = false, -- Don't map <C-w> (preserve window commands)

        -- =======================================================================
        -- FAST WRAP - Quick wrapping of text with pairs
        -- =======================================================================
        -- Usage: Type an opening bracket, then press <M-e> and select target position
        -- Example: (|foobar  <M-e> $  →  (foobar|)
        fast_wrap = {
            map = '<M-e>', -- Alt+e to trigger fast wrap
            chars = {'{', '[', '(', '"', "'"}, -- Pairs that can be fast-wrapped
            pattern = [=[[%'%"%>%]%)%}%,]]=], -- Pattern to find wrap positions
            end_key = '$', -- Key to wrap at end of line
            before_key = 'h', -- Key to wrap before target
            after_key = 'l', -- Key to wrap after target
            cursor_pos_before = true, -- Cursor before closing pair
            keys = 'qwertyuiopzxcvbnmasdfghjkl', -- Quick selection keys
            manual_position = true, -- Show position hints
            highlight = 'Search', -- Highlight for selection keys
            highlight_grey = 'Comment' -- Grey out wrapped area
        }
    },

    -- ===========================================================================
    -- KEYMAPS - Toggle auto-pairs functionality
    -- ===========================================================================
    keys = {{
        "<leader>ap",
        function()
            require("nvim-autopairs").toggle()
        end,
        mode = "n",
        desc = "\u{f074} Toggle Auto-pairs" --  (random/shuffle)
    }, {
        "<leader>ape",
        function()
            require("nvim-autopairs").enable()
        end,
        mode = "n",
        desc = "\u{f00c} Enable Auto-pairs" --  (check)
    }, {
        "<leader>apd",
        function()
            require("nvim-autopairs").disable()
        end,
        mode = "n",
        desc = "\u{f00d} Disable Auto-pairs" --  (times/x)
    }},

    config = function(_, opts)
        require("nvim-autopairs").setup(opts)
        
        -- ===================================================================
        -- COMPLETION INTEGRATION (if using nvim-cmp)
        -- ===================================================================
        -- Only attempt integration if nvim-cmp is installed
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end
    end,
}

-- =============================================================================
-- AUTO-PAIRS NOTES
-- =============================================================================
-- This plugin automatically:
-- - Closes brackets: ( ) [ ] { }
-- - Closes quotes: " ' `
-- - Handles deletion: pressing <BS> on (|) deletes both
-- - Smart moving: pressing ) when next to ) moves cursor right
-- - Line breaks: pressing <CR> inside {} adds proper indentation
--
-- FAST WRAP FEATURE (<M-e>):
-- 1. Type opening bracket: (|foobar
-- 2. Press <M-e> to activate fast wrap
-- 3. Press a key to select target position:
--    - Letter keys (q,w,e...) jump to positions
--    - $ wraps at end of line
--    - h wraps before target, l wraps after target
-- 4. Result: (foobar|) or other wrapped text
--
-- TOGGLE COMMANDS:
-- <leader>ap  - Toggle auto-pairs on/off (useful before pasting)
-- <leader>ape - Enable auto-pairs explicitly
-- <leader>apd - Disable auto-pairs explicitly
--
-- AUTOMATIC MAPPINGS (handled by plugin):
-- <CR> - Break line with proper indentation inside pairs
-- <BS> - Delete matching pair when between empty pairs
-- ) ] } - Move right when next char is closing bracket (enable_moveright)
--
-- ADVANCED USAGE:
-- - Add custom rules: require("nvim-autopairs").add_rules({...})
-- - Remove rules: require("nvim-autopairs").remove_rule('(')
-- - Clear all: require("nvim-autopairs").clear_rules()
-- - Check status: require("nvim-autopairs").state.disabled
-- =============================================================================
