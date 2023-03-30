-- Go
local plugin = {
    "ray-x/go.nvim",
    config = function()
        require("go").setup()
    end,
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "ray-x/guihua.lua",
    },
    event = {
        "CmdlineEnter",
    },
    ft = {
        "go",
        "gomod",
    },
}

return plugin
