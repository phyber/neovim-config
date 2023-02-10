-- Completion
local plugin = {
    "hrsh7th/nvim-cmp",
    config = function()
        require("cmp").setup({
            sources = {
                { name = "nvim_lsp" },
            },
        })
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
}

return plugin
