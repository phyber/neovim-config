-- Git diff status in the sidebar
local plugin = {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

return plugin
