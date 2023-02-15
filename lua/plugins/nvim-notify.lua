-- Notifications
local plugin = {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
        require("notify").setup({
            render = "compact",

            icons = {
                DEBUG = "D",
                ERROR = "E",
                INFO = "I",
                TRACE = "T",
                WARN = "W",
            },
        })
    end,
}

return plugin
