-- File explorer
local plugin = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            renderer = {
                icons = {
                    show = {
                        file = false,
                    },
                },
            },
        })
    end,
}

return plugin
