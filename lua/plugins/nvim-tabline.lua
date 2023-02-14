local plugin = {
    "crispgm/nvim-tabline",
    enabled = false,
    config = function()
        require("tabline").setup({})
    end,
}

return plugin
