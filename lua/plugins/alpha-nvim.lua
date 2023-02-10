-- Welcome screen
local plugin = {
    "goolord/alpha-nvim",
    config = function()
        local alpha = require("alpha")
        local config = require("alpha.themes.startify").config
        alpha.setup(config)
    end,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
}

return plugin
