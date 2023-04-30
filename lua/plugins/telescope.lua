-- Fuzzy finder
local plugin = {
    "nvim-telescope/telescope.nvim",
    cond = function()
        return require("util").nvim_has("nvim-0.6")
    end,
    config = function()
        local keymap = require "keymap"

        local key = "<Leader>%s"
        local command = ":Telescope %s<CR>"

        local keys = {
            fb = "buffers",
            ff = "find_files",
            fg = "live_grep",
            fh = "help_tags",
        }

        for combo, cmd in pairs(keys) do
            keymap.nnoremap(key:format(combo), command:format(cmd))
        end
    end,
    -- Plugin is only loaded when any of these keys are pressed.
    keys = {
        -- All are mode="n"
        {"<Leader>fb", desc = "Find buffer"},
        {"<Leader>ff", desc = "Find files"},
        {"<Leader>fg", desc = "Live grep"},
        {"<Leader>fh", desc = "Help tags"},
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

return plugin
