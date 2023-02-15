-- File explorer
local plugin = {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            icons = {
                show = {
                    file = false,
                },
            },
        })
    end,
}

return plugin
