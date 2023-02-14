-- Installer for linters, LSPs, DAPs, etc.
local plugin = {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end,
}

return plugin
