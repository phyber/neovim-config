-- Language server plugins
local plugin = {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.formatting.goimports,
            },
        })
    end,
}

return plugin
