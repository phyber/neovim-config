-- Git diff status in the sidebar
local plugin = {
    "lewis6991/gitsigns.nvim",
    config = function()
        local config = {
            debug_mode = false,
        }

        require("gitsigns").setup(config)
    end,
}

return plugin
