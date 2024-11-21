-- Language server plugins
local plugin = {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        null_ls.setup({
            sources = {
                diagnostics.cfn_lint,
                diagnostics.yamllint,
                formatting.goimports,
                require("none-ls-luacheck.diagnostics.luacheck"),
                require("none-ls-shellcheck.diagnostics"),
            },
        })
    end,
    dependencies = {
        "gbprod/none-ls-luacheck.nvim",
        "gbprod/none-ls-shellcheck.nvim",
    },
}

return plugin
