-- Language server plugins
local plugin = {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        null_ls.setup({
            sources = {
                diagnostics.cfn_lint,
                diagnostics.luacheck,
                diagnostics.shellcheck,
                diagnostics.yamllint,
                formatting.goimports,
            },
        })
    end,
}

return plugin
