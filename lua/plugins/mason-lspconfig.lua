-- LSP config for Mason
local plugin = {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup()
    end,
    dependencies = {
        "williamboman/mason.nvim",
    },
}

return plugin
