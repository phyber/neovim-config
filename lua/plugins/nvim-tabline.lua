local plugin = {
    "crispgm/nvim-tabline",
    config = function()
        require("tabline").setup()
    end,
}

return plugin
