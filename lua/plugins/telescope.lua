-- Fuzzy finder
local plugin = {
    "nvim-telescope/telescope.nvim",
    cond = function()
        local util = require "util"

        return util.nvim_has("nvim-0.6")
    end,
    config = function()
        local util = require "util"

        local key = "<Leader>%s"
        local command = ":Telescope %s<CR>"

        local keys = {
            fb = "buffers",
            ff = "find_files",
            fg = "live_grep",
            fh = "help_tags",
        }

        for combo, cmd in pairs(keys) do
            util.nnoremap(key:format(combo), command:format(cmd))
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
